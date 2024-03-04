#!/bin/bash
sed  -i -e '/{restart}/ s/i/l/' -e '/{restart}/ s/^#//' /etc/needrestart/needrestart.conf

DEBIAN_FRONTEND="noninteractive"

