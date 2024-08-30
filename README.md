# README

Self: https://github.com/palladius/ror7-gemini-saga-gallery/ (public)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version:
* Rails version: `7.2.1` (super new from aug 24!)
* Configuration: `.envrc`
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
    * Configure a new DB: `RAILS_ENV=production make destroy-and-reimport-YES-I_AM_SURE `

## Logo

Still WIP:

Add to github README this file: https://github.com/palladius/ror7-gemini-saga-gallery/blob/main/app/assets/images/gemini_no_saga_logo2.jpg

[![Project Logo](https://github.com/palladius/ror7-gemini-saga-gallery/blob/main/app/assets/images/gemini_no_saga_logo2.jpg)](https://github.com/palladius/ror7-gemini-saga-gallery/)

## TODOs

* transform the code into a GCF and apply to my OLD and NEW pictures with a trigger `OnGcsFileCreate()`


## Reproducing CLI Rails steps

```
# Create gallery with latest devcontainer.
rails new ror7-gemini-saga-gallery --devcontainer --database=postgresql
# ensuring ruby 3.3 to ensure YJIT is auto added.
echo 3.3.4 > .ruby-version
# ensuring rails is in the new ruby version.
bundle install

####################
# Scaffolds, models, controllers
####################

# Gallery
rails generate scaffold Gallery title:string description:text public:boolean cover_image_id:integer user_id:integer

# Image or video: Medium
# Create Image - which could both on DB or on File (with utlities to brings 1 <--> 2)
# Riccardo
rails g scaffold medium title:string path:string caption:text gemini_relevance:float gemini_quality:float gemini_description:text \
    gemini_text:text
# Gemini enhanced:
rails g scaffold Medium title:string path:string caption:text media_type:string gallery_id:integer \
  gemini_relevance:float gemini_quality:float gemini_description:text gemini_text:text \
  file_size:integer dimensions:string original_filename:string user_id:integer

# v0.4.5
rails generate controller Pages home about graphs contact



#####################
# tasks
##################
rails generate task gallery import_local_files_to_db



#####################
# javascript
######################
# install https://www.stimulus-components.com/docs/stimulus-lightbox for gallery
bin/importmap pin @stimulus-components/lightbox
# install https://www.stimulus-components.com/docs/stimulus-carousel for gallery
bin/importmap pin @stimulus-components/carousel
# install https://www.stimulus-components.com/docs/stimulus-timeago as its easy to debug JS with this..
bin/importmap pin @stimulus-components/timeago
# .. and follow all the instructions :)

# it doesnt work, lets add Tailwind!  => https://tailwindcss.com/docs/guides/ruby-on-rails
bin/bundle add tailwindcss-rails
bin/rails tailwindcss:install
```
## Journal of errors

### `2024-08-27`. docker issues

Running rails locally opened a few things:
1. Error: `The keyfile '/rails/private/ror-goldie-scooby-n-sagallery.json' is not a valid file.` I dont have it inside the container, need to add it to Secret Manager (as file) and symlink it from CRun. Sure. Easy peasy.
2. Bug in rails (I guess?):  in `bin/docker-entrypoint` it says: if you call me with `./bin/rails server` EXACTLY, you get to call the `./bin/rails db:prepare`. Which is awesome! Look, if I call it like `bin/rails s`, it doesnt and run perfectly.

```
🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️
🖼️🌞 GcsBucket:   ricc-public-saga-gallery-development
🖼️🌞 APP_NAME:
🖼️🌞 RAILS_ENV:              development
🖼️🌞 Rails.env:              development
🖼️🌞 MESSAGGIO_OCCASIONALE:
🖼️🌞 SKAFFOLD_DEFAULT_REPO:
🖼️🔑 RAILS_MASTER_KEY.frst5: REDACTED
🖼️🔑 RAILS_MASTER_KEY.size:  32
🖼️🔑 SECRET_KEY_BASE.frst5:
🖼️🔑 SECRET_KEY_BASE.size:   0
🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️
cutey_finestrella_all_good
Puma starting in single mode...
* Puma version: 6.4.2 (ruby 3.3.4-p94) ("The Eagle of Durango")
*  Min threads: 3
*  Max threads: 3
*  Environment: development
*          PID: 96
* Listening on http://127.0.0.1:3000
Use Ctrl-C to stop
```

I just need to do the -p 8080 as I do for the dockerfile.

While if I call it with the docker entrypoint normally, when it invokes the prepare, look:

```
rails@dd72d24f07a2:/rails$ ./bin/rails db:prepare
🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️ 🖼️
🖼️🌞 GcsBucket:   ricc-public-saga-gallery-development
🖼️🌞 APP_NAME:
🖼️🌞 RAILS_ENV:              development
🖼️🌞 Rails.env:              development
🖼️🌞 MESSAGGIO_OCCASIONALE:
🖼️🌞 SKAFFOLD_DEFAULT_REPO:
🖼️🔑 RAILS_MASTER_KEY.frst5: REDACTED
🖼️🔑 RAILS_MASTER_KEY.size:  32
🖼️🔑 SECRET_KEY_BASE.frst5:
🖼️🔑 SECRET_KEY_BASE.size:   0
🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️🖼️
cutey_finestrella_all_good
bin/rails aborted!
ActiveRecord::ConnectionNotEstablished: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: No such file or directory (ActiveRecord::ConnectionNotEstablished)
        Is the server running locally and accepting connections on that socket?


Caused by:
PG::ConnectionBad: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: No such file or directory (PG::ConnectionBad)
        Is the server running locally and accepting connections on that socket?

Tasks: TOP => db:prepare
(See full trace by running task with --trace)
```

### Actions

which is weird! Ok, this will be fixed as soon as I move everything to postgres.
But seriously, starting a project with postgres and than demote it to sqlite is a PITA gyros!
