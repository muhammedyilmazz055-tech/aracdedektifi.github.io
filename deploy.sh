#!/bin/bash
# landing/deploy.sh — GitHub Pages'e tek komutla deploy
# Kullanım: bash deploy.sh
# Gereksinim: git + GitHub hesabı, repo adı: aracdedektifi.github.io

set -e
LANDING_DIR="$HOME/Documents/Claude/sahibinden-firsat-tarayici/landing"
REPO="git@github.com:aracdedektifi/aracdedektifi.github.io.git"

echo "=== Araç Dedektifi Landing Page Deploy ==="
echo ""

# 1. Repo yoksa clone, varsa pull
if [ ! -d "$LANDING_DIR/.git" ]; then
  echo "📦 Repo ilk kez kuruluyur..."
  cd "$LANDING_DIR/.."
  git clone "$REPO" landing_deploy 2>/dev/null || {
    echo "❌ Repo clone başarısız."
    echo ""
    echo "GitHub'da şunu yap:"
    echo "1. github.com/new → Repo adı: aracdedektifi.github.io"
    echo "2. Settings → Pages → Source: main branch / root"
    echo "3. Bu scripti tekrar çalıştır"
    exit 1
  }
  cp -r "$LANDING_DIR"/* landing_deploy/
  cd landing_deploy
else
  cd "$LANDING_DIR"
fi

# 2. Commit + push
git add -A
git commit -m "chore: landing page güncelle $(date +%Y-%m-%d)" || echo "Değişiklik yok."
git push origin main

echo ""
echo "✅ Deploy tamamlandı!"
echo "🌐 https://aracdedektifi.github.io"
echo ""
echo "Google Search Console'a ekle:"
echo "https://search.google.com/search-console"
