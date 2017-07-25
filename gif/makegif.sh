DEFDUR=10

# Sound notification to let one know when recording is about to start (and ends)
beep() {
    paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga &
}

# Custom recording duration as set by user
USERDUR=$(zenity --entry --title "Recoding duration" --text "Please enter the screencast duration in seconds:" --width 200 --height 100 2>/dev/null)

# Duration and output file
if [ $USERDUR -gt 0 ]; then
    D=$USERDUR
else
    D=$DEFDUR
fi

# Window geometry
XWININFO=$(xwininfo)
read X < <(awk -F: '/Absolute upper-left X/{print $2}' <<< "$XWININFO")
read Y < <(awk -F: '/Absolute upper-left Y/{print $2}' <<< "$XWININFO")
read W < <(awk -F: '/Width/{print $2}' <<< "$XWININFO")
read H < <(awk -F: '/Height/{print $2}' <<< "$XWININFO")

# Notify the user of recording time and delay
notify-send "GIFRecorder" "Recording $D seconds, after delay $DELAY seconds. { X:$X, Y: $Y, W: $W, H: $H } "

#Actual recording
sleep $DELAY
beep
byzanz-record -c --verbose --delay=0 --duration=$D --x=$X --y=$Y --width=$W --height=$H "$FOLDER/GIFrecord_$TIME.gif"
beep

# Notify the user of end of recording.
notify-send "GIFRecorder" "Screencast saved to $FOLDER/GIFrecord_$TIME.gif"
