#!/bin/bash
    
    TOT_IN_LINES=0
    TOT_OUT_LINES=0
    TOT_ERRORS=0
    
    echo "---===]          MA.R.BA          [===---"
    echo "Programma MAssive Renamer BAsh partito..."
    echo "---===================================---"
    echo "Inizio controllo di coerenza tra il file IN.txt e il file OUT.txt"
    TOT_IN_LINES=`more IN.txt | wc -l`
    TOT_OUT_LINES=`more OUT.txt | wc -l`
    if [ $TOT_IN_LINES -eq $TOT_OUT_LINES ]
     then  
      echo "Perfetto, il numero di righe dei due file è identico... posso continuare con l'esecuzione dello script"
     else
      echo "Errore inaspettato... termino l'esecuzione dello script!"
      exit 1
    fi
    
    echo "Rapporto errori di MA.R.BA eseguito in data" `date` >> log_error.txt
    
    while IFS=$'\t' read -r f1 f2
    do
     echo "Tentativo di rinominare il file $f1 in $f2"
     mv $f1 $f2 2>> log_error.txt
     
     TOT_ERRORS=$(( $TOT_ERRORS + `echo $?` ))
    done < <(paste "IN.txt" "OUT.txt")
    echo "----------------------------------------------------------"
    echo "Si sono verificati $TOT_ERRORS errori durante il processo. Controllare l'output."
