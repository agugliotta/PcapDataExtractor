#!/bin/bash

#  Copyright (C) 2012 Agustin Gugliotta
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


#  Args: cap file and if you need a GUI  -g or --gui for Zenity

if [[ $# -eq 1  ]]; then
    if [[ $1 = "-g" ]] || [[ $1 = "--gui" ]]; then
        FILE=`zenity --file-selection --title="Select a PCAP File"`
    elif [[ -f $1 ]]; then
        FILE=$1
    fi
else
    echo -e "\033[01;31mError!\033[00m"
    exit
fi

strings $FILE | egrep -o '([[:alnum:]_.]{5,}+@[[:alnum:]_]+?\.[[:alpha:].]{2,6})' | sort | uniq -c | egrep \
    --color '([[:alnum:]_.]{5,}+@[[:alnum:]_]+?\.[[:alpha:].]{2,6})'

MAILS=`strings $FILE | egrep -o '([[:alnum:]_.]{5,}+@[[:alnum:]_]+?\.[[:alpha:].]{2,6})' | sort | uniq`

HOTMAIL=0
GMAIL=0
YAHOO=0
OTHER=0
TOTAL=0

for i in $MAILS; 
do
	if [[ `echo $i |grep "hotmail"` ]]; then
		HOTMAIL=$((HOTMAIL+1))
	elif [[ `echo $i |grep "gmail"` ]]; then
		GMAIL=$((GMAIL+1))
	elif [[ `echo $i |grep "yahoo"` ]]; then
		YAHOO=$((YAHOO+1))
	else
		OTHER=$((OTHER+1))
	fi

	TOTAL=$((TOTAL+1))
done

if [[ $# -eq 1  ]]; then
    if [[ $1 = "-g" ]] || [[ $1 = "--gui" ]]; then
        touch tmp
        echo -e "Total mails: $TOTAL\n\tHotmail mails: $HOTMAIL\n\tGmail mails: $GMAIL\n\tYahoo mails: $YAHOO\n\tOther mails: $OTHER" > tmp
        zenity --width=180 --height=210 --text-info --title="Info" --filename=tmp
        rm -f tmp
    fi
else
    echo "\033[01;31mError!\033[00m"
    exit
fi

echo -e "\n"
echo -e "\033[01;32mTotal mails:\033[00m $TOTAL"
echo -e "\t\033[01;32mHotmail mails:\033[00m $HOTMAIL"
echo -e "\t\033[01;32mGmail mails:\033[00m $GMAIL"
echo -e "\t\033[01;32mYahoo mails:\033[00m $YAHOO"
echo -e "\t\033[01;32mOther mails:\033[00m $OTHER"
