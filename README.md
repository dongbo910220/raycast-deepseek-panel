# DeepSeek Direct

一个面向 macOS 的开源 DeepSeek 快速助手：保留 Raycast 的应用启动体验，
把普通自然语言查询交给 DeepSeek，并在可置顶的原生 Swift 悬浮窗中连续对话。

[English](README.en.md)

## 功能

- `⌥Space` 继续用于 Raycast 应用搜索和启动。
- Raycast 无匹配结果时，可将整段文字作为 Fallback 查询交给 DeepSeek。
- 原生 SwiftUI/AppKit 悬浮窗；切换到其他 App 后仍可显示。
- 多轮对话、流式 Markdown、可点击来源链接和复制回答。
- 使用 DeepSeek 官方 Responses API 与服务端 `web_search`。
- 每个新窗口默认使用 `deepseek-v4-flash`；当前窗口可临时切换为
  `deepseek-v4-pro`，关闭后不会记住 Pro。
- 深度思考默认关闭，联网搜索可单独控制。
- 无遥测，不持久化聊天记录。

## 架构

```text
Raycast Root Search / Fallback
             │ stdin（问题 + 运行时配置）
             ▼
Native macOS Panel (SwiftUI + AppKit)
             │ HTTPS / SSE
             ▼
https://api.deepseek.com/responses
             └── DeepSeek server-side web_search
```

Raycast 本身不是开源软件；本仓库开放的是 Raycast 扩展和原生 macOS
悬浮窗的源代码。

## 系统要求

- macOS 13 或更高版本
- Raycast
- Xcode Command Line Tools
- Node.js 22.22.2 或更高版本
- pnpm 11（可通过 Corepack 使用）
- DeepSeek API Key 和可用余额

## 从源码安装

```zsh
git clone https://github.com/dongbo910220/raycast-deepseek-panel.git
cd raycast-deepseek-panel
./scripts/install.zsh
```

安装脚本最后会根据本机环境打印 `pnpm dev` 或 `corepack pnpm dev` 的完整
命令。运行该命令后，Raycast 会导入本地扩展。看到构建成功后可以按
`Ctrl+C` 停止开发进程；扩展仍会保留在 Raycast 中。

然后完成配置：

1. 在 Raycast Settings → Extensions → DeepSeek Direct 中粘贴 API Key。
2. 在 Raycast Settings → Launcher → Fallback Commands 中加入
   **Ask DeepSeek**，并把它移到第一位。
3. 保留或设置 Raycast 主快捷键为 `⌥Space`。

API Key 请只粘贴到 Raycast 的密码设置中，不要写进 `.env`、源码、Issue
或聊天消息。

## 使用

1. 按 `⌥Space`。
2. 输入自然语言问题。
3. 当 **Ask DeepSeek** 出现在 Fallback 第一项时按 Enter。
4. 回答会在独立悬浮窗中流式显示；可在底部继续追问。
5. 当前窗口可在 Flash 与 Pro 之间切换。新开窗口始终恢复 Flash。

## 开发与检查

```zsh
./scripts/check.zsh
```

也可以分别运行：

```zsh
DEEPSEEK_DIRECT_DIST_DIR="$PWD/extension/assets" ./macos-panel/build.zsh
cd extension
pnpm install --frozen-lockfile
pnpm build
```

Swift 构建默认面向 macOS 13，并同时生成 Apple Silicon 与 Intel 架构。
生成的 App 会放入扩展的 `assets` 目录，卸载扩展时不会留下独立安装项。
源码构建使用 ad-hoc 签名；面向公众分发的包应另外使用 Apple Developer ID
签名和公证。

## 隐私与安全

API Key 由 Raycast 的 password preference 管理。扩展通过匿名 stdin 管道
把运行时配置交给悬浮窗，不放入命令行参数或临时文件。悬浮窗只连接
DeepSeek 官方 HTTPS 端点，聊天上下文只保存在当前进程内存中。更多细节见
[SECURITY.md](SECURITY.md)。

## 许可证与声明

[MIT](LICENSE)。本项目是社区项目，与 DeepSeek 或 Raycast 官方无隶属或
背书关系。DeepSeek、Raycast 及相关标识属于其各自权利人。
