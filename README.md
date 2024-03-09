# Map Derivadas 
Implementação de simbólica de expressões usando uma versão simples de [AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree) com o objetivo de obter derivada de expressões utilizando a linguagem [Julia](https://julialang.org/).

## Composição
A implementação se encontra no arquivo Julia `deri.jl`. O arquivo `aux.py` contém funções que facilitam a visualização de expressões usadas no repl julia.

## Utilização
### Instalação Julia Lang
Clone esse repositório e certifique-se de que está dentro do diretório.

#### Ambiente Nix
Certifique-se de ter o recurso experimental [flake](https://nixos.wiki/wiki/Flakes) ativo.

O seguinte comando irá resultar em um shell com Julia e Python prontos para utilização.
```console
nix develop .
```

#### Sem Ambiente Nix
Instale [Julia](https://julialang.org/downloads/) e [Python](https://www.python.org/downloads/)

### Utilização
Eu utilizo esse código dentro do repl Julia.

acesse o repl Julia digitando no terminal:
```console
julia
```

```julia
include("./deri.js")
using .Derivada

ddx(Exp(E(), Cos(Exp(X(), 2))))
```

Para facilitar a visualização das expressões, podemos utilizar o código auxiliar python.

```console
python aux.py
```