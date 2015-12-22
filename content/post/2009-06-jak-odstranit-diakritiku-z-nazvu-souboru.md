
+++
slug = "jak-odstranit-diakritiku-z-nazvu-souboru"
title = "Jak odstranit diakritiku z názvu souborů"
date = "2009-06-23T10:44:06"
tags = ["linux","bash","scripts","howto"]
disable = ['comments']
+++


Potřeboval jsem odstranit diakritiku z n&aacute;zvů souborů. Pod winxp s cygwinem (tr viz d&aacute;le nefungoval a o př&iacute;kazu unaccent jsem nevěděl). PS: Filtruji .svn adres&aacute;ře. S unaccent by to bylo asi v&yacute;razně rychlej&scaron;&iacute;. IFS je asi zbytečn&eacute;. Um&iacute; si poradit s duplicitami. Adres&aacute;ře neře&scaron;&iacute;.

V&yacute;sledek vypad&aacute; takto:

```bash
    #!/bin/bash

    srcenc=cp1250

    SAVEIFS=$IFS
    IFS=$(echo -en “\n\b”)

    if [ $# -eq 0 ];then
      echo “Usage: $0 directory …”
    else
      while [ $# -gt 0 ];do
        if [ -d “$1” ];then
          find “$1” -mindepth 1 -maxdepth 1 -type f | grep -v “.svn” | while read name;do
            echo “INFO: Filename - $name”
            nname=”$(iconv -f “$srcenc” -t “ascii//TRANSLIT” <<< “$name” )”
            nname=”$(echo “$nname” | sed -e “s/’//g” )”
            if [ “$name” != “$nname” ];then 
              if [ -e “$nname” ];then
                echo “WARNING: Filename already exist - $nname”
                i=0
                oname=”$nname”
                while [ -e “$nname” ];do nname=”$( printf “%s.%05i” “$oname” $i )”;i=$(($i+1));done
              fi
              svn rename “$name” “$nname”
            fi
          done
          find “$1” -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0r “$0” | sed -e “s:[-a-zA-Z0-9_/. \]*.svn ::g”
          shift
        else
          echo “Directory $1 does not exist”
        fi
      done
    fi


    # restore $IFS
     IFS=$SAVEIF
```


Jin&eacute; a podobn&eacute; možnosti:

TR:

```bash

    #n=”$( echo “$name” | tr — ’ĄąÁÂĂÄáâăäĆÇČćçčĎĐďđÉĘËĚéęëěÍÎíîŁĽłľĹĺŃŇńňÓÔŐÖóôőöŔŕŘřŚŠŞśšşŤťŢţŮÚŰÜůúűüÝýŹŽŻźžż’\

    ‘AaAAAAaaaaCCCcccDDddEEEEeeeeIIiiLLllLlNNnnOOOOooooRrRrSSSsssTtTtUUUUuuuuYyZZZzzz’ \

    | tr -cs — ‘-0-9a-zA-Z_.\/’ ‘_’ \

    | tr -s — ‘-_’ ‘-_’ | sed -e ‘s/^[-_]+//’ -e ‘s/[-_]*-[-_]*/-/g’ -e ‘s/[-_]+././g’ -e ‘s/.[-_]+/./g;’ )”
```

SED

```bash
    nname=”$( echo “$name” | sed ‘y/ĄąÁÂĂÄáâăäĆÇČćçčĎĐďđÉĘËĚéęëěÍÎíîŁĽłľĹĺŃŇńňÓÔŐÖóôőöŔŕŘřŚŠŞśšşŤťŢţŮÚŰÜůúűüÝýŹŽŻźžż\x9D\x9A\x9E\x8D\x8A\x8E/ AaAAAAaaaaCCCcccDDddEEEEeeeeIIiiLLllLlNNnnOOOOooooRrRrSSSsssTtTtUUUUuuuuYyZZZzzztszTSZ/; y/A-Z/a-z/;y/-0-9a-z_./_/cs;y/-_/-_/s;s/^[-_]\+//;s/[-_]*-[-_]*/-/g;s/[-_]\+.\/./g;s/.[-_]\+/./g;’ )”

    sed -e ‘y/ščř/scr/;y/-0-9a-z_./_/cs’
```


Zdroj a inspirace:
http://www.abclinuxu.cz/blog/Tomik/2007/11/uzitecne-skripty-7-hromadne-prejmenovani-souboru/diskuse

