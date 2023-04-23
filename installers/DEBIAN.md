```bash
#!/bin/bash
sudo apt update && sudo apt dist-upgrade -y

lspci -nn | egrep -i "3d|display|vga"

sudo apt install -y nvidia-detect linux-headers-amd64 firmware-misc-nonfree firmware-linux firmware-linux-nonfree
wget https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt install -y software-properties-common
sudo add-apt-repository contrib non-free
sudo apt-get update
# cuda 12.x still can't compile pytorch on debian 11
sudo apt install -y \
  git gcc make curl wget build-essential \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
  libffi-dev liblzma-dev htop neofetch\
  python3 python3-pip python3-venv python3-openssl python-is-python3 \
  cuda-11-8 nvidia-kernel-dkms
# install pyenv
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
source ~/.bashrc
python --version
pip install --upgrade pip
pip install --upgrade setuptools
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh -O anaconda3-2023.03-Linux-x86_64.sh
chmod +x anaconda3-2023.03-Linux-x86_64.sh
bash anaconda3-2023.03-Linux-x86_64.sh
```

(optional) Enlarge the swapfile

```bash
sudo fallocate -l 31G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon -s
```

add an entry to your `/etc/fstab` file to make the swapfile permanent

```bash
echo "/swapfile   none    swap    sw    0   0" | sudo tee -a /etc/fstab
```

(optional) Reboot to apply the changes and instantiate the env variables

```bash
sudo reboot
```