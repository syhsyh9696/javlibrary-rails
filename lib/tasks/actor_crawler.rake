namespace :crawler do
  desc 'Download all actors'
  task :actor => :environment do
    get_all_actors()
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
