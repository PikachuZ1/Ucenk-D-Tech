#!/bin/bash
# ==========================================
# Installer Otomatis Ucenk D-Tech Pro v3
# Fix: Custom Prompt Ucenk D-Tech$
# ==========================================

# 1. Update dan Install semua Tools
pkg update && pkg upgrade -y
pkg install php git figlet curl python inetutils neofetch zsh -y
pip install lolcat

# 2. Install Oh My Zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 3. Install Plugin Auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 4. Download Mikhmon
cd $HOME
rm -rf mikhmonv3 ~/session_mikhmon ~/tmp
git clone https://github.com/laksa19/mikhmonv3.git

# 5. Konfigurasi .zshrc (Prompt Kustom)
cat << 'EOF' > ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# --- CUSTOM PROMPT UCENK D-TECH ---
# Ini yang mengubah bagian depan sebelum ngetik
PROMPT='%F{green}[Ucenk %F{cyan}D-Tech%F{white}]%F{yellow} ~ $ %f'

# --- TAMPILAN BANNER ---
clear
echo "======================================================" | lolcat
figlet -f slant "Ucenk D-Tech" | lolcat
echo "      Author: Ucenk  |  Premium Network Management System" | lolcat
echo "======================================================" | lolcat
echo " Welcome back, Ucenk D-Tech!" | lolcat

# Logo Ubuntu Paksa
neofetch --ascii_distro ubuntu

echo " Ketik 'mikhmon' untuk menjalankan server."  | lolcat
echo " Ketik 'telnet (IP OLT)' untuk remote management OLT." | lolcat
echo "-----------------------------------------------"

# Alias Mikhmon
alias mikhmon='fuser -k 8080/tcp > /dev/null 2>&1; \
export PHP_INI_SCAN_DIR=$HOME/tmp; \
mkdir -p ~/tmp ~/session_mikhmon; \
echo "opcache.enable=0" > ~/tmp/custom.ini; \
echo "session.save_path=\"$HOME/session_mikhmon\"" >> ~/tmp/custom.ini; \
echo "Mikhmon berjalan di http://127.0.0.1:8080"; \
php -S 127.0.0.1:8080 -t ~/mikhmonv3'
EOF

# 6. Set Default Shell & Bersihkan Login
chsh -s zsh
touch ~/.hushlogin

clear
echo "Berhasil! Sekarang Prompt kamu sudah menjadi [Ucenk D-Tech] ~ $ "
echo "Silakan restart Termux."
