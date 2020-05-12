# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  album_id   :bigint
#  ord        :integer          not null
#  bonus      :boolean          default(FALSE)
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Track < ApplicationRecord
    validates :name, :ord, :bonus, presence: true

    belongs_to :album
    validates_associated :album

    has_one :band,
      through: :album

    has_many :notes,
      dependent: :destroy

end
