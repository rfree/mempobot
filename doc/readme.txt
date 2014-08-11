
This is the bot that will build, report etc on git projects;

It can report any project
- to NNTP server (e.g. works with freenet FMS)
- to IRC

It can run a build script and is now specialized for the mempo kernel (SameKernel) builds.


INSTALL

As user kernelbuild
On the kernelbuild side, download git as:

kernelbuild@tesla:~/bot_to_build/mempobot$ ls
  conf.my.example  cron-loop.sh  doc                 ii_forever.sh  kernelbuild  messaging.conf  nobuild.sh  options.conf   README.txt  same-kernel.sh        send_nttp_fms.sh  test.txt
  create-dir.sh    cron.sh       ii_forever_join.sh  irc.conf       mempo-tools  msg1.txt        notify.sh   projects.list  run.sh      send_nttp_archive.sh  startirc.sh       to-build-flag.sh

from repo like git@github.com:mempomisc/mempobot.git (or other more current name, e.g. check the mempo user)

configure (e.g. symlink) files like this:

ls -l ~
total 44
drwxr-xr-x  3 kernelbuild kernelbuild 4096 Jun 20 19:38 bot_to_build
lrwxrwxrwx  1 kernelbuild kernelbuild   46 Apr 19 01:07 build -> deterministic-kernel/kernel-build/linux-mempo/
lrwxrwxrwx  1 kernelbuild kernelbuild   77 Aug 11 09:03 build-dpkg.sh -> /home/kernelbuild/bot_to_build/mempobot/mempo-tools/kernelbuild/build-dpkg.sh
lrwxrwxrwx  1 kernelbuild kernelbuild   77 Aug 11 09:03 build-push.sh -> /home/kernelbuild/bot_to_build/mempobot/mempo-tools/kernelbuild/build-push.sh
lrwxrwxrwx  1 kernelbuild kernelbuild   78 Aug 11 09:03 cmd-release.sh -> /home/kernelbuild/bot_to_build/mempobot/mempo-tools/kernelbuild/cmd-release.sh
drwxr-xr-x 11 kernelbuild kernelbuild 4096 Aug 11 08:36 deterministic-kernel
lrwxrwxrwx  1 kernelbuild kernelbuild   70 Aug 11 09:03 go2.sh -> /home/kernelbuild/bot_to_build/mempobot/mempo-tools/kernelbuild/go2.sh
lrwxrwxrwx  1 kernelbuild kernelbuild   69 Aug 11 09:03 go.sh -> /home/kernelbuild/bot_to_build/mempobot/mempo-tools/kernelbuild/go.sh
-rw-------  1 kernelbuild kernelbuild    1 Aug 11 08:59 nohup.out
lrwxrwxrwx  1 kernelbuild kernelbuild   22 Apr 25 15:19 publish -> /home/kernelbuild.pub/
lrwxrwxrwx  1 kernelbuild kernelbuild   83 Aug 11 09:03 samekernel-mempo.sh -> /home/kernelbuild/bot_to_build/mempobot/mempo-tools/kernelbuild/samekernel-mempo.sh
lrwxrwxrwx  1 kernelbuild kernelbuild   83 Aug 11 09:03 samekernel-rfree.sh -> /home/kernelbuild/bot_to_build/mempobot/mempo-tools/kernelbuild/samekernel-rfree.sh


