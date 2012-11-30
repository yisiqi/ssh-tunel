#!/bin/sh
#SSH Tunneling Prozy for mac with auto-proxy by S.Yi

ssh_copy_id_path="/usr/bin/ssh-copy-id"
usr_ssh_path="~/.ssh/"
usr_id_rsa_path="~/.ssh/id_rsa"

if [ ! -f "$ssh_copy_id_path" ]; then
	sudo curl "http://syi.github.com/ssh-tunel/ssh-copy-id.txt" -o /usr/bin/ssh-copy-id
	sudo chmod a+x /usr/bin/ssh-copy-id
fi

cd ~

if [ ! -d "$usr_ssh_path" ]; then
	mkdir "$usr_ssh_path"
fi

# TODO: find and remove repeat define
echo Host kw_$2 >> ~/.ssh/config
echo HostName $2.5bird.com >> ~/.ssh/config
echo User $1 >> ~/.ssh/config

if [ ! -f "$usr_id_rsa_path" ]; then
	# TODO: Check Args
	ssh-keygen -q -t rsa -N '' -C '' -f "$usr_id_rsa_path"
fi

ssh-copy-id kw_002

#ssh kw_002

echo "#!/bin/sh" >> killwall
echo "pinfo=\`ps aux|grep \ -D\ 1047|sed -n '2p'\`" >> killwall
echo "pa=\`echo $pinfo|awk '{print $11}'\`" >> killwall
echo "pid=\`echo $pinfo|awk '{print $2}'\`" >> killwall
echo "if [ \"$pa\" == 'ssh' ]; then" >> killwall
echo "  kill -TERM $pid" >> killwall
echo "fi" >> killwall
echo "ssh -qTfnN -D 1047 kw_002" >> killwall

sudo mv ./killwall /usr/bin
sudo chmod a+x ./killwall

sudo curl "http://syi.github.com/ssh-tunel/ap.pac" -o /Library/WebServer/Documents/ap.pac
sudo apachectl restart

echo "Done!"