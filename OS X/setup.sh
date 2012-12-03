#!/bin/sh
#SSH Tunneling Proxy for mac with auto-proxy by S.Yi

remote_user_name=$1
remote_url_name=kw_${2//[\.,\:]/\_}
remote_url=$2

if [ "$remote_user_name" == "" -o "$remote_url" == "" ]; then
	echo 'Error	: User name and server address must be define.'
	echo 'Tips	: Use this like "setup.sh username ssh.server.url"'
	exit
fi


ssh_copy_id_file="/usr/bin/ssh-copy-id"
usr_ssh_path="~/.ssh/"
usr_ssh_config_file="~/.ssh/config"
usr_id_rsa_file="~/.ssh/id_rsa"
usr_bin_killwall_file="/usr/bin/killwall"
kill_tmp_file="./_tmp_killwall_by_syi"

if [ ! -f "$ssh_copy_id_file" ]; then
	sudo curl "http://syi.github.com/ssh-tunel/ssh-copy-id.txt" -o "$ssh_copy_id_file"
	sudo chmod a+x "$ssh_copy_id_file"
fi

cd ~

if [ ! -d "$usr_ssh_path" ]; then
	mkdir "$usr_ssh_path"
fi

# TODO: find and remove repeat define
echo Host "$remote_url_name" >> "$usr_ssh_config_file"
echo HostName "$remote_url" >> "$usr_ssh_config_file"
echo User "$remote_user_name" >> "$usr_ssh_config_file"

if [ ! -f "$usr_id_rsa_file" ]; then
	# TODO: Check Args
	ssh-keygen -q -t rsa -N '' -C '' -f "$usr_id_rsa_file"
fi

ssh-copy-id "$remote_url_name"

#ssh "$remote_url_name"

if [ -f "$kill_tmp_file" ]; then
	sudo rm -f "$kill_tmp_file"
fi

echo "#!/bin/sh" >> "$kill_tmp_file"
echo "pinfo=\`ps aux|grep \ -D\ 1047|sed -n '2p'\`" >> "$kill_tmp_file"
echo "pa=\`echo \$pinfo|awk '{print \$11}'\`" >> "$kill_tmp_file"
echo "pid=\`echo \$pinfo|awk '{print \$2}'\`" >> "$kill_tmp_file"
echo "if [ \"\$pa\" == 'ssh' ]; then" >> "$kill_tmp_file"
echo "  kill -TERM \$pid" >> "$kill_tmp_file"
echo "fi" >> "$kill_tmp_file"
echo "ssh -qTfnN -D 1047 ""$remote_url_name" >> "$kill_tmp_file"

if [ -f "$usr_bin_killwall_file" ]; then
	sudo rm -f /usr/bin/killwall
fi
sudo mv "$kill_tmp_file" "$usr_bin_killwall_file"
sudo chmod a+x "$usr_bin_killwall_file"

sudo curl "http://syi.github.com/ssh-tunel/ap.pac" -o /Library/WebServer/Documents/ap.pac
sudo apachectl restart

echo "Done!"