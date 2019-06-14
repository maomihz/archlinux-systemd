#!/bin/bash

_ssh-genkey() {
    while [ ! -z "$1" ]; do
        if [ ! -f "$1" ]; then
            ssh-keygen -f "$1" -t rsa -b 2048 -N ""
        fi
        shift
    done
}

_setup() {
    REPO="/aur"
    if [ ! -d "$REPO" ]; then
        echo Repository "$REPO" does not exist.
        exit 1
    fi

    sudo chown -R cat:cat "$REPO"
    pushd "$REPO"
    curl -LO https://aur.maomihz.com/cat.db.tar.gz \
         -LO https://aur.maomihz.com/cat.db.tar.gz.sig \
         -LO https://aur.maomihz.com/cat.files.tar.gz \
         -LO https://aur.maomihz.com/cat.files.tar.gz.sig
    for i in cat.{db,files}; do
        ln -sf "$i.tar.gz" "$i"
        ln -sf "$i.tar.gz.sig" "$i.sig"
    done
    popd

    # Generate ssh keys
    _ssh-genkey "$HOME/.ssh/id_rsa"
    echo
    echo "SSH Public Key:"
    cat "$HOME/.ssh/id_rsa.pub"

    # Update pacman database
    sudo pacman -Sy
}

_keys() {
    gpg --recv-keys \
    931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90 \
    474E22316ABF4785A88C6E8EA2C794A986419D8A \
    B6C8F98282B944E3B0D5C2530FC3042E345AD05D \
    EF6E286DDA85EA2A4BA7DE684E2C6E8793298290 \
    C52048C0C0748FEE227D47A2702353E0F7E48EDB \
    D8692123C4065DEA5E0F3AB5249B39D24F25E3B6 \
    031EC2536E580D8EA286A9F22071B08A33BD3F06 \
    3690C240CE51B4670D30AD1C38EE757D69184620 \
    8657ABB260F056B1E5190839D9C4D26D0E604491 \
    27EDEAF22F3ABCEB50DB9A125CC908FDB71E12C2 \
    6645B0A8C7005E78DB1D7864F99FFE0FEAE999BD
}

_git() {
    aur repo -l | cut -f 1 | grep -e -git | xargs aur sync --nover --print --ignore-file=$HOME/ignore.txt
}

_import() {
    gpg --import --batch
    gpg -aso- /dev/null
}


_help() {
    echo "Usage: $0 {setup|keys|git|help}"
}

_main() {
    CMD="$1"
    if [ ! -z "$CMD" ]; then
        shift 1
    fi


    case "$CMD" in
        setup)
            _setup $@
            ;;
        echo)
            echo $@
            ;;
        keys)
            _keys $@
            ;;
        git)
            _git $@
            ;;
        import)
            _import $@
            ;;
        help)
            _help $@
            exit 1
            ;;
        *)
            _setup $@
            ;;
    esac
}

_main $@
