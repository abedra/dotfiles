#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [[ $MUTED != "false" ]]; then
    ICON=$VOLUME_0
    VOLUME=0
else
    case ${VOLUME} in
        [6-9][0-9]|100) ICON=$VOLUME_100 ;;
        [3-5][0-9]) ICON=$VOLUME_66 ;;
        [1-2][0-9]) ICON=$VOLUME_33 ;;
        [1-9]) ICON=$VOLUME_10 ;;
        0) ICON=$VOLUME_0 ;;
        *) ICON=$VOLUME_100 ;;
    esac
fi

sketchybar -m \
    --set $NAME icon=$ICON \
    --set $NAME label="$VOLUME%"
