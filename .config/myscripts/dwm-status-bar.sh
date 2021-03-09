#!/usr/bin/env bash

fn_date(){
  curr_date=`date +"%a, %b %d %Y"`
  echo -e "\uf332 $curr_date"
}
fn_clock(){
  clock=`date +"%H:%M:%S"`
  echo -e "\uf337 $clock"
}
fn_mem(){
  mem=`free -h | awk '/Mem:/ {printf $3 "::" $2}'`
  echo -e "\uf3e0 $mem"
}
fn_sound(){
  left=`amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }'`
  right=`amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'`
  echo -e "\uf3bc $left|$right"
}
fn_kernel(){
  kernel=`uname -sr | sed "s/-amd64//g"` 
  echo -e "$kernel"
}
fn_playback(){
  { read source_title; read player_name; read player_status;} <<< $(echo -e $(playerctl metadata --format '{{title}}\n{{playerName}}\n{{status}}'))
  if [[ $player_status == "Paused" ]]; then
    if [ ${#source_title} -ge 25 ]; then
      echo -e "\uf3aa ${source_title:0:25}...|$player_name"
    else
      echo -e "\uf3aa ${source_title}|$player_name"
    fi
  elif [[ $player_status == "Playing" ]]; then
    if [ ${#source_title} -ge 25 ]; then
      echo -e "\uf3a7 ${source_title:0:25}...|$player_name"
    else
      echo -e "\uf3a7 ${source_title}|$player_name"
    fi
  else 
    echo -e ""
  fi
}

fn_status(){
  echo -e "$(fn_playback)   $(fn_sound)   $(fn_mem)   $(fn_date)   $(fn_clock)"
}

while xsetroot -name "$fn_status"
do
  sleep 1
done &


