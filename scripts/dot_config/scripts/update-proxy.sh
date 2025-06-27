#!/bin/bash

IP4=$(nmcli device show wlp1s0| grep IP4.GATEWAY | awk '{ print $2 }')
gsettings set org.gnome.system.proxy.https host ${IP4}
gsettings set org.gnome.system.proxy.http host ${IP4}
