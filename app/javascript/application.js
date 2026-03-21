// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//import "bootstrap"

const FLASH_SELECTOR = ".js-auto-dismiss-flash"
const DISMISS_DELAY_MS = 3000
const FADE_DURATION_MS = 300

document.addEventListener("turbo:load", () => {
  document.querySelectorAll(FLASH_SELECTOR).forEach((flash) => {
    window.setTimeout(() => {
      flash.style.transition = `opacity ${FADE_DURATION_MS}ms ease`
      flash.style.opacity = "0"

      window.setTimeout(() => {
        flash.remove()
      }, FADE_DURATION_MS)
    }, DISMISS_DELAY_MS)
  })
})