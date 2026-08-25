#!/bin/bash

npm install hexo

cd blog/

npm install

npm install hexo-deployer-git

npm install -S hexo-theme-icarus hexo-renderer-inferno

# clone icarus from git in theme

# cd theme/

# git clone https://github.com/ppoffice/hexo-theme-icarus.git 

echo "hexo icarus config finished."
