if [ -e "MSGFiles/`basename $1`.cleaned" ]
then
	echo -n .
else
echo -n "MSGFiles/`basename $1`.cleaned" ...
ascii2uni -a Y $1 | sed 's:\(<tr class="message \):\
\1:g' > MSGFiles/`basename $1`.cleaned 
echo done
fi


