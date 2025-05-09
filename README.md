# TinyLlama Setup Script

This repository contains an automated setup script to install **proot-distro**, **Debian**, **Ollama**, and the **TinyLlama model** on Android (using Termux). The script handles everything from installing dependencies to downloading the TinyLlama model.

---

### Explanation:
- `curl`: Fetches the script from GitHub.
- `-f`: Fails silently if the HTTP request fails.
- `-s`: Runs in silent mode to suppress unnecessary output.
- `-L`: Follows redirects if any.
- The `| bash` part pipes the fetched script directly into the Bash interpreter for execution.

## Installation and Usage

### Pre-requisites
- Termux installed on your Android device.
- Internet connection.

---

### Steps to Install

Run the following command in your Termux terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/ysathyasai/Tinyllama/main/full_ollama_setup.sh | bash
```

This command will:
1. Install `proot-distro` (if not already installed).
2. Install Debian (if not already installed).
3. Set up Ollama and download the TinyLlama model inside Debian.

---

### After Running the Installation Script

Once the installation is complete, follow these steps to use TinyLlama:

1. **Start Debian**:
   ```bash
   proot-distro login debian
   ```

2. **Start the Ollama server**:
   ```bash
   ollama serve
   ```

3. **Run the TinyLlama model** in a new terminal window:
   ```bash
   ollama run tinyllama
   ```

---

## Troubleshooting

If you encounter any issues:
- Ensure Termux has storage permissions (`termux-setup-storage`).
- Check that your device is 64-bit ARM (`aarch64`).
- Restart the installation process if needed.

---

## Repository Contents

- **`full_ollama_setup.sh`**: The main setup script.
- **`.gitignore`**: Excludes unnecessary or sensitive files.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Contributing

Feel free to raise issues or submit pull requests to improve the script.
