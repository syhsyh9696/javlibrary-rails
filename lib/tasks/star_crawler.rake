namespace :crawler do
  desc 'Download all stars'
  task :star => :environment do
    Star.delete_all
    get_all_stars()
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

  doc = Nokogiri::HTML(response.page.body.gsub(/(&nbsp;|\s)+/, " "))
  doc.search("//div[@class='starbox']/div[@class='searchitem']").each do |item|
    star = Star.new
    star.id = item.search("./h3").text[1..2].to_i
    star.rank = item.search("./h3").text[1..2].to_i
    star.img = item.search("./table/tr/td/img")[0].attributes['src'].value
    star.name = item.search("./table/tr/td/img")[0].attributes['title'].value
    star.actor_label = item.search("./a")[0].attributes['href'].value.split('=')[-1]
    star.save
  end
end
