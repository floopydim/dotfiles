#!/bin/bash

# Цвета
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}🚀 Запуск установки твоего райса...${NC}"

# 1. Пакеты
PACKAGES="hyprland kitty waybar rofi-wayland swww grim slurp swappy wl-clipboard jq nwg-look qt5ct qt6ct sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg"
sudo pacman -S --needed --noconfirm $PACKAGES

# 2. Обои
echo "🖼  Копирую обои..."
mkdir -p ~/Pictures/Wallpapers
cp wallpapers/default.jpg ~/Pictures/Wallpapers/default.jpg

# 3. Конфиги
echo "📝 Накатываю конфиги..."
mkdir -p ~/.config/{hypr,kitty,waybar,rofi,swappy}
cp -r hypr/* ~/.config/hypr/
cp -r kitty/* ~/.config/kitty/
cp -r waybar/* ~/.config/waybar/
cp -r rofi/* ~/.config/rofi/

# 4. SDDM Тема
echo "🎨 Устанавливаю тему SDDM..."
# Удаляем старую версию, если была, и создаем чистую папку
sudo rm -rf /usr/share/sddm/themes/my-cool-theme
sudo mkdir -p /usr/share/sddm/themes/my-cool-theme
# Копируем всё содержимое твоей папки sddm-theme
sudo cp -r sddm-theme/* /usr/share/sddm/themes/my-cool-theme/

# Активируем тему в системе
echo -e "[Theme]\nCurrent=my-cool-theme" | sudo tee /etc/sddm.conf.d/theme.conf
sudo systemctl enable sddm

# 5. Фиксы путей
echo "🔧 Исправляю пути к обоям..."
sed -i "s|/home/[^/]*/Pictures/[^ ]*|~/Pictures/Wallpapers/default.jpg|g" ~/.config/hypr/*.conf 2>/dev/null
chmod +x ~/.config/hypr/*.sh 2>/dev/null

echo -e "${GREEN}✅ Всё! Рис успешно упакован и готов к работе.${NC}"
