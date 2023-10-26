import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "tab" ]

  connect() {
    this.toggle()
  }

  toggle() {
    for (let tab of this.tabTargets) {
      if (location.href.includes(tab.href)) {
        tab.classList.add("active-tab")
      } else {
        tab.classList.remove("active-tab")
      }
    }

  }
}
