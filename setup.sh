#!/bin/bash
# Rebuilds the dev environment after a Workspace reset.
# Usage:  source setup.sh

# 1. Install Miniconda if it's missing
if [ ! -d "$HOME/miniconda3" ]; then
  echo ">> Installing Miniconda..."
  curl -L -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  bash ~/miniconda.sh -b -p $HOME/miniconda3
  $HOME/miniconda3/bin/conda init bash
fi
source $HOME/miniconda3/etc/profile.d/conda.sh

# 2. Accept conda Terms of Service
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# 3. Create the project environment if it's missing
cd /workspace/Project-Build-an-ML-Pipeline-Starter
if ! conda env list | grep -q "nyc_airbnb_dev"; then
  echo ">> Creating nyc_airbnb_dev (this takes a while)..."
  conda env create -f environment.yml
fi
conda activate nyc_airbnb_dev

# 4. W&B login (only prompts if not already logged in)
if [ ! -f "$HOME/.netrc" ]; then
  wandb login
fi

git config --global user.name "Arya"
git config --global user.email "your-email@example.com"
git config --global pull.rebase false
git pull
echo ">> Ready. Python: $(which python)"
