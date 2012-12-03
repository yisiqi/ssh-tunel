# About SSH Tunel

For more information on SSH Tunel, please visit <http://syi.github.com/ssh-tunel/>.

> Choose the version to your Operating-System. There is another `README.md` document to guide you finish the installation.

## for Mac users

### Install

1. Download [ssh-tunl](https://github.com/syi/ssh-tunel/archive/master.zip) and copy **`./OS X/setup.sh`** to your user directory.
2. Open Terminal App.
3. Run commands like this:

```
cd ~/
chmod a+x ./setup.sh
./setup.sh
```
Until the terminal display `Done!`, you have installed SSH Tunel successfully.

### Use with terminal

Open Terminal App, and type like this: **`killwall username ssh.server.url[:port]`**

### Make a Service with Automator

1. Open Automator App
2. Create a Service, **change the input to No-input with any Application**.
3. Add a `Run Shell Scripts Action`, replace the default content `cat` with `killwall`.
4. Test and save.

### Add to startup with system boot

1. To create an Application with Automator app is same as to create a service. Save it to your user directory.
2. Open System Preferences - Users & Groups, choose your account and add the Application you just created into your account `Login Items`.
3. Reboot and test.

## for Windows users

working on it……

## Thanks to

[@WliNkiQ](https://twitter.com/WliNkiQ) [@_AllenZhou](https://twitter.com/_AllenZhou) [@钥匙上养条狗](http://weibo.com/xauat117)