import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "toggleable" ]

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
