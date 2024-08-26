// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)

// Import Stimulus components (only import Application once)
// 1. Ricc: Lightbox + Carousel + Timeago
import { Application } from '@hotwired/stimulus'

// 2. Ricc: importing lightbox
import Lightbox from '@stimulus-components/lightbox'
// 2. Ricc Carousel: https://www.stimulus-components.com/docs/stimulus-carousel
import Carousel from '@stimulus-components/carousel'
// 2. Ricc TimeAgo: https://www.stimulus-components.com/docs/stimulus-timeago
import Timeago from '@stimulus-components/timeago'

// 3. Ricc: Lightbox + Carousel + Timeago
// Register Stimulus controllers
application.register('lightbox', Lightbox)
application.register('carousel', Carousel)
application.register('timeago', Timeago)
