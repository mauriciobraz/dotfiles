# Maurício's dotfiles

## Dependências

- [Git](https://git-scm.com/)
- [Zsh](https://zsh.org/)

Para usuários do Fedora, existe um script que instala o [zsh](https://zsh.org/) e o [git](https://git-scm.com/) e algumas outras aplicações que uso diariamente, todas são opcionais.

```bash
chmod +x dnf.sh && ./dnf.sh
```

## Instalação

Clone o repositório com o seguinte comando

```bash
git clone https://mauriciobraz/dotfiles.git ~/.dotfiles
```

Após isso, dê permissão de execução para o arquivo `install.sh` e execute-o com o seguinte comando

```bash
cd ~/.dotfiles && chmod +x install.sh && ./install.sh
```
