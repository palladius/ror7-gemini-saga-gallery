
dev:
	rake assets:precompile
	rails s


import:
	rake gallery:import_local_files_to_db


destroy-and-reimport-YES-I_AM_SURE:
	RAILS_ENV=development rake db:drop || echo this fails but it doesnt..
	bin/rails db:migrate
	rake gallery:import_local_files_to_db
