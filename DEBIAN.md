```bash
#!/bin/bash
sudo apt update && sudo apt dist-upgrade -y

sudo apt install -y \
  git gcc make curl wget build-essential \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
  libffi-dev liblzma-dev htop neofetch\
  python3 python3-pip python3-venv python3-openssl python-is-python3

curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
source ~/.bashrc
pyenv install 3.11.3
pyenv global 3.11.3
python --version
pip install --upgrade pip
git clone https://github.com/oobabooga/text-generation-webui.git
cd text-generation-webui
pip install -r requirements.txt
mkdir models/alpaca-7B-NE
wget https://huggingface.co/Pi3141/alpaca-7b-native-enhanced/resolve/main/ggml-model-q4_1.bin \
  -O models/alpaca-7B-NE/ggml-model-q4_1.bin
python server.py --listen --model alpaca-7B-NE --threads 7 --chat
```

Enlarge the swapfile

```bash
sudo fallocate -l 31G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon -s
```

add an entry to your `/etc/fstab` file to make the swapfile permanent

```bash
/swapfile   none    swap    sw    0   0
```

