import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment"
export default class extends Controller {
  static targets = [ "selection", "additionalFields" ]

  initialize() {
    this.showAdditionalFields()
  }

  showAdditionalFields() {
    let selection = this.selectionTarget.value.toLowerCase()
    console.log("Opção normalizada:", selection)

    for (let field of this.additionalFieldsTargets) {
      let type = field.dataset.type.toLowerCase()
      console.log("Campo encontrado:", field)
      console.log("Tipo normalizado:", type)

      let match = (type === selection)
      console.log("Match:", match)

      field.hidden = !match
      field.disabled = !match
    }
  }
}
