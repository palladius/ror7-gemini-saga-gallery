import{Controller as t}from"@hotwired/stimulus";import e from"lightgallery";const s=class _Lightbox extends t{connect(){this.lightGallery=e(this.element,{...this.defaultOptions,...this.optionsValue})}disconnect(){this.lightGallery.destroy()}get defaultOptions(){return{}}};s.values={options:Object};let i=s;export{i as default};

