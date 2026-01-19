#!/bin/bash

# Colores para salida legible
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
# Actualizar el sistema primero
sudo apt update && sudo apt upgrade -y

# 1. Navegadores (Chrome y Brave)
echo "Instalando Chrome y Brave..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm google-chrome-stable_current_amd64.deb

sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install brave-browser

# 2. Herramientas .NET (SDK y Runtime)
echo "Instalando .NET SDK..."
sudo apt install -y dotnet-sdk-8.0

#postman
sudo snap install postman

# Git install
sudo apt install git

# 3. Diseño y Productividad (Inkscape, GIMP, QElectroTech, LibreOffice)
echo "Instalando herramientas de diseño y ofimática..."
sudo apt install -y inkscape gimp qelectrotech libreoffice libreoffice-l10n-es

# 4. KVM y Virtualización Completa
echo "Configurando KVM, QEMU y Virt-Manager..."
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
sudo adduser $USER libvirt
sudo adduser $USER kvm

echo -e "${YELLOW}Instalando OBS Studio...${NC}"
sudo apt install -y obs-studio

# 5. Antigravity IDE (Vía Flatpak o descarga directa si aplica)
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
sudo apt update
sudo apt install -y antigravity || echo "Antigravity no encontrado en repos, verificar fuente manual."

# 6. Drivers DisplayLink (Requiere EVDI)
echo "Instalando dependencias para DisplayLink..."
sudo apt install -y dkms libdrm-dev
# Nota: El driver oficial suele requerir descargar un .run de la web de Synaptics.
# Este comando prepara el entorno para que el instalador no falle.

# Limpieza
sudo apt autoremove -y
echo "Instalación completada. Es recomendable REINICIAR para aplicar cambios en KVM y Drivers."
