#!/bin/zsh

# Выбираем цвет с экрана через hyprpicker и очищаем вывод
color=$(hyprpicker -n 2>/dev/null | grep -o '#[0-9A-Fa-f]\{6\}')

# Проверка на успешный выбор
if [ -z "$color" ]; then
    echo "Ошибка: Цвет не выбран или получен некорректный формат."
    exit 1
fi

echo "Выбранный цвет: $color"

# Удаляем символ #
hex=${color/#\#/}

# Извлекаем компоненты
r_hex="${hex:0:2}"
g_hex="${hex:2:2}"
b_hex="${hex:4:2}"

# Конвертируем в десятичные
r=$((16#$r_hex))
g=$((16#$g_hex))
b=$((16#$b_hex))

# Вычисляем серый цвет по формуле luma
gray=$(awk "BEGIN {printf \"%.0f\", ($r * 0.299) + ($g * 0.587) + ($b * 0.114)}")

# Преобразуем обратно в HEX
gray_hex=$(printf "%02X" "$gray")

# Формируем финальный цвет
gray_color="#${gray_hex}${gray_hex}${gray_hex}"

# Выводим результат
echo "Серая версия: $gray_color"

# Копируем в буфер обмена
if command -v wl-copy &> /dev/null; then
    echo -n "$gray_color" | wl-copy
    echo "Цвет скопирован в буфер обмена (wl-copy)."
elif command -v xclip &> /dev/null; then
    echo -n "$gray_color" | xclip -selection clipboard
    echo "Цвет скопирован в буфер обмена (xclip)."
else
    echo "Не найден ни один инструмент для работы с буфером обмена."
fi
