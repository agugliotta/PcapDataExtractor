#!/bin/bash

#  Copyright (C) 2012  Agustin Gugliotta
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#
# Author:
# Agustin Gugliotta agustin.mdq.89 () gmail.com

red(){
    echo "\033[01;33m$1\033[00m"
}

if [[ $# -eq 1  ]]; then

    URLS=`strings $1 | egrep -o '(http[s]?:\/\/[[:alnum:]-]{5,}[\.[[:alnum:]-]{5,}]*)'| uniq `

    for url in $URLS;
    do
        if [[ `echo $url | egrep --color 'facebook|yahoo|gmail|google|twitter|microsoft|live|hotmail'` ]]; then
            red $url
        else
            echo $url
        fi
    done
else
    echo -e "\033[01;31mError!\033[00m"
    exit
fi


