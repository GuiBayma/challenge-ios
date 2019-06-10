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

install_rbenv() {
    if [[ $(brew ls --versions rbenv) == "" ]]
    then
        echo "Instalando rbenv"
        brew install rbenv
        echo "rbenv Instalado";
    else
        echo "rbenv já Instalado";
    fi
}

switch_ruby_version() {
    echo "Alterando ruby para versão 2.4.0"
    echo "eval \"\$(rbenv init -)\"" >> ~/.bash_profile
    rbenv install 2.4.0
    rbenv local 2.4.0
    source ~/.bash_profile
    echo "ruby alterado"
}

install_gemfile_dependencies() {
    echo "Instalando Packages do Gemfile"
    bundle install
    echo "Packages do Gemfile Instaladas"
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

bootstrap_carthage() {
    echo "Instalando Packages do Carthage"
    cd Lodjinha
    mint run carthage carthage bootstrap --platform iOS --no-use-binaries --cache-builds
    echo "Packages do Carthage Instaladas"
}

install_homebrew
install_rbenv
switch_ruby_version
install_gemfile_dependencies
install_mint
install_swiftgen_dependencies
bootstrap_mint
bootstrap_carthage

echo "🚀 Bootstrap finalizado! Pronto para codar!"