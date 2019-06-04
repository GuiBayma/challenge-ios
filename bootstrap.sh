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

install_swiftgen_dependencies() {
    if [[ $(brew ls --versions libxml2) == "" ]]
    then
        echo "Instalando libxml2"
        brew install libxml2
        echo "libxml2 Instalado";
    else
        echo "libxml2 já Instalado";
    fi
}

bootstrap_mint() {
    echo "Instalando Packages do Mint"
    mint bootstrap
    echo "Packages do Mint Instaladas"
}

install_homebrew
install_mint
install_swiftgen_dependencies
bootstrap_mint

echo "🚀 Bootstrap finalizado! Pronto para codar!"