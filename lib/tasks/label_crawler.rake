namespace :crawler do
  desc 'Download all video labels'
  task :label => :environment do
    create()
  end

  desc 'Update all video labels'
  task :label_update => :environment do
    update()
  end

  desc 'Update all new release labels'
  task :labels_update_release => :environment do
    update_new_release()
  end
end

# --- Method ---
def download_actor_videos_label(actor_id, method)
  firsturl = "#{$JAVLIBRARY_URL}/cn/vl_star.php?s=#{actor_id}"
  baseurl = "#{$JAVLIBRARY_URL}/cn/vl_star.php?list&mode=2&s=#{actor_id}&page="
  response = Mechanize.new do |agent|
    # Set timeout preference here
    agent.open_timeout = 3
    agent.read_timeout = 3
  end

  begin
    response.get firsturl
  rescue
    return nil
  end

  doc = Nokogiri::HTML(response.page.body)

  # Judge method here(:update, :create)
  last_page = 1
  last_page = 1 if method == :update
  if method == :create
    doc.search('//div[@class="page_selector"]/a[@class="page last"]').each do |row|
      last_page = row['href'].split("=")[-1].to_i
    end
  end

  1.upto(last_page) do |page|
    tempurl = baseurl + page.to_s
    begin
      response.get tempurl
    rescue
      next
    end

    Nokogiri::HTML(response.page.body).search('//div[@class="video"]/a').each do |row|
      # Data:
      # Video_label: row['href'].split("=")[-1]
      # Video_title: row['title']

      label = Label.new
      label.video_label = row['href'].split("=")[-1]
      label.downloaded = false
      label.save
    end
  end

end

def create
  actors = Actor.all
  actors.each do |actor|
    download_actor_videos_label(actor.actor_label, :create)
  end
end

def update
  actors = Actor.all
  actors.each do |actor|
    download_actor_videos_label(actor.actor_label, :update)
  end
end

def update_new_release
  baseurl = "#{$JAVLIBRARY_URL}/cn/vl_newrelease.php?list&mode=2&page="
  response = Mechanize.new do |agent|
    # Set timeout preference here
    agent.open_timeout = 3
    agent.read_timeout = 3
  end

  1.upto(new_release_max_page()).each do |page|
    begin
      response.get(baseurl + page.to_s)
    rescue
      retry
    end

    Nokogiri::HTML(response.page.body).search('//div[@class="video"]/a').each do |row|
      # Data:
      # Video_label: row['href'].split("=")[-1]
      # Video_title: row['title']

      label = Label.new
      label.video_label = row['href'].split("=")[-1]
      label.downloaded = false
      label.save
    end
  end

end

def new_release_max_page
  baseurl = "#{$JAVLIBRARY_URL}/cn/vl_newrelease.php?list&mode=2&page="
  response = Mechanize.new do |agent|
    # Set timeout preference here
    agent.open_timeout = 3
    agent.read_timeout = 3
  end

  1.upto(20).each do |page|
    begin
      response.get(baseurl + page.to_s)
    rescue
      retry
    end
    doc = Nokogiri::HTML(response.page.body)
    label = doc.search('//div[@class="video"]/a')[0]['href'].split("=")[-1]

    return page - 1 if Label.where("video_label = ?", label).first != nil
  end # Upto page end
end # Method end
