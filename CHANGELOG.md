# Changelog

## 0.1.1 - 2026-10-08

- Fixed a macOS responder-loop freeze when submitting a follow-up with Return,
  especially while using a Chinese input method.
- Kept the follow-up field stable while a request starts and deferred submission
  until AppKit finishes handling the Return key event.
- Added latest-launch-wins process cleanup so reopening the command replaces any
  stale or unresponsive helper instead of stacking hidden panels.
- Deferred Escape closing until the key event finishes and made shutdown cleanup
  idempotent.
- Reduced long-answer UI load by streaming plain text, parsing Markdown once at
  completion, deduplicating updates, and building bounded history off the main
  thread.
- Updated the Raycast SDK and pinned patched transitive dependency versions so
  the production dependency audit reports no known vulnerabilities.

## 0.1.0 - 2026-08-30

- Initial open-source release.
- Raycast fallback command for DeepSeek V4.
- Native persistent macOS panel with streaming Markdown and multi-turn chat.
- DeepSeek Responses API with server-side web search.
- Flash-by-default sessions with a temporary Pro switch.
- Universal macOS 13+ source build and credential-safe stdin handoff.
