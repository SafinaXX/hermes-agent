# Deploy Hermes Gateway on Zeabur (with Daytona terminal backend)

This setup keeps Discord-facing Gateway on Zeabur, while Hermes terminal tool runs in Daytona sandboxes.

## 1) Zeabur build settings

- Root directory: `hermes-agent`
- Build: use repo `Dockerfile`
- Start command:

```bash
bash -lc "./scripts/start-gateway-daytona.sh"
```

## 2) Required environment variables

Set these in Zeabur service env:

- `OPENROUTER_API_KEY`
- `DISCORD_BOT_TOKEN`
- `DISCORD_ALLOWED_USERS`
- `DAYTONA_API_KEY`

Optional but recommended:

- `TZ=Asia/Taipei`
- `PYTHONUNBUFFERED=1`

## 3) What startup script does

`scripts/start-gateway-daytona.sh` enforces:

- `terminal.backend=daytona`
- `terminal.container_persistent=true`
- `terminal.container_cpu=1`
- `terminal.container_memory=5120`
- `terminal.container_disk=10240` (10 GiB cap-safe)

Then it runs:

```bash
hermes gateway start
```

## 4) Post-deploy checks

1. In Zeabur logs, confirm gateway connected to Discord.
2. Send `@Hermes 幫我跑 echo hello`.
3. Check reply includes command output.
4. Verify Daytona has new sandbox named `hermes-{task_id}`.

## 5) Known caveat

Daytona sandbox egress currently may fail for some domains (for example `discord.com`, `google.com`) while allowing others (for example `openrouter.ai`). This does not block this architecture because Discord connection is handled by Zeabur-hosted gateway process.
