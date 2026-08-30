# Security Policy

## Reporting a vulnerability

Please report security issues privately to the repository owner instead of
opening a public issue. Do not include API keys, access tokens, private prompts,
or conversation content in reports.

## Credential handling

- The project never embeds a DeepSeek API key in source code or build output.
- Raycast stores the key as a password preference.
- The extension sends the key and the first question to the helper through an
  anonymous stdin pipe. They are not placed in process arguments or temporary
  files.
- The helper keeps the key and conversation in memory and sends requests only
  to `https://api.deepseek.com/responses`.
- The application has no telemetry and does not persist conversation history.

If a key is accidentally committed or pasted into a public issue, revoke it in
the DeepSeek console immediately and create a replacement.
