#!/bin/bash

THEME_NAME=taebaek

if [[ $EUID -ne 0 ]]; then
    echo "Root privileges needed" 1>&2
    exit 1
fi

if ! command -v grub-mkconfig >/dev/null 2>&1 ; then
    echo "Command 'grub-mkconfig' not found" 1>&2
    exit 1
fi

# Find out the screen dpi
SCALING=1
if ! command -v hwinfo >/dev/null 2>&1 ; then
    echo "Command 'hwinfo' not found. Cannot determine monitor dpi"
else
    MONITOR=`hwinfo --monitor`
    if [ -n "$MONITOR" ]; then
        MODEL=$(echo "$MONITOR" | grep -m 1 Model)
        if [ -n "$MODEL" ]; then
            echo "Found monitor"$MODEL
        fi
        SIZE=$(echo "$MONITOR" | grep -m 1 Size | sed -n -E 's/ *Size[ :]*([0-9]+)x[0-9]+.*/\1/p')
        if [ -n "$SIZE" ]; then
            RES=$(echo "$MONITOR" | grep -m 1 Resolution | sed -n -E 's/ *Resolution[ :]*([0-9]+)x[0-9]+.*/\1/p')
            SCALING=$(($RES / $SIZE / 3))
            SCALING=$(($SCALING<1?1:$SCALING))
            SCALING=$(($SCALING>4?4:$SCALING))
        fi
    fi
fi

echo "SCALING : $SCALING"

# Change sizes according to dpi
FONT_SIZE=$((13 * $SCALING)) 
ICON_WIDTH=$((25 * $SCALING))
ICON_HEIGHT=$((25 * $SCALING))
ITEM_ICON_SPACE=$((7 * $SCALING))
ITEM_HEIGHT=$((30 * $SCALING))
ITEM_SPACING=$((5 * $SCALING))

# Copy folder to themes
rm -rf /usr/share/grub/themes/$THEME_NAME
cp -rf usr/share/grub/themes/$THEME_NAME /usr/share/grub/themes
if [ $SCALING = "2" ]; then
    cp -v "usr/share/grub/themes/$THEME_NAME/fonts/D2Coding-Ver1-22.pf2" /usr/share/grub/themes/$THEME_NAME
else
    cp -v "usr/share/grub/themes/$THEME_NAME/fonts/D2Coding-Ver1-"$FONT_SIZE".pf2" /usr/share/grub/themes/$THEME_NAME
fi
sed -i 's/ICON_WIDTH/'"$ICON_WIDTH"'/' /usr/share/grub/themes/$THEME_NAME/theme.txt
sed -i 's/ICON_HEIGHT/'"$ICON_HEIGHT"'/' /usr/share/grub/themes/$THEME_NAME/theme.txt
sed -i 's/ITEM_ICON_SPACE/'"$ITEM_ICON_SPACE"'/' /usr/share/grub/themes/$THEME_NAME/theme.txt
sed -i 's/ITEM_HEIGHT/'"$ITEM_HEIGHT"'/' /usr/share/grub/themes/$THEME_NAME/theme.txt
sed -i 's/ITEM_SPACING/'"$ITEM_SPACING"'/' /usr/share/grub/themes/$THEME_NAME/theme.txt

# Replace GRUB_THEME variable
sed -i '/GRUB_THEME=/d' /etc/default/grub
sed -i -e '$a\' /etc/default/grub
echo "GRUB_THEME=\"/usr/share/grub/themes/"$THEME_NAME"/theme.txt\"" >> /etc/default/grub

[[ -x "/etc/hamonikr/adjustments/10-adjust-grub-title.execute" ]] && /etc/hamonikr/adjustments/10-adjust-grub-title.execute

# Update grub config
grub-mkconfig -o /boot/grub/grub.cfg

echo -e $THEME_NAME" installed, please reboot"



