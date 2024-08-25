#require 'active_support/core_ext/file/path'
#require 'pathname' # https://apidock.com/ruby/Pathname/relative_path_from

namespace :gallery do
  desc "Import local files to the database - powered by Gemini"
  task :import_local_files_to_db => :environment do
    sagallery_subpath = 'app/assets/images/saga-gallery'
    def relative_path(full_path, base_path)
      # ricc_pathname = full_path.sub(base_path, '')
      # puts("3. Pathname: #{ricc_pathname}")
      full_path.sub(base_path, '').sub(%r{^/}, '') # Remove base path and leading slash
    end

    Dir.glob("#{Rails.root}/#{sagallery_subpath}/*") do |full_gallery_path|

      next unless File.directory?(full_gallery_path)
      puts("[DEB] folder found: '#{full_gallery_path}'") # full path

      gallery_title = File.basename(full_gallery_path)
      gallery = Gallery.find_or_create_by(title: gallery_title)
      puts("💚 Gallery found! => #{gallery}")


      #
      Dir.glob("#{full_gallery_path}/*") do |image_path|
        next unless File.file?(image_path)
        puts("[DEB] File found: '#{image_path}'") # full path#


        # Validate file extension
        file_extension = File.extname(image_path).downcase[1..] # Extract extension and convert to lowercase
        media_type = case file_extension
                     when 'jpg', 'jpeg', 'gif', 'png' then 'picture'
                     when 'mov' then 'video'
                     else next # Skip unsupported file types
                     end

        image_title = File.basename(image_path)
        #print("1. image_path: #{image_path}")
        #print("2. Rails root: #{Rails.root}")
        medium = Medium.find_or_create_by(title: image_title, path: relative_path(image_path, Rails.root.to_s)) do |m|
          m.media_type = media_type
          m.gallery = gallery
          m.original_filename = image_path # looong
          # Add more attributes or ActiveStorage attachment here if needed

          # # Attach the file using Active Storage
          # m.file.attach(io: File.open(image_path), filename: File.basename(image_path))
          m.medium_file.attach(io: File.open(image_path), filename: File.basename(image_path), content_type: "image/#{file_extension}")
          #     # Extract image properties using Active Storage
          if m.medium_file.attached? && m.medium_file.image?
            m.dimensions = "#{m.medium_file.metadata[:width]}x#{m.medium_file.metadata[:height]}"
            m.file_size = m.medium_file.blob.byte_size
            m.caption = "Blah blah blah (TODO change me) - #{m.medium_file.blob.byte_size}"
          end

        end
        puts("💚 Saved or already existing Medium: #{medium}")

        if gallery.cover_image_id.nil?
          gallery.update(cover_image_id: medium.id)
        end
      end
    end
  end
end
