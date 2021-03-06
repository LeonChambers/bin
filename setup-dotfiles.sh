git clone --bare https://github.com/LeonChambers/dotfiles.git $HOME/.cfg
function dotfiles {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p $HOME/.cfg-backup
dotfiles checkout
if [ $? = 0 ]; then
    echo "Checked out config.";
else
    echo "Backing up pre-existing dot files";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .cfg-backup/{};
fi
dotfiles checkout
dotfiles config status.showUntrackedFiles no
