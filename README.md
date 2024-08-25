# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version:
* Raisl version: `7.2.1` (super new from aug 24!)

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Reproducing CLI Rails steps

```
# Create gallery with latest devcontainer.
rails new ror7-gemini-saga-gallery --devcontainer --database=postgresql
# ensuring ruby 3.3 to ensure YJIT is auto added.
echo 3.3.4 > .ruby-version
# ensuring rails is in the new ruby version.
bundle install

####################
# Scaffolds
####################

# Gallery first
rails generate scaffold Gallery title:string description:text public:boolean cover_image_id:integer user_id:integer

# Create Image - which could both on DB or on File (with utlities to brings 1 <--> 2)
rails g model medium title:string path:string caption:text gemini_relevance:float gemini_quality:float gemini_description:text \
    gemini_text:text
```
