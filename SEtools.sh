#!/bin/bash

# wget -O ELK_Install_Ubuntu_script.sh  https://raw.githubusercontent.com/tdmakepeace/ELK_Single_script/refs/heads/main/ELK_Install_Ubuntu_script.sh && chmod +x ELK_Install_Ubuntu_script.sh  &&  ./ELK_Install_Ubuntu_script.sh
# wget -O SEtools.sh  https://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@raw.githubusercontent.com/tdmakepeace/SE_Single_script/refs/heads/main/SEtools.sh 



tools()
{

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
git clone https://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@github.com/tdmakepeace/Bigredbutton.git
git clone https://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@github.com/tdmakepeace/SE_Single_script.git

docker login registry.gitlab.com -u gitlab+deploy-token-349500 -p sufyMzq4GAaebsLjcBYU

cp SE_Single_script/scripts/*.* scripts


sudo chmod +x scripts/*.sh


echo "
#!/bin/bash

tmux new -d -s pentools '/pensandotools/scripts/pentools_inner_run.sh'
tmux new -d -s brb '/pensandotools/scripts/brb_inner_run.sh'
" > /pensandotools/starttools.sh

				echo " PSM IP Address"
					read psmip
				echo " PSM Usename"
					read psmuser
				echo " PSM Password"
					read psmpass
					

echo "
# PSM Server
adminuser = '$psmip'
adminpwd = '$psmpass'
ipman = '$psmip'



#BaseSettings (do not touch)
name = 'HTTPS'
prot = 'tcp'
ports = '443'
 
" > /pensandotools/Bigredbutton/loginvar.py


		echo "Do you want to customise bigred.
			You can do later, but editing the var.py and the loginvar.py
  	
  	Yes (y) and No (n) "
		echo "y or n "
		read x
	  
	  clear

  	if  [ "$x" == "y" ]; then


				echo " PSM security Policy  - the name of the security policy to be created eg: Isolated_Hosts"
					read psmpolicy
				echo " VRF to be assigned  - the name of the VRF the policy will be assigned to eg: default"
					read psmuser
				echo " managment network range  - this is just an example set of rules to show who can talk to the isolated machines in ip/mask formate eg: 192.168.102.0/24"
					read psmpass


				  
				echo "
webhost='0.0.0.0'
webport=9999
IsolatePolicy = 'Isolated_Hosts'
AdminNet = '192.168.102.0/24'
VRFToDemo = "default"
demotime = 10

" > /pensandotools/Bigredbutton/var.py


  	else
    	echo "Continue"
  	fi




		echo "Do you want to setup bob.
  	
  	Yes (y) and No (n) "
		echo "y or n "
		read x
	  
	  clear

  	if  [ "$x" == "y" ]; then
				cd /pensandotools/bob
				mv .penrc .penrc.demo
				  

					
				  
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
echo  "

sleep 20
echo 'Tools should be started'
tmux list-s

" >> /pensandotools/starttools.sh

  	fi


sudo chmod +x /pensandotools/starttools.sh


. /pensandotools/starttools.sh


}

base()
{
	wget -O ELK_Install_Ubuntu_script.sh  https://raw.githubusercontent.com/tdmakepeace/ELK_Single_script/refs/heads/main/ELK_Install_Ubuntu_script.sh && chmod +x ELK_Install_Ubuntu_script.sh  &&  ./ELK_Install_Ubuntu_script.sh
}



while true ;
do
	clear
  echo "press cntl-c  or x to exit at any time."
  echo ""    
  echo "The following will setup the ELK stack for the CX10k enviroment based on a clean install of ubuntu with a static IP.
It will also do the setting up of the SE tools.
		
  	Set up Hosts and Deploy ELK (B) and Deploy Tools (T) 

  	"
	echo "B or T"
	read x
  
  clear

  	if  [ "$x" == "B" ]; then
				 	base 
				
	  elif [ "$x" == "T" ]; then
				  tools

	  elif [ "$x" == "x" ]; then
				break


  	else
    	echo "try again"
  	fi

done   


