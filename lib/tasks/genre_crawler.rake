namespace :crawler do
  desc 'Download all genres'
  task :genre => :environment do
    get_all_genres()
  end
end

# --- Method ---

def get_all_genres
  response = Mechanize.new; genres = Array.new
  response.get "#{$JAVLIBRARY_URL}/cn/genres.php"

  Nokogiri::HTML(response.page.body).search('//div[@class="genreitem"]/a').each do |row|
    genres << row.children.text
  end
  genres.uniq

  genres.each do |item|
    genre = Genre.new; genre.name = item; genre.save
  end
end
