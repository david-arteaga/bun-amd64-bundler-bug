# Use the official Bun image (pinned version for reproducibility)
FROM oven/bun:1.3.1-debian AS base

WORKDIR /app

# Install dependencies and build
FROM base AS install
COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile

FROM install AS build
COPY src ./src
COPY styles ./styles
COPY bun-env.d.ts ./bun-env.d.ts
COPY components.json ./components.json
COPY build.ts ./build.ts
COPY tsconfig.json ./tsconfig.json
COPY bunfig.toml ./bunfig.toml

RUN bun run build

# Production image
FROM base AS release

COPY --from=install /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY src ./src
COPY package.json ./

USER bun

# Expose port
EXPOSE 3000

# Set environment variable
ENV PORT=3000
ENV NODE_ENV=production

# Run the application
ENTRYPOINT ["bun", "run", "src/index.ts"]

