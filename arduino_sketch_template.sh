#!/bin/bash
################################################################################
# Script Name: arduino_sketch_template.sh
# System Name: alexandria
# Script Author: Bobby Tyner
# Script Creation Date: Sat Jul  5 17:37:16 2014
# Script Revision Date: 
# Script Notes: A simple script to generate an arduino sketch template
# 
################################################################################
# Globals: 
# Remember to declare globals as read only (declare -r) 
declare -r sketch_workspace="$HOME/arduino"
declare -r timestamp="$(date)"
declare -r sketch_name="$1"
################################################################################
function usage() {
  echo -e "Usage: $(basename $0) <sketchname>"; exit -1
}
################################################################################
function main() { 
  if [ -z $sketch_name ]; then
    usage;
  fi

  if [ -d $sketch_workspace/$sketch_name ]; then
    echo "Error: "
    echo "  A sketch by this name alread exists."
    echo "  Either provide a different name or verify that you haven't already 
  created this sketch."
    exit -2
  fi

  echo "creating arduino sketch directory and file"
  mkdir -p $sketch_workspace/$sketch_name
  output_template >> $sketch_workspace/$sketch_name/$1.ino
  echo "completed"
  ls -l $sketch_workspace/$sketch_name
}
################################################################################
function output_template() {
  cat <<END_TEMPLATE 
/*
  sketch: $sketch_name.ino
  location: $sketch_workspace/$sketch_name/
  date: $timestamp
  notes: 
  
*/  

/* declare variables */
  const int led_pin = 13;

  void setup() {
/* declare setup state */
  Serial.begin(9600);
  
}
  void loop(){
  digitalWrite(led_pin,0);
  Serial.println("template output");
  delay(5000);
  digitalWrite(led_pin,1);
  delay(500);
}

END_TEMPLATE
}

main $@
