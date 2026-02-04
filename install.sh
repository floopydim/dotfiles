#!/bin/bash

# Цвета для красоты
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}🚀 Начинаем мега-установку твоего райса...${NC}"

# 1. Список пакетов
PACKAGES="hyprland kitty waybar rofi-wayland swww grim slurp swappy wl-clipboard jq nwg-look qt5ct qt6ct ttf-fira-code otf-font-awesome sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg"

echo "📦 Устанавливаю софт..."
sudo pacman -S --needed --noconfirm $PACKAGES

# 2. Настройка SDDM (Твоя тема из репозитория)
echo "🎨 Устанавливаю твою тему SDDM..."
sudo mkdir -p /usr/share/sddm/themes/my-cool-theme
# Копируем тему из папки sddm-theme репозитория
sudo cp -r sddm-theme/* /usr/share/sddm/themes/my-cool-theme/

# Активируем тему
echo -e "[Theme]\nCurrent=my-cool-theme" | sudo tee /etc/sddm.conf.d/theme.conf
sudo systemctl enable sddm

# 3. Создание структуры папок
echo "📂 Подготавливаю папки..."
mkdir -p ~/.config/{hypr,kitty,waybar,rofi,swappy}
mkdir -p ~/Pictures/Wallpapers
mkdir -p ~/Pictures/Screenshots

# 4. Копирование твоих конфигов
echo "📝 Накатываю твои конфиги..."
cp -r hypr/* ~/.config/hypr/
cp -r kitty/* ~/.config/kitty/
cp -r waybar/* ~/.config/waybar/
cp -r rofi/* ~/.config/rofi/

# 5. Установка обоев
echo "🖼  Устанавливаю обои..."
cp wallpapers/default.jpg ~/Pictures/Wallpapers/default.jpg

# 6. Фикс путей в конфигах (автоматическая замена на универсальный путь)
echo "🔧 Исправляю пути в конфигах..."
sed -i "s|/home/[^/]*/Pictures/[^ ]*|~/Pictures/Wallpapers/default.jpg|g" ~/.config/hypr/*.conf 2>/dev/null
sed -i "s|/home/[^/]*/Pictures/[^ ]*|~/Pictures/Wallpapers/default.jpg|g" ~/.config/hypr/*.sh 2>/dev/null

# Даем права на выполнение скриптам
chmod +x ~/.config/hypr/*.sh 2>/dev/null

echo -e "${GREEN}🎉 Всё готово! Твой рис на месте. Можешь ребутаться!${NC}"
