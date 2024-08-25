import Lightbox from '@stimulus-components/lightbox'

export default class extends Lightbox {
  connect() {
    super.connect()
    console.log('Do what you want here.')

    // Get the lightgallery instance
    this.lightGallery

    // Default options for every lightboxes.
    this.defaultOptions
  }

  // You can set default options in this getter.
  get defaultOptions() {
    return {
      // Your default options here
    }
  }
}
