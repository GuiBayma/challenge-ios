# A Lodjinha

Desafio iOS para AmeDigital.

## Documentação

A documentação do projeto com instruções pode ser encontrada na [Wiki](https://github.com/GuiBayma/challenge-ios/wiki) do repositório git.

## Bootstrap

Para começar o desenvolvimento do projeto, após clonar o repositório rode o script de bootstrap:

```console
$ sh bootstrap.sh
```

### Mint

[Mint](https://github.com/yonaskolb/Mint) é o gerenciador de dependencias utilizado no projeto.

Caso exista uma nova dependência adicionada ao `Mintfile` rode:

```console
$ mint install <nome do package>
```

Ou rode o script de bootstrap novamente.

### Carthage

[Carthage](https://github.com/Carthage/Carthage) é o gerenciador de frameworks do projeto.

Caso exista um novo framework adicionado ao `Cartfile` rode:

```console
$ mint run carthage carthage update <nome do framework> --platform iOS --no-use-binaries
```

Ou rode o script de bootstrap novamente.

## Testes

Para rodar os testes, com o Xcode aberto, pressione `Command`+`U`, ou rode a lane de testes do fastlane:

```console
$ bundle exec fastlane tests
```

Os resultados da execução dos testes (se rodados pelo fastlane) estarão na pasta `slather_output`.

Por convenção, os testes são rodados no simulador do iPhone SE.