#!/bin/sh
# Only: 1=on/off/autoshutdown 0=only autoshutdown
only="1"
# printer_off = shell command to switch printer off
printer_off="curl http://192.168.1.132/cm?cmnd=Power%20off"
# printer_on = shell command to switch printer on
printer_on="curl http://192.168.1.132/cm?cmnd=Power%20on"
# pin_printer = the same pin as in the power section for printer
pin_printer="4"
# pin_autosh = the same pin as in the power section for autoshutdwon
pin_autosh="5"
# Time = Time after print end before shutdown in seconds (do not use under 60 sec)
time="300"
# Port from moonraker
port="7125"
