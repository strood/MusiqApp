# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  band_id    :integer
#  title      :string
#  year       :integer
#  live       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Album < ApplicationRecord
  validates :title, :year, presence: true
  # validate :valid_track_order
  # Not currently working

  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: :Band

  validates_associated :band

  has_many :tracks,
    dependent: :destroy

    # Not currently working.
  # def valid_track_order
  #   ords = self.tracks.each.select { |track| track.ord }
  #   if ords != ords.uniq
  #     flash[:errors] = ["Tracks must have distinct ord"]
  #   end
  # end

  def complete?
    if self.band_id.nil? || self.title.nil? || self.year.nil?
      return false
    else
      return true
    end
  end


  def self.valid_year?(year)
    if year <= 2020 && year > 1
      return true
    else
      return false
    end
  end
end
