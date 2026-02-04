#!/bin/bash

# Цвета для красоты
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}🚀 Начинаем мега-установку твоего райса...${NC}"

# 1. Список пакетов (добавили зависимости для SDDM)
PACKAGES="hyprland kitty waybar rofi-wayland swww grim slurp swappy wl-clipboard jq nwg-look qt5ct qt6ct ttf-fira-code otf-font-awesome sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg"

echo "📦 Устанавливаю софт..."
sudo pacman -S --needed --noconfirm $PACKAGES

### 2. Обновленный блок для SDDM в `install.sh`
#Чтобы скрипт брал **твою** тему из папки репозитория, а не качал чужую, измени блок SDDM в `install.sh` на этот:

```bash
# 2. Настройка SDDM (Локальная тема)
echo "🎨 Устанавливаю твою тему SDDM..."
sudo mkdir -p /usr/share/sddm/themes/my-cool-theme
# Копируем тему из папки репозитория
sudo cp -r sddm-theme/* /usr/share/sddm/themes/my-cool-theme/

# Активируем
echo -e "[Theme]\nCurrent=my-cool-theme" | sudo tee /etc/sddm.conf.d/theme.conf

# 3. Создание структуры папок
echo "📂 Подготавливаю папки..."
mkdir -p ~/.config/{hypr,kitty,waybar,rofi,swappy}
mkdir -p ~/Pictures/Screenshots

# 4. Копирование твоих конфигов
echo "📝 Накатываю твои конфиги..."
cp -r hypr/* ~/.config/hypr/
cp -r kitty/* ~/.config/kitty/
cp -r waybar/* ~/.config/waybar/
cp -r rofi/* ~/.config/rofi/

# Даем права на выполнение всем скриптам в папке hypr (если они там есть)
chmod +x ~/.config/hypr/*.sh 2>/dev/null

echo -e "${GREEN}🎉 Всё готово! Твой рис на месте. Можешь ребутаться и наслаждаться SDDM.${NC}"

#!/bin/bash
# ... (начало скрипта с установкой пакетов) ...

# 5. Обои
echo "🖼  Устанавливаю обои..."
mkdir -p ~/Pictures/Wallpapers
cp wallpapers/default.jpg ~/Pictures/Wallpapers/default.jpg

# 6. Фикс путей в конфигах (важно!)
# Заменяем жесткий путь на универсальный в твоем конфиге hyprland/swww
sed -i "s|/home/floopydim/Pictures/.*.jpg|~/Pictures/Wallpapers/default.jpg|g" ~/.config/hypr/hyprland.conf 2>/dev/null
# Если используешь скрипт старта обоев, правим и его
sed -i "s|/home/floopydim/Pictures/.*.jpg|~/Pictures/Wallpapers/default.jpg|g" ~/.config/hypr/start_wallpaper.sh 2>/dev/null

echo -e "\033[0;32m🎉 Всё готово! Обои лежат в ~/Pictures/Wallpapers/default.jpg\033[0m"
