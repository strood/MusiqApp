# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 500 }

  belongs_to :track

  belongs_to :user
end
