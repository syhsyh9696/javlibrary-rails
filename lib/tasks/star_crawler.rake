namespace :crawler do
  desc 'Download all stars'
  task :star => :environment do
    Star.delete_all
    get_all_actors()
  end
end

# --- Method ---
def get_all_stars
  url = "#{$JAVLIBRARY_URL}/cn/star_mostfav.php"

  response = Mechanize.new do |agent|
    # Set timeout preference here
    agent.open_timeout = 5
    agent.read_timeout = 5
  end
  response.get url

  doc = response.page.body
  doc.search("//div[@class='starbox']/div[@class='searchitem']").each do |item|
    pp item
  end
end
