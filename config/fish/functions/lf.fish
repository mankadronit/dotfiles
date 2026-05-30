function lf --description 'lf file manager; cd into the last directory on exit'
    set -l tmp (mktemp)
    command lf -last-dir-path=$tmp $argv
    if test -f $tmp
        set -l dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"; and test "$dir" != "$PWD"
            cd "$dir"
        end
    end
end
