// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  // --- 既存のフラッシュメッセージ処理 ---
  const flash = document.getElementById("flash-notice");
  if (flash) {
    setTimeout(() => {
      flash.classList.add("hidden");
      setTimeout(() => {
        flash.style.display = "none";
      }, 600);
    }, 3000); // 3秒後にフェードアウト
  }
  
  // --- 既存のカテゴリトグル処理 ---
  const toggle = document.querySelector(".toggle-category-box");
  const box = document.querySelector(".category-add-box");

  if (toggle && box) {
    toggle.addEventListener("click", () => {
      const isHidden = box.style.display === "none" || box.style.display === "";
      box.style.display = isHidden ? "block" : "none";
      toggle.textContent = isHidden ? "▲ カテゴリの追加・編集" : "▼ カテゴリの追加・編集";
    });
  }

  const bodyArea = document.getElementById("diary_body");
const display = document.getElementById("char-count-display");

  if (bodyArea && display) {
    const updateCount = () => {
      display.textContent = `${bodyArea.value.length} 文字`;
    };

    bodyArea.addEventListener("input", updateCount);
    updateCount(); // 読み込み時にも実行
  }
});