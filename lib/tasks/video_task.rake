

# --- Method ---
def downloader(identifer)
  baseurl = "http://www.#{@url}/cn/?v=#{identifer}"
  response = Mechanize.new do |agent|
    agent.read_timeout = 2
    agent.open_timeout = 2
    agent.user_agent = Mechanize::AGENT_ALIASES.values[rand(21)]
  end

  begin
    response.get baseurl
  rescue Timeout::Error
    retry
  rescue
    return
  end

  doc = Nokogiri::HTML(response.page.body)

  video_title, details, video_genres, video_jacket_img = String.new, Array.new, String.new, String.new

  video_title = doc.search('div[@id="video_title"]/h3/a').children.text
  doc.search('//div[@id="video_info"]/div[@class="item"]/table/tr/td[@class="text"]').map do |row|
    details << row.children.text
  end
  pp details

  doc.search('//div[@id="video_genres"]/table/tr/td[@class="text"]/span[@class="genre"]/a').each do |row|
    video_genres << row.children.text << " "
  end

  doc.search('//img[@id="video_jacket_img"]').each do |row|
    video_jacket_img = row['src']
  end

  # return data format: title$id$date$director$maker$label$cast$genres$img_url
  "#{video_title}$#{details[0]}$#{details[1]}$#{details[2]}$#{details[3]}$#{details[4]}$#{details[-1]}$#{video_genres}$#{video_jacket_img}"
  #result = Hash.new
  #result["title"] = video_title; result["id"] = details[0]; result["date"] = details[1]
  #result["director"] = details[2]; result["maker"] = details[3]; result["label"] = details[4]
  #result["cast"] = details[-1]; result["genres"] = video_genres; result["img_url"] = video_jacket_img
end
