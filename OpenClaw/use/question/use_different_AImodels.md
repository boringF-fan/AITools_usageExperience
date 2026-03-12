# question
Configure a new AI big model for OpenClaw

# solution
```bash
pkill -f openclaw
openclaw config unset models
openclaw configure
# Modify according to the prompts
```