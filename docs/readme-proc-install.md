# Installation of the Nudger Frontend Environment (Improved Version)

## 1. Install Dependencies 
### macOS M1

```bash
brew install --cask temurin@8
brew install git gh node pnpm
softwareupdate --install-rosetta --agree-to-license
brew install sops
```
### Linux
```bash
sudo apt update
sudo apt install -y git temurin-8-jdk gh nodejs sops
npm install -g pnpm
```
### Windows
### Temurin 8 (OpenJDK)
### download from : https://adoptium.net/temurin/releases/?version=8

### Git
### download from  : https://git-scm.com/download/win

### GitHub CLI
### download from  : https://cli.github.com/

### Node.js
### Tdownload from : https://nodejs.org/

### pnpm
```bash
npm install -g pnpm
```
### sops
### download from : https://github.com/mozilla/sops/releases (into "assets" section)
---

## 2. Prepare the Working Directory

```bash
export WORKDIR="$HOME/Documents/SSD/Dev"
mkdir -p "$WORKDIR"
cd "$WORKDIR"
```

---

## 3. Fork the Repository Using GitHub CLI

```bash
gh auth login
gh repo fork open4good/open4goods --clone
```

This automatically creates:
- `origin` = your personal fork  
- `upstream` = the original repository  
- a fully ready local clone

---

## 4. Install Frontend Dependencies

```bash
cd open4goods/frontend
pnpm install
```

---

## 5. Add Nuxt Environment Variables (via SOPS)

```bash
# Move into the directory containing the project's SOPS secrets
cd open4good/docs/secrets

# Create the folder that will store the AGE key (used for SOPS encryption/decryption)
mkdir -p ~/.config/sops/age/

# Generate a personal AGE key (private key stored locally)
# and extract the public key that must be added to the project SOPS config
age-keygen -o ~/.config/sops/age/keys.txt
```
 ⚠️ IMPORTANT: Add your generated AGE **public key** to the repository's .sops.yaml file
under the `creation_rules.age` section so SOPS can encrypt secrets for you.
```bash
creation_rules:
  - path_regex: .*\.yaml$
    age:
      - age1v6vsakf7xumwu687pt6xy2lke3fsgat8c3kv084c0sp9ne5ukefqsaxam5
```
```bash
# Decrypt the shared SOPS file (env.sops.yaml → env.yaml)
./sops.sh decrypt env.sops.yaml

# Automatically generate the Nuxt .env file from the decrypted YAML
./generate_env.sh

# Go back to the repository root
cd ../../

# Verify that the generated .env file is correct
cat front/.env
```

⚠️ Environment variables follow the Nuxt 3 conventions.

---

## 6. Start the Development Server

```bash
pnpm dev
```

---

## 7. Git Commit and Push Changes

```bash
git add .
git commit -m "feat: description of the change"
git push --set-upstream origin feat/my-feature
```

### Create a Pull Request

→ Go to GitHub → your fork → *Compare & Pull Request*

---

