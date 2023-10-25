import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "toggleable" ]

  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  toggle() {
    console.log("toggle")
    this.toggleableTarget.classList.toggle("hidden")
  }

  show() {
    this.toggleableTarget.classList.remove("hidden")
  }

  hide() {
    console.log("hide")
    this.toggleableTarget.classList.add("hidden")
  }
}
