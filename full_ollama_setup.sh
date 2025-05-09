#!/data/data/com.termux/files/usr/bin/bash

DISTRO_NAME="debian"

# Function: Install proot-distro if missing
install_proot_distro() {
    echo "Checking if proot-distro is installed..."
    if ! command -v proot-distro >/dev/null 2>&1; then
        echo "Installing proot-distro..."
        pkg update -y && pkg install -y proot-distro
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install proot-distro."
            exit 1
        fi
    else
        echo "proot-distro is already installed."
    fi
}

# Function: Install Debian if not present
install_debian() {
    echo "Checking if Debian is installed..."
    proot-distro list | grep -q "$DISTRO_NAME"

    if [ $? -ne 0 ]; then
        echo "Debian not found. Installing Debian..."
        proot-distro install $DISTRO_NAME
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install Debian proot-distro."
            exit 1
        fi
    else
        echo "Debian is already installed."
    fi
}

# Function: Setup Ollama + TinyLlama inside Debian
setup_inside_debian() {
    echo "Starting Debian to install Ollama and TinyLlama..."

    proot-distro login $DISTRO_NAME --shared-tmp -- bash -c "
        echo 'Updating Debian...'
        apt update -y && apt upgrade -y

        echo 'Checking architecture...'
        ARCH=\$(uname -m)
        if [[ \"\$ARCH\" != \"aarch64\" ]]; then
            echo 'Error: Your mobile specifications are not suited to run this model (requires 64-bit arm64).'
            exit 1
        fi

        echo 'Installing curl...'
        apt install -y curl

        echo 'Installing Ollama via official script...'
        curl -fsSL https://ollama.com/install.sh | sh

        if [ ! -x \"/usr/bin/ollama\" ]; then
            echo 'Error: Ollama installation failed.'
            exit 1
        fi

        echo 'Starting Ollama service...'
        nohup ollama serve > /dev/null 2>&1 &

        sleep 5  # Wait for server to be ready

        echo 'Pulling TinyLlama model...'
        ollama pull tinyllama

        if [ \$? -ne 0 ]; then
            echo 'Error: Failed to pull TinyLlama model.'
            exit 1
        fi

        echo '✅ TinyLlama is installed inside Debian and ready to use!'
        echo 'You can now run inference using:'
        echo '   ollama run tinyllama'
    "
}

# MAIN SCRIPT
echo "=== FULL AUTOMATED INSTALL: proot-distro + Debian + Ollama + TinyLlama ==="

install_proot_distro
install_debian
setup_inside_debian

echo "=== ✅ ALL DONE! ==="
echo "TinyLlama is installed and ready to run inside Debian."
echo "To use it, follow these steps:"
echo "1️⃣ Start Debian:   proot-distro login debian"
echo "2️⃣ Run inference:  ollama run tinyllama"
