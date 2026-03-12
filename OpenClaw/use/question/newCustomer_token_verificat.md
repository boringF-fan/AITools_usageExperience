# question
The new client requires manual verification of the 'token verification' security mechanism on the server side.

# solution
```bash
# Method 1: Display existing access tokens
openclaw dashboard

# Method 2: Reset Access Token
openclaw config set gateway.auth.mode token
NEW_TOKEN=$(openssl rand -hex 16)
openclaw config set gateway.auth.token "$NEW_TOKEN"
echo "你的新 Token 是：$NEW_TOKEN"

# The client carries a token for URL access

# Server approval
openclaw devices list
openclaw devices approve id
```