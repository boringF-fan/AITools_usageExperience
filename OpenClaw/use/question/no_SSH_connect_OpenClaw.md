# problem
If the client does not use SSH proxy to port 22 of the server,
unable to connect to the 'openclaw gateway' issue

# solution
```bash
pkill -f openclaw
openclaw config set gateway.bind lan
openclaw config set gateway.controlUi.allowedOrigins ["http://<Server External IP>:<Port>"] "# Array Access Release
openclaw gateway start
```