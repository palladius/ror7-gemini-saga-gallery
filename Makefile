
install-mac:
	brew install vips
install-linux:
	sudo apt install libvips

dev: dev-troubleshot-js

dev-troubleshot-js:
	rake assets:precompile
	bin/dev

dev-old:
	rake assets:precompile
	rails s

# TODO check if its different dev and prod -= when needed.
credentials-edit:
	rails credentials:edit

import:
	MAX_ELEMENTS=100 rake gallery:import_local_files_to_db


destroy-and-reimport-YES-I_AM_SURE:
	RAILS_ENV=development rake db:drop || echo this fails but it doesnt..
	bin/rails db:migrate
	MAX_ELEMENTS=100 rake gallery:import_local_files_to_db
	echo Rebuilding assets..
	rake assets:precompile

docker-build:
	docker build .

# file is in GIC but soon in sakura.
gemini-generate-some-metadata:
	gopro-gemini-iterator.py app/assets/images/saga-gallery/  --max-files 5
gemini-generate-all-metadata:
	gopro-gemini-iterator.py app/assets/images/saga-gallery/  --max-files 123456
