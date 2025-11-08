### Repro

- `bun run docker:build:arm64` works
- `bun run docker:build:amd64` fails

```
 > [build 8/8] RUN bun run build:
0.130 $ bun run build.ts
1.001
1.001 🚀 Starting build process...
1.001
1.038 📄 Found 1 HTML file to process
1.038
1.581 error: Cannot apply unknown utility class `outline-ring/50`
1.581     at /app/src/index.css:0
1.582
1.582 Bun v1.3.1 (Linux x64 baseline)
1.590 error: script "build" exited with code 1
```
