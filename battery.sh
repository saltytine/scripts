upower -i $(upower -e | grep BAT) | awk '
/percentage/ {perc = $2}
/state/ {state = $2}
/time to/ {time = $4 " " $5}
END {
    if (time == "") time = "unknown"
    print "Battery: " perc " | State: " state " | Time Remaining: " time
}'

