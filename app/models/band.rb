# == Schema Information
#
# Table name: bands
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Band < ApplicationRecord
  validates :name, presence: true

  has_many :albums,
    dependent: :destroy
end
