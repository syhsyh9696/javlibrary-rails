namespace :crawler do
  desc 'Download all actors'
  task :actor => :environment do
    get_all_actors()
  end

  desc 'Get all javbus actors labels'
  task :javbus_label => :environment do
    get_all_actors_label_from_javbus()
  end

  desc 'Format all javbus labels(remove "nowprinting.gif")'
  task :javbus_label_format => :environment do
    format_javbus_labels()
  end
end

# --- Method ---
def get_all_actors
  firsturl = "#{$JAVLIBRARY_URL}/cn/star_list.php?prefix="

  'A'.upto('Z') do |alphabet|
    response = Mechanize.new
    tempurl = firsturl + alphabet
    response.get tempurl

    doc = Nokogiri::HTML(response.page.body)
    last_page = author_page_num(doc)

    1.upto(last_page) do |page_num|
      temp_page_url = tempurl + "&page=#{page_num.to_s}"
      response.get temp_page_url

      doc_page = Nokogiri::HTML(response.page.body)
      doc_page.search('//div[@class="starbox"]/div[@class="searchitem"]/a').each do |row|
        # row.text Actor.name
        # row['href'].split("=")[-1] Actor.label
        name = row.text; label = row['href'].split("=")[-1]
        actor = Actor.new
        actor.name = name
        actor.actor_label = label
        actor.actor_type = alphabet
        actor.save
      end
    end
  end
end

def author_page_num(nokogiri_doc)
  last_page = 1
  nokogiri_doc.search('//div[@class="page_selector"]/a[@class="page last"]').each do |row|
      last_page = row['href'].split("=")[-1].to_i
  end
  last_page
end

# Max page https://www.javbus2.pw/actresses/717
JAVBUS_MAX_PAGE = 717

def get_all_actors_label_from_javbus
  page = Mechanize.new
  firsturl = "https://www.javbus2.pw/actresses/"
  #1.upto(JAVBUS_MAX_PAGE).each do |num|
  1.upto(JAVBUS_MAX_PAGE).each do |num|
    url = firsturl + num.to_s
    doc = Nokogiri::HTML(page.get(url).body)
    doc.search('//div[@id="waterfall"]/div/a/div[1]/img').each do |item|
      label = item.attributes['src'].value.split('/')[-1].split('_')[0]
      name = item.attributes['title'].value.split('（')[0].strip

      next if label == "nowprinting.gif"

      actor = Actor.where('name = ?', name).first
      next if actor == nil

      actor.javbus_label = label
      actor.save
    end
  end
end

def format_javbus_labels
  Actor.all.each do |actor|
    if actor.javbus_label == "nowprinting.gif"
      actor.javbus_label = nil
      actor.save
    end
  end
end
