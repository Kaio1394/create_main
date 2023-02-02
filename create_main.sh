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
        if [ ! -f main.cpp ]; then
            touch main.cpp
            echo -e $CPP > main.cpp
        else
            echo "Já existe um arquivo main.cpp. Deseja remover?(S/N)"
            read RM
            case $RM in
                "S") rm -f main.cpp
                ;;
                2"N") echo 2 or 3
                ;;
                *) echo default
                ;;
            esac
            
        fi
    ;;
    "--py") 
        if [ ! -f main.py ]; then
            touch main.py
            echo -e $PY > main.py
        else
            echo "Já existe um arquivo main.cpp. Deseja remover?(S/N)"
            read RM
            case $RM in
                "S") rm -f main.py
                ;;
                2"N") echo 2 or 3
                ;;
                *) echo default
                ;;
            esac
            
        fi
    ;;
    "--help")
        cat resumo.txt
        ;;
    *) echo default
    ;;
esac
