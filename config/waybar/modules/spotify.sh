#!/bin/sh

# prevents perceived non-responsiveness from the spotify widget on click
# let spotify update its internals for a split second before we poll it again
# for data
sleep 0.1

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon=""

if [[ $class == "playing" ]] || [[ $class == "paused" ]]; then
  info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
  if [[ ${#info} > 40 ]]; then
    info=$(echo $info | cut -c1-30)"..."
  fi
  text=$icon" "$info
elif [[ $class == "stopped" ]]; then
  text=""
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
