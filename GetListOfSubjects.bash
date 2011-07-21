psql -hlocalhost -p5432 -ddoctissimo -Uhypolite -c 'CREATE TABLE messages (url character varying(1024), author character varying(255), date date, "time" time without time zone, content text);'
psql -hlocalhost -p5432 -ddoctissimo -Uhypolite -c 'CREATE TABLE sujets (url text NOT NULL, id bigint NOT NULL, nrep bigint, nread bigint);'

make RemoveLF
#\047 = '''
wget http://www.forum.doctissimo.fr
find forum.doctissimo.fr/ -name "liste_sujet*" -exec egrep "sujetCase[378]" {} \; | sed 's:.*ondblclick="location.href=\([^"]*\).*title="Sujet n°\([0-9]*\).*">.*:\1, \2:' | sed 's:.*<td.*>\([0-9]*\)</td>:, \1:' | ./RemoveLF | tr -d '\047' | sort -u > sujets.csv
psql -ddoctissimo -c "copy "public.Sujets" from 'sujets.csv' using delimiters ','"
#\037 = ASCII, US, Unit Separator

mkdir MSGFiles
find ../forum.doctissimo.fr/ -name "*-sujet_*" -exec ./clean_page.bash {} \;
find ./MSGFiles/ -exec egrep -H "messCase2[^ ]" {} \; |tr '\t' ' '| sed 's:^\([^:]*\).*<b class="s2">\([^<]*\).*Post. le \([0-9]*\).\([0-9]*\).\([0-9]*\)[^0-9]*\([0-9]*\).\([0-9]*\).\([0-9]*\).*\(<p>.*</p>\).*:\1\t\2\t\5-\4-\3\t\6\:\7\:\8\t\9:' > messages.csv 

sed '/cleaned:<tr/ d' messages.csv | tr '\\' '/'  | ./RemoveWrongUTF8 > messages.cleaned.csv

psql -ddoctissimo -c "copy "public.msg" from 'messages.cleaned.csv' using delimiters E'\t'"

