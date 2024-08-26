# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin_all_from "app/javascript/controllers", under: "controllers"

pin "@stimulus-components/lightbox", to: "@stimulus-components--lightbox.js" # @4.0.0
pin "lightgallery" # @2.7.2
pin "@stimulus-components/carousel", to: "@stimulus-components--carousel.js" # @6.0.0
pin "swiper/bundle", to: "swiper--bundle.js" # @11.1.10
pin "@stimulus-components/timeago", to: "@stimulus-components--timeago.js" # @5.0.1
pin "date-fns" # @3.6.0

# https://stackoverflow.com/questions/71489694/failed-to-resolve-module-specifier-stimulus-autocomplete
#pin "stimulus-autocomplete", to: "https://cdn.jsdelivr.net/npm/stimulus-autocomplete@3.0.2/src/autocomplete.min.js"
#pin "stimulus-lightbox", to: "https://cdn.jsdelivr.net/npm/stimulus-lightbox@4.0.0/src/autocomplete.min.js"
# https://cdn.jsdelivr.net/npm/simplelightbox@2.14.3/dist/simple-lightbox.min.css
