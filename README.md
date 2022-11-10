![ubuntu-focal](https://img.shields.io/badge/ubuntu-20.04-red)
![ubuntu-hirsute](https://img.shields.io/badge/ubuntu-21.04-red)
![ubuntu-jammy](https://img.shields.io/badge/ubuntu-22.04-red)
![hamonikr-hanla](https://img.shields.io/badge/hamonikr-hanla-purple)
![hamonikr-taebaek](https://img.shields.io/badge/hamonikr-taeback-green)

## grub-theme-taebaek

 * 사용자 해상도 자동 감지 후 테마 해상도 적용
 * 와이드 스크린의 경우 자동으로 비율을 계산
 * `D2Coding` , `Terminus` fonts

## Install

### 하모니카 OS (>=5.0)
```
wget -qO- https://update.hamonikr.org/add-update-repo.apt | sudo -E bash -

sudo apt install grub-theme-taebaek
```

### Other Ubutu base distro. (Ubuntu >=20.04)
Release 페이지에서 배포한 최신 패키지를 다운로드 받아서 아래와 같이 설치.

sudo apt install -f ./grub-theme-taebaek_*_amd64.deb

### Install from source
다운로드 받은 디렉토리 안으로 이동하여 아래 명령어를 입력

```sudo ./install.sh```

설치 후 시스템을 재시작 하면 grub 테마가 적용됩니다.

 * 테마 화면이 보이지 않는 경우 grub 설정을 확인하세요. (하모니카의 기본값은 hidden)
 ```cat /etc/default/grub | grep GRUB_TIMEOUT_STYLE```
 * 위 명령어의 결과가 hidden 으로 되어 있는 경우 grub 화면이 숨겨져서 보이지 않습니다.
 * ```#GRUB_TIMEOUT_STYLE=hidden``` 처럼 해당 줄의 맨 앞에 '#' 표시를 추가하고 저장 후 ```sudo update-grub``` 으로 grub 이미지를 재생성 후 시스템을 재시작하세요.


### How to create grub font
```
sudo grub-mkfont --output=/boot/grub/fonts/NanumGothicCoding.pf2 --size=32 ~/.local/share/fonts/NanumGothicCoding.ttf
```

### How to convert png from icons-svg folder
Use convert-svg-app (https://github.com/hamonikr/convert-svg)
```
convert-svg-app
```

# License
 * GPL v3
 

 # 이슈 또는 버그
 사용 중 문제를 발견하시면 root@hamonikr.org 또는 https://groups.google.com/forum/m/#!forum/hamonikr 에서 알려주세요.
