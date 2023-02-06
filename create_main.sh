#/bin/bash

CPP="
#include <iostream>\n
using namespace std;\n

int main()\n
{\n
    cout << 'Hello world' << endl;\n
}\n"

PY="
if __name__ == '__main_':\n
    print('Olá mundo')
"

LOG=$PWD/logs.out
DATEHOUR=$(date)
echo "$DATEHOUR: Programa inicializado." >> $LOG

case $1 in
    "--c++") 
        if [ -z $2 ]; then
            if [ ! -f main.cpp ]; then
                touch main.cpp
                echo -e $CPP > main.cpp
                echo "$DATEHOUR: Arquivo main criado." >> $LOG
            else
                echo "Já existe um arquivo main.cpp. Deseja remover?(S/N)"
                read RM
                if [ $RM = "S" -o $RM = "s" ]; then
                    rm -f main.cpp
                    echo "$DATEHOUR: Arquivo removido" >> $LOG
                elif [ $RM = "N" -o $RM = "n" ]; then
                    NEW_NAME_FILE=$2$$.cpp
                    touch "cpp$NEW_NAME_FILE"
                    echo "$DATEHOUR: Arquivo gerado de forma randomica: $NEW_NAME_FILE" >> $LOG
                else
                    echo "$DATEHOUR: Opção inválida." >> $LOG
                fi             
            fi
        else
            for i in $PWD/*; do
                if [[ "$i" == *"$2"* ]]; then
                    echo "$DATEHOUR: Arquivo $2 já existe" >> $LOG
                    echo "Arquivo já existe. Deseja deletá-lo?(S/N)"
                    read OP
                    if [ $OP = "S"  -o $OP = "s" ]; then
                        rm -f $2.cpp
                        echo "Arquivo $2.py criado com sucesso."
                        echo "$DATEHOUR: Arquivo $2 removido com sucesso." >> $LOG
                        echo "_________________________________________________________________" >> $LOG
                    elif [ $OP = "N"  -o $OP = "n" ]; then
                        NEW_NAME_FILE=$2$$.cpp
                        touch $NEW_NAME_FILE
                        echo "$DATEHOUR: Arquivo gerado de forma randomica $NEW_NAME_FILE" >> $LOG
                        echo "_________________________________________________________________" >> $LOG
                    fi
                    exit 1
                fi
            done
            touch $2.cpp
            echo "$DATEHOUR: Arquivo $2 criado com sucesso." >> $LOG
        fi
    ;;
    "--py") 
        if [ -z $2 ]; then
            if [ ! -f main.py ] ; then
                touch main.py
                echo -e $PY > main.py
            else
                echo "Já existe um arquivo main.py. Deseja remover?(S/N)"
                read RM

                if [ $RM = "S" -o $RM = "s" ]; then
                    rm -f main.py
                elif [ $RM = "N" -o $RM = "n" ]; then
                    NEW_NAME_FILE=$2$$.py
                    touch $NEW_NAME_FILE
                    echo "Arquivo gerado de forma randomica: $NEW_NAME_FILE"
                else
                    echo "Opção inválida"
                fi                
            fi
        else
            for i in $PWD/*; do
                if [[ "$i" == *"$2"* ]]; then
                    echo "Arquivo já existe. Deseja deletá-lo e criá-lo novamente?(S/N)"
                    read OP
                    if [ $OP = "S"  -o $OP = "s" ]; then
                        rm -f $2.py
                        echo "Arquivo $2.py criado com sucesso."
                    elif [ $OP = "N"  -o $OP = "n" ]; then
                        NEW_NAME_FILE=$2$$.py
                        touch $NEW_NAME_FILE
                        echo "Arquivo gerado de forma randomica: $NEW_NAME_FILE"
                    fi
                    exit 1
                fi
            done
            touch $2.py
        fi
    ;;
    "--help")
        cat resumo.txt
        ;;
    "--ren")
        if [ -z $2 -o -z $3 ]; then
            echo "Parâmetros não informados."
            echo "$DATEHOUR: Opção delete selecionada." >> $LOG
        elif [ ! -f $2 ]; then
            echo "$DATEHOUR: Arquivo com o caminho $2 não existe." >> $LOG
        else
            mv $2 $3
            echo "$DATEHOUR: Arquivo renomeado. De $2 para $3" >> $LOG
        fi
    ;;
    "--delete-empty-files")
        echo "Será deletado arquivo com tamanho igual a zero. Tem certeza disso? (s/n)"
        read OP
        if [ "$OP" = "s" ] || [ " $OP" = "S" ]; then
            echo "$DATEHOUR: Opção delete selecionada." >> $LOG
            continue
        elif [ "$OP" = "\n" ]; then
            echo "$DATEHOUR: Processo cancelado." >> $LOG
            exit 1
        fi
        if [ -z $2 ]; then
            for i in $(find $PWD/* -size 0)
            do  
                rm -f $i  
                echo "$DATEHOUR: Arquivo vazio encontrado e removido. $i" >> $LOG
            done
        else
            rm -f $2
            echo "$DATEHOUR: Arquivo $2 deletado." >> $LOG
        fi
    ;;
    *) echo default
    ;;  
esac
echo "$DATEHOUR: Programa finalizado." >> $LOG
echo "_________________________________________________________________" >> $LOG
