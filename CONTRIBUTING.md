# Contributing

Contributions are welcome. Please keep changes focused and run the local checks
before opening a pull request:

```zsh
./scripts/check.zsh
```

Never commit credentials, local conversations, compiled `.app` bundles, signing
certificates, or files copied from Raycast's private data directories.

The Raycast extension is TypeScript/React. The persistent panel is a native
SwiftUI/AppKit application built without an Xcode project.
