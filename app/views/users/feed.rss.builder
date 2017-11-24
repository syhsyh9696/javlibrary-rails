xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Videos"
    xml.description "User " + @user.username
    xml.link "http://www.syhdaily.com"

    @videos.each do |video|
      xml.item do
        xml.title video.video_name
        xml.description video.actors_string
        xml.pubDate video.created_at.to_s(:rfc822)
        xml.link video_url(video)
        xml.guid video_url(video)
      end
    end
  end
end
