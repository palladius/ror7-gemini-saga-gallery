# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version:
* Raisl version: `7.2.1` (super new from aug 24!)
* Configuration: `.envrc`
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions

## Logo

Still WIP:

gemini_no_saga_logo.jpg

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
