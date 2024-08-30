# Needed in Derek.
SHELL := /bin/bash
VERSION = $(shell cat VERSION)

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
prod:
	RAILS_ENV=production rake assets:precompile
	RAILS_ENV=production bin/rails db:prepare
	RAILS_ENV=production MAX_ELEMENTS=100 rake gallery:import_local_files_to_db
	RAILS_ENV=production rails s
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

# DHH Tips:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app
docker-build:
	docker build -t "ror7-gemini-saga-gallery:$(VERSION)" .

docker-run-no-build: # docker-build
#yellow 'To stop: docker stop ror7-gemini-saga-gallery'
# Matt Daemon
	echodo docker run -d -p 8080:8080 -p 8443:443 \
		--name ror7-gemini-saga-gallery \
		-e RAILS_MASTER_KEY="$(RAILS_MASTER_KEY)" \
		-e PORT=8080 \
		-e RAILS_LOG_TO_STDOUT=yesplease \
		ror7-gemini-saga-gallery:$(VERSION)
docker-run: docker-build docker-run-no-build
docker-run-dev-no-build: # docker-build
#yellow 'To stop: docker stop ror7-gemini-saga-gallery-dev'
# to rm completely:  docker rm cc54092e2fe3a865d1518153cc423f5d69fdb8167e40253
# where the big hash isd given by error above.. given by docker kill.
	# directly
	echodo docker run -it -p 3000:3000 \
		--name ror7-gemini-saga-gallery-dev \
		-e RAILS_MASTER_KEY="$(RAILS_MASTER_KEY)" \
		-e RAILS_ENV=development \
		-e PORT=3000 \
		-e RAILS_LOG_TO_STDOUT=yesplease \
		ror7-gemini-saga-gallery:$(VERSION)


# file is in GIC but soon in sakura.
gemini-generate-some-metadata:
	gopro-gemini-iterator.py app/assets/images/saga-gallery/  --max-files 5
gemini-generate-all-metadata:
	gopro-gemini-iterator.py app/assets/images/saga-gallery/  --max-files 123456

# interesting! Seen here: https://guides.rubyonrails.org/configuring.html#configuring-a-database
db-inspect:
	bin/rails runner 'puts ActiveRecord::Base.configurations.inspect'
