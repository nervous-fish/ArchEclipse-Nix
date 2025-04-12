#!/bin/bash
# Create a timestamp for the image filename
timestamp=$(date +%Y%m%d_%H%M%S)
image_path="/tmp/clipboard_image_${timestamp}.png"

# Try to get an image from the clipboard
if wl-paste --type image/png >"$image_path" 2>/dev/null; then
    echo "Image copied to clipboard: $image_path"
    # If an image is detected, show it in the notification
    notify-send "Clipboard" "Image copied" -i "$image_path" --hint=string:actions:"[[\"Preview\",\"swayimg --class 'previewImage' $image_path \"],[\"Edit\",\"gimp $image_path \"],[\"Delete\",\"rm $image_path \"]]"
else
    # If no image is found, check for text content
    echo "No image found in clipboard, checking for text..."
    clipboard_content=$(wl-paste --no-newline --type text 2>/dev/null)
    [ -n "$clipboard_content" ] && notify-send "Clipboard" "$clipboard_content"
fi
