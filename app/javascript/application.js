// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// Bootstrap JS はこの環境だと Popper 依存のロード失敗で全体が止まるため、
// ナビの collapse（ハンバーガー開閉）だけ最小の自前JSで対応します。

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

  // Mobile navbar toggle (collapse) - Bootstrap JS を使わずクラスを切り替える
  // 対象: #globalNav と [data-bs-target="#globalNav"] の組
  const toggler = document.querySelector('[data-bs-toggle="collapse"][data-bs-target="#globalNav"]')
  const targetSelector = toggler?.getAttribute("data-bs-target")
  const target = targetSelector ? document.querySelector(targetSelector) : null
  if (!toggler || !target) return

  // turbo で同じページを何度も表示するので多重にイベントを付けない
  if (toggler.dataset.collapseBound === "1") return
  toggler.dataset.collapseBound = "1"

  toggler.addEventListener("click", (e) => {
    // <button> の標準挙動を止めてクラスだけ切り替える
    e.preventDefault()
    const willShow = !target.classList.contains("show")
    target.classList.toggle("show", willShow)
    toggler.setAttribute("aria-expanded", String(willShow))
  })

  // メニュー項目をタップしたら閉じる（画面遷移前の体験を改善）
  target.querySelectorAll("a").forEach((a) => {
    a.addEventListener("click", () => {
      target.classList.remove("show")
      toggler.setAttribute("aria-expanded", "false")
    })
  })
})