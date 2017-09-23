namespace :crawler do
  desc 'Download all video label'
  task :label => :environment do
    select_actors()
  end
end

# --- Method ---
def download_actor_videos_label(actor_id)
  firsturl = "#{$JAVLIBRARY_URL}/cn/vl_star.php?s=#{actor_id}"
  baseurl = "#{$JAVLIBRARY_URL}/cn/vl_star.php?&mode=2&s=#{actor_id}&page="
  response = Mechanize.new do |agent|
    # Set timeout preference here
    agent.open_timeout = 5
    agent.read_timeout = 5
  end

  response.get firsturl

  doc = Nokogiri::HTML(response.page.body)
  last_page = 1
  doc.search('//div[@class="page_selector"]/a[@class="page last"]').each do |row|
    last_page = row['href'].split("=")[-1].to_i
  end

  result = []
  1.upto(last_page) do |page|
    tempurl = baseurl + page.to_s
    response.get tempurl

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

def select_actors
  actors = Actor.all
  actors.each do |actor|
    download_actor_videos_label(actor.actor_label)
  end
end
