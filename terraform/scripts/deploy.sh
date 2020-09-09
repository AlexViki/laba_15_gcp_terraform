#!/bin/bash
set -e

sudo rm -rf /var/www/html

sudo git clone https://github.com/AlexViki/appToDoList.git /var/www/html/