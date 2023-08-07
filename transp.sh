#!/bin/bash
# https://gitlab.torproject.org/legacy/trac/-/wikis/doc/TransparentProxy/diff?version_id=53a16e3ab15566274ed84b4d10ce4bf3435b0a3c
# a magic number for not rewrite exists rules of users
iptables_rules_path=/etc/iptables.rules_329
iface=wlan0
source colors.sh
source iptables.sh
function usage() {
		printf "${Red}%s start/stop${Color_Off}\n" $0
		exit 1;
}
function main() {
	checkIptables;
	if [ "$EUID" -ne 0 ]
  	then echo "Please run as root"
  	exit
	fi

	if [ $# \< 1 ];then
		usage;
	fi;
	case  $1 in "start")
		# start a transp proxy
		save_rules;
		torify;
		#echo 1 > /proc/sys/net/ipv4/ip_forward
		printf "${Green}Enabled transparent proxy. check a page check.torproject.org!${Color_Off}";
	;;
	"stop")
		#stop a transp proxy
		restore_rules;
		printf "${Green}Disabled transparent proxy. check a page check.torproject.org!${Color_Off}";
	;;
	*)
	usage;
	;;
	esac;
}

main $@
