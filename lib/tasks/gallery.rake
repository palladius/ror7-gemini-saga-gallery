#require 'active_support/core_ext/file/path'
#require 'pathname' # https://apidock.com/ruby/Pathname/relative_path_from
require 'json'

DefaultMaxElements = '2' # in debug..
DefaultDebugActivated = false
SupportedMediaTypes = ['picture'] # in the future - video!
DebugActivated = ENV.fetch('DEBUG', DefaultDebugActivated).to_s.downcase == 'true'
MaxElements = ENV.fetch('MAX_ELEMENTS', DefaultMaxElements).to_i


def read_json_file(file_path)
  begin
    file_contents = File.read(file_path)
    data = JSON.parse(file_contents)
  rescue Errno::ENOENT => e
    raise "File not found: #{e.message}"
  rescue JSON::ParserError => e
    raise "Invalid JSON format: #{e.message}"
  rescue StandardError => e
    raise "An unexpected error occurred: #{e.message}"
  end

  data
end


namespace :gallery do
  desc "Import local files to the database - powered by Gemini"
  task :import_local_files_to_db => :environment do
    print("TODO only do max_elements = {max_elements}. Change with MAX_ELEMENTS=42 ... ")
    n_files_computed = 0
    sagallery_subpath = 'app/assets/images/saga-gallery'
    def relative_path(full_path, base_path)
      # ricc_pathname = full_path.sub(base_path, '')
      # puts("3. Pathname: #{ricc_pathname}")
      full_path.sub(base_path, '').sub(%r{^/}, '') # Remove base path and leading slash
    end

    # Iterate through folders -> Galleries.
    Dir.glob("#{Rails.root}/#{sagallery_subpath}/*") do |full_gallery_path|

      next unless File.directory?(full_gallery_path)
      puts("[DEB] folder found: '#{full_gallery_path}'") if DebugActivated # full path

      gallery_title = File.basename(full_gallery_path)
      gallery = Gallery.find_or_create_by(title: gallery_title)
      puts("💚 Gallery found! => #{gallery}")



      # Iterate through files -> Images.
      Dir.glob("#{full_gallery_path}/*") do |image_path|
        next unless File.file?(image_path)

        # Validate file extension
        file_extension = File.extname(image_path).downcase[1..] # Extract extension and convert to lowercase
        media_type = case file_extension
                     when 'jpg', 'jpeg', 'gif', 'png' then 'picture'
                     when 'mov' then 'video'
                     else nil # next # Skip unsupported file types
                     end
        puts("[DEB] File found: '#{image_path}' -> #{media_type}") if DebugActivated # full path#

#        next unless media_type in SupportedMediaTypes
        next unless SupportedMediaTypes.include?(media_type )
        puts("💚 Processing vetted filetype: '#{image_path}'")

        image_title = File.basename(image_path)

        # checking if too many
        n_files_computed += 1
        if n_files_computed > MaxElements
            puts("Too many files reached: #{n_files_computed}! Exiting")
            #return n_files_computed - you cant return inside a block!
            break
        end

        puts("1. image_path: #{image_path}")

        hash = {}
        if File.exist?(image_path + '.gemini_scuba_annotation.json')
          puts("Found JSON! With the power of Gemini!!!")
          hash = read_json_file(image_path + '.gemini_scuba_annotation.json')
          puts(hash.keys.join(' #️⃣ '))
        end
        medium = Medium.find_or_create_by(title: image_title, path: relative_path(image_path, Rails.root.to_s)) do |m|
          m.media_type = media_type
          m.gallery = gallery
          m.original_filename = image_path # looong

          # Gemini info from JSON!
          m.caption = hash.fetch 'caption', "Caption unavailable"
          if hash
            m.gemini_relevance = hash.fetch('relevance',nil)
            m.gemini_quality = hash.fetch('quality',nil)
            m.gemini_description = "Caption: #{hash.fetch 'caption', nil}
            Technicalities: #{hash.fetch('technicalities',hash.fetch('technicalities',':/'))}
            Life Forms: #{hash.fetch 'life_forms', nil}"
            m.gemini_text = hash.to_s
          end
          # # Attach the file using Active Storage
          # m.file.attach(io: File.open(image_path), filename: File.basename(image_path))
          m.medium_file.attach(io: File.open(image_path), filename: File.basename(image_path), content_type: "image/#{file_extension}")
          # Extract image properties using Active Storage
          if m.medium_file.attached? && m.medium_file.image?
            m.dimensions = "#{m.medium_file.metadata[:width]}x#{m.medium_file.metadata[:height]}"
            m.file_size = m.medium_file.blob.byte_size
          end

        end
        puts("💚 Saved or already existing Medium: #{medium}")

        if gallery.cover_image_id.nil?
          gallery.update(cover_image_id: medium.id)
          # upload cover image to gallery
          gallery.cover_image_file.attach(
            io: File.open(image_path),
            filename: File.basename(image_path),
            content_type: "image/#{file_extension}")
        end
      end
    end
  end
end
