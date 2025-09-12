# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Dir.entries(Rails.root.join("app/assets/images")).each do |filename|
  if filename[-4..] == ".jpg"
    food = Food.exists?(name: filename[0..-5], image_filename: filename)
    if !food
      Food.create!(name: filename[0..-5], image_filename: filename, elo: 1200)
    end
  end
end
