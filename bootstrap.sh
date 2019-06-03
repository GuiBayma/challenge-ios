install_homebrew() {
    if [[ $(command -v brew) == "" ]]
    then
        echo "Instalando Hombrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo "Homebrew Instalado";
    else
        echo "Atualizando Homebrew"
        brew update
        echo "Homebrew Atualizado";
    fi
}

install_mint() {
    if [[ $(brew ls --versions mint) == "" ]]
    then
        echo "Instalando Mint"
        brew install mint
        echo "Mint Instalado";
    else
        echo "Mint já Instalado";
    fi
}

bootstrap_mint() {
    echo "Instalando Packages do Mint"
    mint bootstrap
    echo "Packages do Mint Instaladas"
}

install_homebrew
install_mint
bootstrap_mint

echo "🚀 Bootstrap finalizado! Pronto para codar!"