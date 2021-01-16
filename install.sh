#! /bin/bash
printf "正在进行异步安装 " >&2
{
sudo useradd -m CYF
sudo adduser CYF sudo
echo 'CYF:1234' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 
sudo adduser CYF chrome-remote-desktop
} &> /dev/null &&
printf "\n安装完成 " >&2 ||
printf "\n安装失败 " >&2
printf '\n请进入https://remotedesktop.google.com/headless 获取liunx密钥并复制在这个地方\n'
read -p "粘贴在这里: " CRP
su - CYF -c """$CRP"""
printf '开始安装中文字体'
wget -O font.zip https://codeload.github.com/ChenYFan/GoogleColabRDP/zip/main
unzip font.zip
sudo mv GoogleColabRDP-main/win_cn_fonts/ /usr/share/fonts/win_font/
sudo fc-cache -fv
printf '完毕！请进入https://remotedesktop.google.com/access/ \n\n'
if sudo apt-get upgrade &> /dev/null
then
    printf "\n\n更新完毕 " >&2
else
    printf "\n\n更新失败 " >&2
fi
