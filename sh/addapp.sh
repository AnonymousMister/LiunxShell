#!/usr/bin/env bash 
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
OLD_IFS="$IFS"

brewInstall='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"';
brew="brew"
brewCask="brew cask"
initApp=("$brew install mas");
caskApp="baiduinput,baidunetdisk,google-chrome,clashx,cakebrew,jetbrains-toolbox,visual-studio-code,wiznote,homebrew/cask-versions/microsoft-remote-desktop-beta,docker,bartender,postman,TeamViewer"


install_brew(){
    i=0;
    which "$brew" > /dev/null
    if [ $? -eq 0 ]; then
    printf "Homebrew 已存在\n"
    else
     printf "开始安装 Homebrew》》》\n"
     eval $brewInstall
     wait
     if [ $? -eq 0 ]; then
      printf "Homebrew 安装完成。。。。\n"
    else
     printf "Homebrew 安装失败。。。。\n"
     i=1;
    fi
fi
return $i;
}

install_brewApp(){
  appShell=$1;
  l=${!appShell[@]};
      b=''
      i=0
      while [ $i -le  $l ]
      do
          printf "progress:[%-50s]%d%%\r \n" $b $i
          eval ${appShell[$i]} >> "app.log"
          wait
          i=`expr 2 + $i`       
          b=#$b
      done
}

i=$(install_brew)
if [ $? == 0 ]; then
  install_brewApp "$initApp"
fi


