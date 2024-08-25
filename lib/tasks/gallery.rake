# namespace :gallery do
#   desc "TODO"
#   task import_local_files_to_db: :environment do
#   end

# end

namespace :gallery do
  desc "Import local files to the database - powered by Gemini"
  task :import_local_files_to_db => :environment do
    sagallery_subpath = 'app/assets/images/saga-gallery'

    Dir.glob("#{Rails.root}/#{sagallery_subpath}/*") do |full_gallery_path|

      next unless File.directory?(full_gallery_path)
      puts("[DEB] folder found: '#{full_gallery_path}'") # full path

      gallery_title = File.basename(full_gallery_path)
      gallery = Gallery.find_or_create_by(title: gallery_title)
      puts("💚 Gallery found! => #{gallery}")


      #
      Dir.glob("#{full_gallery_path}/*") do |image_path|
        next unless File.file?(image_path)
        puts("[DEB] File found: '#{image_path}'") # full path

        image_title = File.basename(image_path)
        medium = Medium.find_or_create_by(title: image_title, path: image_path.relative_path_from(Rails.root)) do |m|
          # You can add more attributes here, e.g., media_type: 'picture', gallery: gallery, etc.
          # If you are using ActiveStorage, you might want to attach the file here.
        end

        if gallery.cover_image_id.nil?
          gallery.update(cover_image_id: medium.id)
        end
      end
    end
  end
end
