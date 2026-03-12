# question
Remote access to openclaw's web port without tls certificate, unable to use openclaw through security verification

# solution
```bash
# Generate x.509 self signed TLS certificate
mkdir -p /etc/openclaw/ssl
chmod 755 /etc/openclaw/ssl
openssl genrsa -out /etc/openclaw/ssl/openclaw.key 2048
openssl req -new -x509 -key /etc/openclaw/ssl/openclaw.key -out /etc/openclaw/ssl/openclaw.crt -days 3650 -subj "/C=CN/ST=CN/L=CN/O=OpenClaw/CN=192.168.247.133"
chown root:root /etc/openclaw/ssl/*
chmod 644 /etc/openclaw/ssl/*
openclaw config set gateway.tls.enabled true
openclaw config set gateway.tls.cert /etc/openclaw/ssl/openclaw.crt
openclaw config set gateway.tls.key /etc/openclaw/ssl/openclaw.key
openclaw config set gateway.port 18789
openclaw config set gateway.controlUi.allowedOrigins '["https://127.0.0.1:18789","http://<Server External IP>:<Port>"]'
openclaw gateway start
```