import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  static targets = ["errorMessage"];

  connect() {
    console.log(this.element);
  }

  complete({ params: { id } }) {
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch(`/orders/${id}`, {
      method: "PATCH",
      mode: "cors", // no-cors, *cors, same-origin
      cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "same-origin", // include, *same-origin, omit
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ order: { status: "completed" } }),
    })
      .then((response) => response.json())
      .then((data) => {
        Turbo.clearCache();
        Turbo.visit(`/orders?message=${data.message}`);
      })
      .catch((error) => {
        this.errorMessageTarget.innerHTML = error.message;
      });
  }
}
