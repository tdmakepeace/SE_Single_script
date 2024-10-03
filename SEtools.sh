#!/bin/bash

echo "
Everything has been set up to run under tmux sessions. this is so you can move around single SSH session, 
and watch some of the logs for things like Pentools and bigred.



To run the tools and tmux session run the starttools.sh script from the pensandotools/ folder
"





sudo apt-get update
sudo NEEDRESTART_SUSPEND=1 apt-get dist-upgrade --yes
sudo NEEDRESTART_SUSPEND=1 apt-get install tmux ansible sshpass --yes


cd /pensandotools/
git clone https://gitlab.com/pensando/tbd/utilities/pentools.git
git clone https://gitlab.com/pensando/tbd/utilities/bob.git
git clone https://gitlab+deploy-token-bigred:MPEzmdZ5-u_u7LuETBqt@gitlab.com/tdmakepeace/Bigredbutton.git
docker login registry.gitlab.com -u gitlab+deploy-token-349500 -p sufyMzq4GAaebsLjcBYU

cp SE_Single_script/scripts/*.* scripts
cp SE_Single_script/starttools.sh ./

sudo chmod +x scripts/*.sh


echo "
#!/bin/bash

tmux new -d -s pentools '/pensandotools/scripts/pentools_inner_run.sh'
tmux new -d -s brb '/pensandotools/scripts/brb_inner_run.sh'
" > /pensandotools/starttools.sh


		echo "Do you want to setup bob.
  	
  	Yes (y) and No (n) "
		echo "y or n "
		read x
	  
	  clear

  	if  [ "$x" == "y" ]; then
				cd /pensandotools/bob
				mv .penrc .penrc.demo
				  
				echo " PSM IP Address"
					read psmip
				echo " PSM Usename"
					read psmuser
				echo " PSM Password"
					read psmpass
					
				  
				  clear
				cat >> /pensandotools/bob/.penrc << EOF
				{
				  "psm": {
				    "servers": [{
				      "hostname":"$psmip",
				      "username":"$psmuser",
				      "password":"$psmpass"
				    }]
				  },
				  "bigredbutton": {
				    "deny_ports":{"ports":["23","3389"]},
				    "allow_source":{"src_range":"10.1.1.0/24"},
				    "clear": {
				      "dest_ip":"1.2.3.4",
				      "proto":"1"
				    }
				  }
				}
				EOF


echo "

# to run bob bigred you need to set the PSM creds in .penrc
tmux new -d -s bobbrb '/pensandotools/scripts/bobbrb_inner_run.sh'

# tmux new -d -s udpclone '/pensandotools/scripts/udp_inner_run.sh'
" >> /pensandotools/starttools.sh


  	else
    	echo "Continue"
  	fi



echo  "

sleep 20
echo 'Tools should be started'
tmux list-s

" >> /pensandotools/starttools.sh


sudo chmod +x /pensandotools/starttools.sh


. /pensandotools/starttools.sh



