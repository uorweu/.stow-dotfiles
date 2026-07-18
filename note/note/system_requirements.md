 -- SYSTEM UBUNTU-24.04 -- 

architecture amd64
gpu can be anything because we use the open-source one to allow the access 
also we install allow of the package for linux-firmware to connect to the hardware of different firmware

# turn on the conservation_mode (1 for on 0 for off)
echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

---------------------------------------------------------
# keybinding 
keyd 
## installation to $HOME/build-programs/programs/keyd/
// keep this folder for remove or somehow lost this folder just clone this folder back and make uninstall 
```bash
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable --now keyd
```
## the config file is in
```bash
/ect/keyd/default.conf
```
start the service and then reload the config file by
```bash 
sudo keyd reload
```

# Create some folder for the system to works with sway
```bash
mkdir -p $HOME/Pictures/Screenshots/ &&
mkdir $HOME/Downloads
```
# neovim 
>[!warning] notice!
> i just store the bashscript for build the program 
> i don't push the whole folder to build a program
> i just push the folder bashscripts_installation 
> you need to put this folder to the right directory

build neovim from the source (because new version of neovim make the bug that double enter and backspace //in sway install from sratch - found out that only version 0.11.6 work fine)
## steps to build
Create a folder for build-programs
```bash
mkdir -p $HOME/build-programs/bashscripts_installation
mkdir -p $HOME/build-programs/programs
```
//programs folder contain the folder for the source to build and can be uninstall in the future
//bashscripts_installation folder use to store bashscript to make the installation for the folder programs faster

now create the folder for the program neovim 
```bash
mkdir -p $HOME/build-programs/programs/neovim
```
now run the bashscripts
```bash
chmod +x $HOME/build-programs/bashscripts_installation/neovim.sh
$HOME/build-programs/bashscripts_installation/neovim.sh
```
and this is the explanation for how can we remove neovim from the "apt" not using the build folder although we build it from the source

##### Explanation

-----------------------------------------------------------------------------------
# Managing Custom Builds: Make Install vs. Debian Packages

When compiling software from source (like Neovim), there are two primary ways to install the compiled files onto your Ubuntu/Debian system. Understanding the difference is crucial for maintaining a clean and stable operating system.

## Method 1: The "Off the Books" Approach (`sudo make install`)

This is the traditional method for installing software built from source, but it bypasses the system's package manager.

* **The Action:** The `make install` command takes the raw compiled files and manually copies them into standard system directories (typically under `/usr/local/`).
* **The Problem:** The system package manager (`apt`/`dpkg`) is completely unaware that these files exist. They are not registered in the official software database.
* **The Cleanup Process:** Because `apt` cannot track these files, uninstalling requires relying on a log file generated during the build process (e.g., `install_manifest.txt`). You must manually delete the exact files listed in that log.

**Uninstalling a `make install` build:**
```bash
cd path/to/build/directory
sudo xargs rm -vf < install_manifest.txt
```

## Method 2: The "Official Ledger" Approach (cpack -G DEB)
This is the recommended standard for Ubuntu/Debian systems. It integrates your custom build directly into the operating system's native package ecosystem.

 The Action: Instead of copying raw files to system directories, cpack wraps all the compiled files and installation instructions into an official Debian shipping container (a .deb file).

 The Registry: When you install the .deb file using dpkg -i, the package manager reads the container's instructions, places the files on the system, and writes down every single file location in Ubuntu's central database.

 The Cleanup Process: Because the software is officially registered, apt has full jurisdiction over it. Uninstalling is as simple as removing any standard package.

Building and installing with cpack:
```bash
cd build
cpack -G DEB
sudo dpkg -i nvim-linux64.deb
```

Uninstalling a .deb package cleanly:
```bash
sudo apt remove nvim
```
---------------------------------------------------------------------------------

# GPU
// use open-source ndivia GPU 
sudo apt update
sudo apt install mesa-utils libgl1-mesa-dri libegl-mesa0 libgbm1 xwayland -y
sudo apt install xserver-xorg-video-nouveau -y
(need a reboot after installation)
# install these for audio control in sway through fn key
sudo apt update
sudo apt install -y pipewire wireplumber
systemctl --user enable --now pipewire wireplumber
(now we can use wpctl to control audio through fn + F12 F11 F10)
# brightness
sudo apt install -y brightnessctl
sudo apt install -y libinput-tools
sudo libinput debug-events --show-keycodes
> need to reboot after these installation 

----------------------------------------------------------------------------------

# apt
man-db manpages-dev manpages-posix-dev (for C developer - those package work with lazyvim so we can use shift k to open man inside of the text editor to view the function or the command) 
xarchiver (extractor for compressed file)
fzf
alsa-utils (for arecord)
acpi-call-dkms (for Linux kernel to communicate directly with your laptop's ACPI in Lenovo - for control Conservation Mode for the Battery)
tp-smapi-dkms (provides additional interface support for various ThinkPad and IdeaPad hardware sensors and power controls)
linux-modules-extra-$(uname -r)  // This package contains a large collection of hardware-specific drivers may not included in the kernel 
//after install these use the to apply
sudo modprobe acpi_call
## Check conservative mode or not
cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode 
// 0 is disable - 1 is on
mpv (for audio player on terminal)
stow
rfkill (to check the hardware)
nmap (for network config)
swayidle 
swaylock
wl-clipboard
C compiler
xwayland
dbus-user-session
sway
swayimg
tree
wofi
zoxide
slurp
grim 
gimp
alacritty (i change to use foot for main terminal emulator - it is written in my favorite language which is C and go default of sway)
thunar
bluez 
blueman
pavucontrol
wev
curl
tar
wget 
unzip
fontconfig (create a folder for config font: "mkdir -p ~/.local/share/fonts")
btop
waybar (// install some dependencies for it work better without showing warning: sudo apt install -y xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk)

## Antigravity (the whole IDE not the CLI one)
https://antigravity.google/download/linux

So why don't we just and the source list of antigravity to the source list be have to do some extra step just to install an Software?
The answer comes down to two main things: Security (Trust) and System Organization.
```bash
sudo mkdir -p /etc/apt/keyrings 
# the directory /ectc/apt/keyrings is already exist in the Ubuntu distribution (but there are nothing inside but we should keep this directory for futture use)
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
```

the directory /ectc/apt/keyrings is already exist in the Ubuntu distribution so we not gonna delete this folder 

If I just added the repository link to your system without this step, my computer would refuse to install the software. It would throw a big red NO_PUBKEY error.
Why? To prevent Man-in-the-Middle attacks.
When APT downloads a package from a server, it needs to know that the package genuinely came from the Antigravity developers and wasn't intercepted and replaced with malware by a hacker.
- The developers "sign" their software with a private cryptographic key.
- That curl command downloads their public key and saves it to your computer.
- When APT downloads the package, it uses that public key to verify the signature. If it matches, APT knows the file is safe.
--> BUT it works is quite different
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
The Two-Key System

Instead of one password or key, this system relies on a mathematically linked pair of keys:

    The Private Key (The Pen): This is kept incredibly secret. Only the actual developers of Antigravity have it. It is stored on highly secure servers. This key is used to physically "sign" the .deb software packages before they are uploaded to the internet.

    The Public Key (The Authenticator): This is the repo-signing-key.gpg file you downloaded using the curl command. It is entirely public. The developers want everyone in the world (including hackers) to have it.

The magic of the math is this: The Public Key can only verify a signature made by its exact matching Private Key. It can never be used to create a signature.
The Hacker Scenario

Let's imagine a hacker sits between you and the Antigravity servers (a Man-in-the-Middle attack).

    You run sudo apt install antigravity.

    The hacker intercepts this request and tries to send your computer a fake, virus-infected version of the Antigravity software instead of the real one.

    The Roadblock: Your apt package manager receives the fake software. Before installing, apt looks at the public key you downloaded earlier and says, "Okay, let me check the signature on this file."

Because the hacker does not have the developers' secret Private Key, they cannot create a valid signature for their virus.

    If the hacker sends the virus with no signature, apt rejects it.

    If the hacker creates their own private key and signs the virus with that, apt uses your downloaded Public Key to check it. The math won't match, and apt will flash a giant warning and refuse to install the software.

The Wax Seal Analogy

Think of it like a king sending a letter:

    The king has a custom, physical ring (the Private Key) that he presses into hot wax to seal the letter.

    He sends a drawing of his ring's exact imprint (the Public Key) to every town in the kingdom, including to the thieves.

    A thief can intercept the king's letter and write a fake one. But because the thief doesn't have the king's actual ring, they can't recreate the wax seal. Even though the thief knows exactly what the seal is supposed to look like (because they have the drawing), they can't forge it.

### the second point is:

The Analogy: The Master Address Book vs. The Business Card Folder

Imagine your package manager (apt) is a delivery driver who needs to know where to pick up software.

    sources.list (The Master File): This is the official, bound, hardcover address book provided by Canonical (the makers of Ubuntu). It contains all the trusted, core warehouses for your operating system.

    sources.list.d/ (The .d Directory): The .d stands for "directory." Think of this as a separate physical folder where you can drop in loose business cards for third-party warehouses—like Antigravity, Spotify, or Google Chrome.

When you run apt update, the delivery driver first reads the Master Address Book, and then checks the folder for any extra business cards you’ve added.
Why not just write in the Master Book?

1. The "Blast Radius" of a Typo (Safety)
If you open your main sources.list file and accidentally delete a comma, misspell a URL, or paste something on the wrong line, you corrupt the entire file. The next time you try to update your system or install anything, apt will completely crash and throw a fatal error.
By putting the Antigravity link in its own isolated file (antigravity.list), a typo will only break the updates for Antigravity. The rest of your Ubuntu system remains perfectly safe and functional.

2. Scripting and Automation
When developers write installation instructions (like the ones in your screenshot), they want the computer to do the work for you.

    Writing code that opens a massive text file, searches for a specific blank line, inserts a new link, and saves it without breaking anything else is surprisingly difficult and prone to errors.

    Writing code that just says "Create a new text file named 'antigravity' and dump this link inside it" is incredibly easy and safe. That is exactly what the echo ... | sudo tee command in your screenshot is doing.

3. Clean Uninstallation

If you decide you don't want Antigravity anymore, you need to tell apt to stop looking for its updates.
If you had pasted the link into your main sources.list, you would have to open the file, carefully hunt down that specific line among dozens of others, and delete it manually.
Because it's in the .d folder, uninstallation is effortless. You just tell the system to throw away that one specific "business card":
sudo apt remove antigravity 
sudo rm /etc/apt/sources.list.d/antigravity.list
sudo rm /etc/apt/keyrings/antigravity-repo-key.gpg (remove the keyrings)


# Antigravity-CLI

curl -fsSL https://antigravity.google/cli/install.sh | bash

Modern CLI tools (especially those written in languages like Go or Rust) are often compiled into one single, standalone executable. They do not need hundreds of dependency files scattered across your system libraries like older software does.

Here is exactly what the install.sh script did behind the scenes, and what else might be lingering on your system.
What the Script Actually Did

When you piped that script into bash, it ran a sequence of automated checks:

    System Check: It checked your operating system (Linux) and your CPU architecture (e.g., x86_64 or ARM).

    Download: It reached out to the Google servers and downloaded the specific, single binary file built for your exact hardware.

    Placement: It moved that single file into your ~/.local/bin/ directory and named it agy.

    Permissions: It ran a command like chmod +x to make sure your system knew the file was allowed to be executed as a program.

so we have to add the the path of the shell so we can you that command

rm ~/.local/bin/agy

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
# Syncthing

## Add the release PGP keys:
sudo mkdir -p /etc/apt/keyrings (i got this folder already)
```bash
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" | sudo tee /etc/apt/sources.list.d/syncthing.list
```

sudo apt-get update
sudo apt-get install syncthing
### for removing 
sudo apt remove syncthing
sudo apt autoremove 
sudo rm /etc/apt/keyrings/syncthing-archive-keyring.gpg (remove the keyrings)
sudo rm /etc/apt/sources.list.d/syncthing.list.list (remove the source list)
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
# Docker
## installation
### Explain the steps
so to add the keyring and the sources list to the machine in order to the package manager can control that tool/packages/... for installation through TCP/IP protocol we need another step for prevent the "fake" keyprings
through install a dependencies that only run on the background to check the trusted keyrings

```bash

sudo apt install ca-certificates
# as i check it is already installed on the apt package manager
# it is a background dependency built for your package manager (apt),
# so this is the only time that we interact with this dependencies, it just the background things for other things to get to do things
```
Before your system even knows what data is inside the file, it needs to download it from the internet using curl or wget
When you type curl https://..., the curl program automatically goes to the background folder where ca-certificates stores its trust list (usually /etc/ssl/certs/). It checks the website's certificate against that list. You don't have to tell curl to do this; it does it by default.

When it happens: At the exact moment you try to connect to https://download.docker.com.
What it checks: It verifies that the website server is actually owned by Docker and that a hacker hasn't hijacked your internet connection to send you fake files.
If it fails: curl stops immediately. The file never even downloads to your hard drive.

Once the file is safely downloaded, your package manager (apt) takes over to install it.

    When it happens: When you actually run sudo apt install.
    What it checks: It opens the downloaded package and checks the internal GPG digital signature against the key file you put in your /etc/apt/keyrings/ folder. This proves the software was built and signed by Docker's developers, and wasn't tampered with before it was uploaded to the server.
    If it fails: apt stops and refuses to install the software, warning you that the package is unverified.

// the whole link for installation is here: https://docs.docker.com/engine/install/ubuntu/
after we adding the keyrings we now can add the source list of Docker for the package manager to install it

```bash
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

# then install the lastest version
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
## Uninstallation 

# Stop Docker services
sudo systemctl stop docker.socket docker-service containerd 2>/dev/null

# Purge Docker packages and autoremove lingering dependencies
sudo apt-get purge --auto-remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Delete the dedicated source list file
sudo rm -f /etc/apt/sources.list.d/docker.list
sudo rm -f /etc/apt/sources.list.d/docker.sources

# Delete the GPG keyring file you added to the folder
sudo rm -f /etc/apt/keyrings/docker.asc

# Remove the hidden data storage 
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Refresh the package manager
sudo apt-get update

----------------------------------------------------------------------------------------------

## install blexmononerd font
```bash
mkdir -p /tmp/IBMPlexMono && cd /tmp/IBMPlexMono
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IBMPlexMono.zip
unzip IBMPlexMono.zip -d ~/.local/share/fonts/
rm -rf /tmp/IBMPlexMono
```
## install iosevka term nerd font
```bash
mkdir -p /tmp/IosevkaTerm && cd /tmp/IosevkaTerm
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip
unzip IosevkaTerm.zip -d ~/.local/share/fonts/
rm -rf /tmp/IosevkaTerm
```

now install them into the system: 
```bash
fc-cache -fv
```
------------------------------------------------------------------------------------------

# homebrew
fd (for LazyVim for search)
tmux

----------------------------------------------------------------------------------------

# flatpak (installed through apt //needed reboot to use flatpak)
flathub (install through command "sudo flatpak remote-add --i-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo")
zen (through command "flatpak install flathub io.github.zen_browser.zen")
## allow flatpak to access Wayland
```bash
flatpak override --user --socket=wayland --socket=x11 --share=ipc
```
//then can use wofi to open zen

## create the folder for download from zen to go into that folder

obsidian
```bash 
# This ensures your system knows where to find the package:
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Download and install the package:
flatpak install flathub md.obsidian.Obsidian
# then we can open it through wofi or just run the command to from flatpak to run it
```
sioyek
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.ahrm.sioyek
# set as default for open pdf file
xdg-mime default com.github.ahrm.sioyek.desktop application/pdf
```
------------------------------------------------------------------------------

## Bluetooth problem (the output sound don't out through bluetooth earphone)

# 1. Stop all services
systemctl --user stop pipewire wireplumber pipewire-pulse
sudo systemctl stop bluetooth

# 2. Force reinstall the audio-bluetooth bridge (Crucial step)
sudo apt install --reinstall libspa-0.2-bluetooth

# 3. Clean the WirePlumber "memory" (which is likely corrupted)
rm -rf ~/.local/state/wireplumber/

# 4. Start everything back up
sudo systemctl start bluetooth
systemctl --user start pipewire pipewire-pulse wireplumber

#### Explanation
performed a clean reset of the audio-Bluetooth bridge and cleared the corrupted state of your audio controller.

Here is exactly what happened during that "Total Reset":

    The Audio-Bluetooth Bridge was fixed: Reinstalling libspa-0.2-bluetooth ensured that your system has the proper "translator" software required to convert raw Bluetooth radio signals into high-quality audio streams.

    The "Ghost" cache was cleared: By running rm -rf ~/.local/state/wireplumber/, you deleted the hidden configuration files where your system had "cached" the earphones as an "unavailable" or "data-only" device.

    The Audio Manager was forced to re-scan: Restarting wireplumber (your audio system's "brain") forced it to re-examine all connected devices from scratch, which allowed it to finally detect the Audio Sink (A2DP) profile that was previously being ignored.

    The Bluetooth Handshake was stabilized: By restarting the bluetooth service and forcing a reconnection, you moved the connection from a limited "Data/Battery" profile to the full "Classic" (BR/EDR) audio profile required for music playback.

Essentially, your system was "stuck" in a state where it remembered your earphones as a simple battery monitor; the reset forced the computer to introduce itself to the earphones all over again, this time correctly identifying them as an audio device
// may restart waybar to take effect for the volume


# tailscale 

curl -fsSL https://tailscale.com/install.sh | sh

rm ~/.local/bin/tailscale

# Python3 (already there) but python3.12-venv isn't (for create the venv environment)
```bash
sudo apt install python3.12-venv
```


# the toolchains for embedded system programming









# Dotfiles need to be stored 
~/.config/nvim 
~/.config/foot/foot.ini
~/.config/sway/config
~/.config/waybar/
~/.tmux.conf
~/vimium.css
~/note/system_requirements.md
~/.bashrc
// .bashrc (has the path for homebrew and zoxide and the git status prompt that require this command: curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh)

// to make the config file for "sioyek"
check the /home/norman/.var/app/com.github.ahrm.sioyek/config/.local/share/Sioyek  whether it has the config file for user
```bash
ls -al /home/norman/.var/app/com.github.ahrm.sioyek/config/.local/share/Sioyek

```
if there isn't the file name:
```bash
prefs_user.config
```
then create that file and add this content to be able to open multiple file with sioyek
```config
should_launch_new_window 1
```


# Instal the requirements

```bash
sudo apt update && sudo apt full-upgrade
sudo apt install stow mesa-utils libgl1-mesa-dri libegl-mesa0 libgbm1 xwayland alsa-utils  xserver-xorg-video-nouveau pipewire wireplumber brightnessctl libinput-tools alsa-utils acpi-call-dkms tp-smapi-dkms linux-modules-extra-$(uname -r) rfkill nmap  swayidle swaylock wl-clipboard gcc xwayland dbus-user-session sway swayimg tree wofi zoxide slurp grim gimp thunar bluez blueman pavucontrol wev curl tar wget unzip fontconfig btop waybar xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk fzf mpv xarchiver man-db manpages-dev manpages-posix-dev -y
```

how to use gnu stow
https://www.youtube.com/watch?v=TLFsee7DDSI&t=322s

 
