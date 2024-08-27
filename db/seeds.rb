# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "rake"

#Rails.application.load_tasks
def seed_print(s) = puts("🍉 [seed] #{s}")
def count_elements()
   $n_galleries = Gallery.count

   $n_media = Medium.count
   seed_print("#{Gallery.emoji} Gallery.count: #{$n_galleries}")
   seed_print("#{Medium.emoji} Medium.count: #{$n_media}")
end
seed_print("START")
count_elements

if $n_media == 0 && $n_galleries == 0 #|| true
   seed_print('DB seems empty. Time for raking some pictures in via: MAX_ELEMENTS=100 rake gallery:import_local_files_to_db');
   Rake::Task["gallery:import_local_files_to_db"].invoke # (env: { "MAX_ELEMENTS" => 10 })
   seed_print('DB replenished'); count_elements
else
   seed_print('System has some Galleries/Media so my job here is done');
end
seed_print("END")
