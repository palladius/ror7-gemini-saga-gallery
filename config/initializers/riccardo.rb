APP_VERSION = File.read('VERSION').chomp
APP_NAME = "♊🖼️ Sagallery"
APP_DESCRIPTION = "An application built for Gemini to look at an album picture, vet them and present them intelligently an
d automatically (removing blurred ones, etc..)"

puts("🖼️ "*40)
puts("🖼️🌞 APP_NAME:         #{ENV.fetch 'APP_NAME', nil}")
puts("🖼️🌞 RAILS_ENV:        #{ENV.fetch 'RAILS_ENV', nil}")
puts("🖼️🔑 RAILS_MASTER_KEY: #{ENV.fetch('RAILS_MASTER_KEY', nil).to_s.first 5}")
puts("🖼️🌞 SKAFFOLD_DEFAULT_REPO: #{ENV.fetch('SKAFFOLD_DEFAULT_REPO', nil)}")

puts("🖼️"*80)
