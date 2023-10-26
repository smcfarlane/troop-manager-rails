import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from 'https://ga.jspm.io/npm:stimulus-use@0.52.1/dist/index.js'

export default class extends Controller {
  static targets = [ "toggleable" ]

  connect() {
    // passing a custom target as the root element.
    useClickOutside(this, { element: this.contentTarget })
  }

  toggle() {
    this.toggleableTarget.classList.toggle("hidden")
  }

  show() {
    this.toggleableTarget.classList.remove("hidden")
  }

  hide() {
    this.toggleableTarget.classList.add("hidden")
  }
}
