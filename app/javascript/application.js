// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const flash = document.getElementById("flash-notice");
  if (flash) {
    setTimeout(() => {
      flash.classList.add("hidden");
      setTimeout(() => {
        flash.style.display = "none";
      }, 600);
    }, 3000); // 3秒後にフェードアウト
  }

  const toggle = document.querySelector(".toggle-category-box");
  const box = document.querySelector(".category-add-box");

  if (toggle && box) {
    toggle.addEventListener("click", () => {
      const isHidden = box.style.display === "none" || box.style.display === "";
      box.style.display = isHidden ? "block" : "none";
      toggle.textContent = isHidden ? "▲ カテゴリの追加・編集" : "▼ カテゴリの追加・編集";
    });
  }
});