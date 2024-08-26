APP_VERSION = File.read('VERSION').chomp
APP_NAME = "♊🖼️ Sagallery"
APP_DESCRIPTION = "An application built for Gemini to look at an album picture, vet them and present them intelligently an
d automatically (removing blurred ones, etc..)"

##########################################################
# constant start for CRun..
RAILS_MASTER_KEY = ENV.fetch('RAILS_MASTER_KEY', nil).to_s
SECRET_KEY_BASE = ENV.fetch('SECRET_KEY_BASE', nil).to_s

def cutey_finestrella
  puts("🖼️ "*40)
  puts("🖼️🌞 APP_NAME:               #{ENV.fetch 'APP_NAME', nil}")
  puts("🖼️🌞 RAILS_ENV:              #{ENV.fetch 'RAILS_ENV', nil}")
  puts("🖼️🌞 Rails.env:              #{Rails.env}")
  puts("🖼️🌞 MESSAGGIO_OCCASIONALE:  #{ENV.fetch 'MESSAGGIO_OCCASIONALE', nil}")
  puts("🖼️🌞 SKAFFOLD_DEFAULT_REPO:  #{ENV.fetch('SKAFFOLD_DEFAULT_REPO', nil)}")
  puts("🖼️🔑 RAILS_MASTER_KEY.frst5: #{RAILS_MASTER_KEY.first 5}")
  puts("🖼️🔑 RAILS_MASTER_KEY.size:  #{RAILS_MASTER_KEY.length}")
  puts("🖼️🔑 SECRET_KEY_BASE.frst5:  #{SECRET_KEY_BASE.first 5}")
  puts("🖼️🔑 SECRET_KEY_BASE.size:   #{SECRET_KEY_BASE.length}")
  puts("🖼️"*80)
##########################################################
  :cutey_finestrella_all_good
end

x = cutey_finestrella rescue "🖼️🖼️🖼️🖼️🖼️ :( Some issues: #{$!}"
puts(x)
