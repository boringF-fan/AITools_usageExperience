# ubuntu 24 install openclaw
Execute self built shell scripts through bash to complete pre dependency configuration within the server.

Shell script storage folder full path:`OpenClaw/install/installShell/ubuntu-24.04.4`

execute command:
```bash
# Based on OpenClaw version: 2026.3.8
cd ./ubuntu-24.04.4
chmod 740 ./ubuntu_standaed_source_switching.sh
./ubuntu_standaed_source_switching.sh # change source
./nodeV22_22_1_install.sh # Normally, the fourth step of verification will result in an error
reboot # Node22 must be restarted to be recognized by the system, or maybe I didn't find the correct method
node --version # Verify node installation
./npm_mirror_config.sh
./python_3.10_install.sh
./pip_mirror_config.sh
```
Dependency installation completed, start installing OpenClaw:
```bash
curl -fsSL https://openclaw.bot/install.sh | bash # Officially installed, China may need to open the agent
# Configure OpenClaw according to prompts and requirements
```

