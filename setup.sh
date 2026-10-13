#!/bin/bash
# Usage: source setup.sh
if [ ! -d "$HOME/miniconda3" ]; then
  curl -L -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  bash ~/miniconda.sh -b -p $HOME/miniconda3
  $HOME/miniconda3/bin/conda init bash
fi
source $HOME/miniconda3/etc/profile.d/conda.sh
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
cd /workspace/Project-Build-an-ML-Pipeline-Starter
if ! conda env list | grep -q "nyc_airbnb_dev"; then
  conda env create -f environment.yml
fi
conda activate nyc_airbnb_dev
# export WANDB_ENTITY=your-wandb-username   # uncomment if runs go to the wrong team
git config --global user.name "trhod65"
git config --global user.email "trhod65@wgu.edu"
git config --global pull.rebase false
if [ ! -f "$HOME/.netrc" ]; then wandb login; fi
git pull
echo ">> Ready. Python: $(which python)"
