// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


// Ricc: importing lightbox
import { Application } from '@hotwired/stimulus'
import Lightbox from 'stimulus-lightbox'


// Ricc Carousel: https://www.stimulus-components.com/docs/stimulus-carousel
import { Application } from '@hotwired/stimulus'
import Carousel from '@stimulus-components/carousel'


// Ricc: Lightbox + Carousel
const application = Application.start()
application.register('lightbox', Lightbox)
application.register('carousel', Carousel)
