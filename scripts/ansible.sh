#!/bin/bash

cd /pensandotools/ansible/
python3 -m venv .venv
. .venv/bin/activate
pip install -U pip
pip install -U ansible



command()
{
    if  [ "$1" == "a" ]; then
       ansible-playbook backgroundlisten.yml -i ansiblehosts.yml 
       read -p "Press enter to return..."
    elif  [ "$1" == "b" ]; then
       ansible-playbook backgroundkill.yml -i ansiblehosts.yml 
       read -p "Press enter to return..."        
    elif  [ "$1" == "c" ]; then
       ansible-playbook backgroundstart.yml -i ansiblehosts.yml
       read -p "Press enter to return..."
    elif  [ "$1" == "d" ]; then
       ansible-playbook backgroundstop.yml -i ansiblehosts.yml 
       read -p "Press enter to return..."
    elif  [ "$1" == "e" ]; then
    	 ansible-playbook checkports.yml -i ansiblehosts.yml
    	 read -p "Press enter to return..."
    
    elif [ "$1" == "x" ]; then
        echo "" 
        x=0
        break
        exit 0
    else
        echo "try again"
    fi
}

while true ;
do
        clear  
        echo ""
        echo "a - Start background listeners on the load machines"
        echo "b - Stop background listeners on the load machines"
        echo "c - Start background traffic on the load machines"
        echo "d - Stop background traffic on the load machines"
        echo ""
        echo "e - check processes on all servers"
        echo ""
        echo "x - Exit menu or cntl+c"
        echo ""
				echo "normal sequence will be a, c, d, b, e"       
				echo ""
        echo "Command you want to run:"
        read y
        command $y
done      






