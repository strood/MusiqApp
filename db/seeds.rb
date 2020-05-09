# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  Band.destroy_all
  Album.destroy_all
  Track.destroy_all
  # Make Bands
  30.times do
    Band.create!(name: Faker::Music.band)
  end
  # Make Albums
  60.times do
    Album.create!(band_id: Faker::Number.between(from:1, to:30), title: Faker::Music.album, year: Faker::Number.between(from:1900, to:2020))
  end

  # Make Tracks
  120.times do
    Track.create!(album_id: Faker::Number.between(from:1, to:60), name: Faker::Device.manufacturer, ord: Faker::Number.between(from:1, to:10), lyrics: Faker::Quote.matz.split(". ").join("\r\n"), bonus: true)
  end
end
