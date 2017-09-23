namespace :crawler do
  desc 'Download all video labels'
  task :label => :environment do
    create()
  end

  desc 'Update all video labels'
  task :label_update => :environment do
    update()
  end
end

# --- Method ---
def download_actor_videos_label(actor_id, method)
  firsturl = "#{$JAVLIBRARY_URL}/cn/vl_star.php?s=#{actor_id}"
  baseurl = "#{$JAVLIBRARY_URL}/cn/vl_star.php?&mode=2&s=#{actor_id}&page="
  response = Mechanize.new do |agent|
    # Set timeout preference here
    agent.open_timeout = 5
    agent.read_timeout = 5
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


  result = []
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
