# DeepSeek Direct

An open-source macOS quick assistant that keeps Raycast as the app launcher and
sends natural-language fallback queries to DeepSeek in a persistent native
Swift panel.

## Highlights

- Raycast application launch and Fallback Command integration.
- Native SwiftUI/AppKit floating panel that can remain visible across apps.
- Streaming Markdown, multi-turn chat, citations, and answer copying.
- DeepSeek Responses API with server-side `web_search`.
- Every new panel starts with `deepseek-v4-flash`; Pro is a session-only switch.
- Reasoning is off by default and independent from web search.
- No telemetry and no persisted conversation history.

## Requirements

- macOS 13+
- Raycast
- Xcode Command Line Tools
- Node.js 22.22.2+
- pnpm 11
- A funded DeepSeek API key

## Install from source

```zsh
git clone https://github.com/dongbo910220/raycast-deepseek-panel.git
cd raycast-deepseek-panel
./scripts/install.zsh
```

The installer prints the exact `pnpm dev` or `corepack pnpm dev` command for
your environment. Run it once to import the extension, then stop the development
watcher with `Ctrl+C`. In Raycast Settings, add **Ask DeepSeek** to Launcher →
Fallback Commands and move it to the first position. Paste the API key only into
the extension's password preference.

The installer builds a universal macOS 13+ helper directly into the extension's
assets. Removing the local extension therefore leaves no separately installed
helper application behind.

Run all local checks with:

```zsh
./scripts/check.zsh
```

See the [Chinese README](README.md) for the full setup guide and
[SECURITY.md](SECURITY.md) for the credential-handling model.

## License

[MIT](LICENSE). This community project is not affiliated with or endorsed by
DeepSeek or Raycast. Their names and marks belong to their respective owners.
