#!/usr/bin/env bash

command -v code &>/dev/null || {
  echo "VS Code is not installed, please install it first."
  exit
}

extensions=(
  Prisma.prisma
  GitHub.copilot
  mikestead.dotenv
  redhat.vscode-xml
  Tyriar.lorem-ipsum
  qwtel.sqlite-viewer
  IronGeek.vscode-env
  Gruntfuggly.todo-tree
  esbenp.prettier-vscode
  dbaeumer.vscode-eslint
  naumovs.color-highlight
  piousdeer.adwaita-theme
  PKief.material-icon-theme
  bradlc.vscode-tailwindcss
  EditorConfig.EditorConfig
  yzhang.markdown-all-in-one
  loczek.next-js-ts-snippets
  aaron-bond.better-comments
  helixquar.randomeverything
  ms-azuretools.vscode-docker
  qcz.restart-ts-server-button
  fuadpashayev.bottom-terminal
  formulahendry.auto-rename-tag
  MariusAlchimavicius.json-to-ts
  zengxingxin.sort-js-object-keys
  ms-vscode-remote.remote-containers
  Satoqz.yet-another-discord-presence
  MS-CEINTL.vscode-language-pack-pt-BR
  Cardinal90.multi-cursor-case-preserve
  streetsidesoftware.code-spell-checker
  styled-components.vscode-styled-components
  streetsidesoftware.code-spell-checker-portuguese-brazilian
)


for extension in "${extensions[@]}"; do
  code --install-extension $extension
done
