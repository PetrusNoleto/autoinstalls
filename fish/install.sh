#!/bin/bash
set -e

echo "Instalando Fish" &&
sudo apt install fish -y

echo "Alterando shell para Fish..."
sudo chsh -s /usr/bin/fish || { echo "Erro ao alterar shell"; exit 1; }

echo "Baixando Oh My Posh..."
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh || { echo "Erro no download"; exit 1; }

echo "Definindo permissão de execução..."
sudo chmod +x /usr/local/bin/oh-my-posh || { echo "Erro ao definir permissão"; exit 1; }

echo "Criando diretório de fontes dentro de $HOME/.local/share/..."
mkdir -p "$HOME/.local/share/fonts" || { echo "Erro ao criar diretório"; exit 1; }

echo "Download Nerd Font - FiraCode"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip -O "$HOME/Downloads/firacode.zip" || { echo "Erro no download do Nerd Font"; exit 1; }

echo "Descompactando fontes dentro de $HOME/.local/share/fonts"
unzip "$HOME/Downloads/firacode.zip" -d "$HOME/.local/share/fonts" || { echo "Erro ao descompactar fontes"; exit 1; }

echo "Atualizando fontes"
fc-cache -f -v || { echo "Erro ao atualizar fontes"; exit 1; }

echo "Instalando gnome-tweaks"
sudo apt install gnome-tweaks -y || { echo "Erro ao instalar gnome-tweaks"; exit 1; }

echo "Baixando e Instalando Tema Oh My Posh"
mkdir -p "$HOME/.poshthemes" &&
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O "$HOME/.poshthemes/themes.zip" &&
unzip "$HOME/.poshthemes/themes.zip" -d "$HOME/.poshthemes" &&
chmod u+rw "$HOME/.poshthemes"/*.json &&
rm "$HOME/.poshthemes/themes.zip" || { echo "Erro ao baixar ou instalar tema"; exit 1; }

echo "Criando arquivo config.fish"
mkdir -p "$HOME/.config/fish" &&
touch "$HOME/.config/fish/config.fish" || { echo "Erro ao criar arquivo config.fish"; exit 1; }

echo "Inserindo conteúdo no arquivo config.fish"
cat <<EOF > "$HOME/.config/fish/config.fish"
# Inicializa o oh-my-posh com o tema especificado
oh-my-posh init fish --config \$HOME/.poshthemes/montys.omp.json | source

# Apenas comandos para sessões interativas
if status is-interactive
   
end
EOF
echo "Configuração concluída com sucesso! para escolher o tema do seu terminal rode esse comando ( bash -c "$(wget -qO- https://git.io/vQgMr)" ) e depois reinicie o sua maquina"
