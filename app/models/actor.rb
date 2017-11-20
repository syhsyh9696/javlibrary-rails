class Actor < ApplicationRecord
  # Actor: actor_label should be unique
  validates :actor_label, uniqueness: true

  has_and_belongs_to_many :videos
  has_and_belongs_to_many :users, -> { distinct }

  def followers
    self.users.size
  end

  def first_year
    Time.new(self.videos.sort_by(&:release_date).first.release_date).year
  end

  def annual
    last_time = Time.new.year; annual_info = Hash.new
    self.first_year.upto(last_time) do |year|
      count = 0
      self.videos.map do |video|
        count += 1 if video.release_date[0..3] == year.to_s
      end
      annual_info[year] = count
    end

    annual_info
  end

  def videos_dataset
    info = self.annual; index_result = []; result = {}
    info.each { |index, value| index_result << index }
    result['labels'] = index_result; result['values'] = info.values
    result
  end

  def genres_dataset
    result = Hash.new
    self.videos.each do |video|
      video.genres.each do |genre|
        result[genre.name] = 1 if result[genre.name] == nil
        result[genre.name] += 1
      end
    end
    
  end
end
