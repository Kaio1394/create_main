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
case $1 in
    "--c++") 
        if [ -z $2 ]; then
            if [ ! -f main.cpp ]; then
                touch main.cpp
                echo -e $CPP > main.cpp
            else
                echo "Já existe um arquivo main.cpp. Deseja remover?(S/N)"
                read RM
                if [ $RM = "S" -o $RM = "s" ]; then
                    rm -f main.cpp
                elif [ $RM = "N" -o $RM = "n" ]; then
                    NEW_NAME_FILE=$2$$.cpp
                    touch "cpp$NEW_NAME_FILE"
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
                        rm -f $2.cpp
                        echo "Arquivo $2.py criado com sucesso."
                    elif [ $OP = "N"  -o $OP = "n" ]; then
                        NEW_NAME_FILE=$2$$.cpp
                        touch $NEW_NAME_FILE
                        echo "Arquivo gerado de forma randomica: $NEW_NAME_FILE"
                    fi
                    exit 1
                fi
            done
            touch $2.cpp
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
        elif [ ! -f $2 ]; then
            echo "Arquivo com o caminho $2 não existe"
        else
            mv $2 $3
        fi
    ;;
    "--delete-empty-files")
        echo "Será deletado arquivo com tamanho igual a zero. Tem certeza disso? (s/n)"
        read OP
        if [ "$OP" = "s" ] || [ " $OP" = "S" ]; then
            continue
        elif [ "$OP" = "\n" ]; then
            echo "Processo cancelado"
            exit 1
        fi
        if [ -z $2 ]; then
            for i in $(find $PWD/* -size 0)
            do  
                rm -f $i  
            done
        else
            rm -f $2
        fi
    ;;
    *) echo default
    ;;  
esac
