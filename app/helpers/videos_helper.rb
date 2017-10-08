module VideosHelper
  def format_video_name(str)
    str = str[0..-1] if str.size < 30
    str = str[0..30] + "···" if str.size >= 30
    str
  end

  def video_genres(video)
    genres = []
    video.genres.each do |genre|
      genres << genre.name
    end
    genres
  end

  def video_rating_format(rating)
    return '0.0' if rating == ''
    rating
  end
end
