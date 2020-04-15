# bash.conf
ok I've been a linux user for almost 10 years. All of that time I said that mac just sucks w/o being reasonable about. I've never had a chance to use a macbook as my main machine and develop on it. And all the friends kept telling me " if you try to use mac you won't get back to your linux machine, never agina": Here're my thought
 
 ### 2 Month before:
  Year 2019 , mac 16" came out, seems to be a good model comparing to what we had: 64gb ram, 8tb storage, bazzles got thiner, keyboard became better, price for specs seem to be not as crazy as b4, lets check it.
   - taxes in Ukraine are high, I overpaid 1000$ compared to price on apple.com and got my mac from didi.com, (don't use that site please) 
   - day 1, unboxing. THe laptop is really cool, solid chassis. Speakers, omg - yeah probably was worth it.
  
  - Got my azdome adapter from ebay, the ethernet doesn't work on linux msi laptop, usb-ethernet driver just crashes, nevertheless display ports work, but kernel freezes sometime brah
  Plugged that exact seem into mac, - everything works. It works every 2nd time I plug the docker station into mac. Macbook detects external displays as a single one, outputting mirrored image to both of them. Apple support is so polite but so retarded. I was trying to explain for 10 messages what thing doesn't work and the conversation always come to to a way when people just being retarded. e.g.
  
  ##### Apple software help:
  
   Help: please press Command F1
   Me: I don't have f1 on my keyboard , should I press fn + command + f1
   Help: No, only f1
   Me: I have a touchbar, my keyboard doesn't have f1
   Help: wait a second
   Help: TO press f1 hold on a function key and then press f1
   Me: facepalm (The interesting fact I told the model of my macbook b4 the converstation)
  
  
  ##### Apple hardware help
  The guy seems to understand some basic of hardware just told me that apple only supports thing that are being sold only on apple site. For everything else - go fuck yourself. So if I buy a USB mouse and mac support usb, it doesn't guarantee that it would work. Ok w/e sounds reasanoble. Hail apple. FOr those people who says everything works on mac. Come on mac has very limited number of things, it will never deliver support for those. Kernel modules should be singed in order to load them. THings like thunderbolt adapters will never come with drivers, since they don't have permissions to load them into the kernel. And you know what apple says: we don't support that. That's the fact for all of the thing you can buy from non apple site that stays that "It supports macbook" https://www.azdomes.com/product/usb-c-docking-station/
  
### Hands on experience 
 - huge touchpad is a good thing right? I wonder how people use apple watch together with that macbook thing. My miband just scratches the chassis all the time, on my msi touchpad was smaller so my wrist always was right near the chassis
 - Ok, I installed google chrome, I have core i9, 2tb ssd, 64RAM. Guess what happens when I try to maximize chrome window? Animation is freaking lagging. I have cpu at iddle, no other apps open and animation happens like 2-3 FPS. Freaking embarassing, 2 top 10 companies can make a soft that works together - facepalm
 - ok I downloaded slack, and it turns out that it doesn't have an icon tray, so now I have no way to inspect my slack notifictations. I've hidden the "dock" panel ( and if I didn't slack displays a red circle even if a notification was made from muted channel) . I've tried to install the https://getbitbar.com/ took me 20-30 mins to understand how to switch to python3 by default, install a package to python2 since macos permission system denies you access to system lib even if you're root. So you can't just do `ln -sf $(which python3) $(which pyhon)`. Oh you knw why everything doesn't crash? They just don't bump libs, new macos uses python2.7 which is no longer supported.
 - oh yeah if you hold your macbook on your belly sharp edges just scratch your body
 - I have a 5k $ machine and it has like 480x640 camera, what the hell? Well at least speakers and micrphone are good (there're laptops with the same quality)
 - usb flash feature from macbook (when you restart your mac in a disk mode) just doesn't work with my other laptop. I can't mount freaking apple device, how the fuck can you screw a mount storage (I mean if a 1$ usb flash drive can be mounted by every machine, why 5'000$ laptop can't)
 - I install iterm2, seems to be better than yakuake, can't find a featuer to open in at the same screen when it was opened b4, but I like the fact that it doesn't crash
 - ok, apple wifi hospot SUCKS. I created one and wasn't able to connect to it, neither from my Xiami mi9 niether from my another laptop. Both device can see it and both are unable to connect. 
 - when I connect to peer too peer patchcord DNS stops working on mac. So i can't google anymore (at least google.com is cached)
 -keyboard shortcut sucks, I wanted to run an app by a shorcut, intutial thing is to visit system preference and search for shortcuts, no apple allow to add a laucnh app from there, but it doesn't work. It turns out it's another feature. You need to know that there's an app call automator, in this thing you need to create a service and give it a unique name, then just match that name in keyboard shortcust (who there said that apple is so fucking userfriendly)
 - I still think mac is better than linux, at least everything works out of the box. I love that bluetooth earphones work along with integrated microphone, linux just don't support input from aptx via bluetooth.
 - touchbar is really an awesome thing. I was so against it, since a developer needs f5-f9 to debug things. Now i'm not sure why people keep coplaining about it,the surface feels really great, despite it's not a physical button, for those who need f1-f12 all the time, it can be done via settings, I'm ok with the things it shows above the keyboard, If i had to chose between touchbard mac and non-touchbar I would definitely stick to touchbar model
 - dark theme integration is better than any DE (kde|gnome|Lxde|mate)
 -wow scheduled boot is a really cool thing (it probably exists on linux too, but I doubt has a program can schedule a boot, should be some kind of bios alarm) but even that way i won't spend time on that on Linux, have other things to do.
  - ok I trying to copy all my files from msi to mac, took me 2 hour to setup vsftpd\pure-ftpd and I failed, all ftp on appstore cost money (really, this is ftp, not a gold formula). Who said that apple is so easy to use?
 - t2 chip aleviates cpue
 - fingerprint reader not really doing much, hven't use applepay yet
 - touchbar is really nice
 - speakers are really awesome,
 - mic is good as well.
 - camera is trash
 - machine is really quiet
 - i9 
 - bettery is good
 
 - brew sucks comparing to pacman/apt-get (no pkgfile or apt-file).
 - installing app has no visual progress, it's not clear when app finishes installing or whether it's already installed
 - bluetooth audieo fails some time, outputting either to right or left speaker, connecting to them as to a difference devies. I haven't had that issue on linux.
 - auto turn on after opening a lid is great feature
 - https://apple.stackexchange.com/questions/380732/non-official-usb-c-dock-station-detects-2-external-monitors-are-a-single-one
 - usb-c power supply is a cool thing, I bought 
 - touchbar is really nice, better than fn keys. Adaptation like having debug buttons open while debugging in Pycharm is really cool, Well you can't place fingertips on it like I did with function keys, but maybe the thing is need to get used to.
 - I didn't want to buy mac because it has limited amount of interfaces (only 4 thunderbolts) but after using an adapter which I connect all the things (external mouse/keyboard/ethernet/audio/display port/power supply) it's much easier to get home an inject only a single cable, rather than 10 cables.
 - fingerprint scanner fails a lot, my even my 400$ Xiaomi m9 has a better one (including a fact that's it's above the screen)
 - Apple ecosystem is freaking expensive and very poor. E.g. they don't have any adapter that supports 2 displays simultaneously. 
 - It turns out that macOS doesn't support [MST](https://medium.com/@sebvance/everything-you-need-to-know-about-macbook-pros-and-their-lack-of-displayport-mst-multi-stream-98ce33d64af4) so thus it 
 - some apps like time machine make life easy. You can also do the same in linux or windows, but did you do any anything if it doesn't come out of the box? I mean I don't spent time configuring automated backups, creating udev rules, making dd, checking if cp doesn't break files on live system,checking what happens on full disk size, restoring backups and etc, I can just trust apple that it works out of the box.
 - if you think that mac is awesome for its software that never bugs, it's not entirely true. If you bug things on apple.com it's probably gonna work. But there're 2 issues: 1) they are freaking expensive 2) apple.com doesn't sell of lot if things (like dockstation with many ports). The support for other hardware is even worse than Linux. I got 5$ hdmi adapter that some times display image incorrectly (30$ of display in unsuable). mac fails to detect an external display on azdome dockstation, and it's not hardware related coz it works on linux. So if linux were about to support only a single laptop model, it would be freaking amazing, instead if should support a million of hardware devices and moreoves OS based on linux should have a proper integration with the kernel and device. Other exampels: window on external screen on moving it to Full Screen mode, always moved from that screen to another one. Bluetooth audio sometimes has distortions (ok, this is because of mic https://support.apple.com/en-us/HT208896) Reconnecting the bluetooth work.
 - glossy displays accumulates things like a hell. I never touched it my hands, but after 3 weeks of using I spout some dirty fingerprint of something like this (could be my gf, or others). So I tried what would anyone tried to do: get the special things that are made for such cases and use them. 
  - default screenshoter with ability to record video for specific window or area is a nice thing
  - wtf is default commands: flags don't work, `git version 2.21.1 (Apple Git-122.3)` `find` `ls` and everything else sucks
  - language switcher is nice, hold ctrl to and press press while keep holding would turn `2 of N`, `ctrl+ space` will switch between those 2. I have ukr, russ, eng and I can switch withing single press
  - ok macos cryptoplugin from privatbank works out of the box, I spent 4 hours for settings it up on Linux, cause chromium had a different folder
  - screen holds fingerprints like a hell, it's impossible to wipe them out.
  - check the image in the github repo of how black looks on each display: left=middle price va; right=cheap ips; middle - macbook. Black colors are awesome, and colors are much better than my external displays one. Unfortunately 60Ghz sucks so much after I got used to 144Ghz.
  - defult display settings app sucks, I can not configure external monitor to 144GZ, too few settings, no custom resolution, no refresh rates, by default mac doesn't set max settings in display. Googling and installing google `brew cscreen` doesnt pick the new refresh rates as well. Hopefull free appstore app `Display Menu` detected monitor capabilities and I set 144Ghz. 
  - Ok, mac crashed fo the first time, screen became colored with a static weird image, touchbard didn't show anything and nothing happened during pressing the keyboard. This happened after ejecting an external docstation that has power thought it.
  - sleep doesn't work with external dock, it wakes up in 15 seconds
  - wifi doesn't connect after resuming from sleep (it shows that it tries to connect to my network, by manual restarting only helps)
  - touchbard doesnt work after sleep https://apple.stackexchange.com/questions/378022/touch-bar-not-turning-on-after-waking-computer-from-sleep 
  - macbook displays after display off( sleep, or just turnining off only display) set superwarm temperature, despite night mode is off, external display has exactly the same issue. Going to display settings and switching a few times between display profiles seem to help. 
 - macbook resets refresh rate on external screen after reconnect (plug out plug in/macbook reboot)
 - if macbook wakes up from sleep, with external display connected via USB, it just doesn't wake up at all, the screen is black. Also if you plug out the screen, after plugging it it constatly switchiing on off display (like onces per 5 seconds)
 -macbook has high resoltion 3kx2k? that's great, because you will probably use lower than full had, because mac doesn't have scaling like windows does. Higher resolution only supports something like antialiasing with a lower one. 
 - google calendar is awesome for macos, it has ability to create and accept events (comparing to Linux's things) and it also shows the notification on above other windows when the event is starting right b4 the event
  - macos save display preferences and if you connect the same set of displays again you won't need to rearrange that (it's so irritative on KDE, gnome, unity, xfce and other DE are even worse)
  - Macbook supports 5 displays (1 internal and 4 externals in extended mode), I'm not aware of other laptop that can do it (Well, at least w/o external thunderbolt videocard
  - macbook display is too colorful and bright, I thought it's a good thing, but after working full day on this monitor my eyes got really tired. I didn't have this on non-glossy "ordinary" screen. Got ipad to my dad, he claims the same, can't sit with his ipad for too long.
  - when multiple screen, display arrangement doesn't allow move mouse in cirtan area, thinking that it's no available no this monitor (like left section, or right section)
  - after going to sleep , displays just don't connect, some times you need to physically eject the cable and plug it in again. Sometime even after doing it like 10 times doesn't help. You need to power off the mac, and power it on again in order to detect the external screen. Evrything else just doesn't work, I tried to unplug the doc station, to power off the dock station to remove all cables from dock station , to attach another external monitor to dock station, to unplug the monitor from dock station, to unplug the dock station from the mac. Lets face the truth, mac is good on everything that comes with mac, anything that's not made by MAC (keyboard, mouse, external display, even if it's via USB mac just FUCK you with.)
  - sometimes locks by itself (while I'm working)
  - after sleep macbook sets brightness for external display to 100%
  - apple support sucks the same way other support sucks, https://discussions.apple.com/thread/250818057
  - homebrew package manager is so fucking slow...
  - smb works on macos even better than on windows, it automatically detects shared folder w/o even typing the IP
  - macos doesn't support aptx-hd, ldac audio codecs,iphones even don't support aptx
  - port 443 is available on mac w/o root
  - ssh copy text in terminal doesn't work
  - etc/host doesn't apply automatically, you may need to restart apps, like chrome
  - if macbook on low battery it won't turn on even plugged in to a charger. Wait like 3-5minutes to take some charge. This is fo freakling inconvenient when you forgot to plug it in and then when you urgently need it it won't turn on
  - SMC (system management controller or w/e its abbreviated from) is a freaking pain in the macbook ecosystem. Your external display doesn't connect sometime - reset SMC, macbook doesn't wakeup from sleep - reset SMC, your pancakes always burned ? - reset SMC.
  - My macbook doesn't start one time. It was always showing an icon that I need to connect a charger, despite a charger ( I tested it with my phone) worked ok. Guess what - resetting SMC changes. I don't expect that of a 5'000$ machine that worth 2 times more than same hardware non-apple system
