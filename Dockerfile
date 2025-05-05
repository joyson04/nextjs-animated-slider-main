# Stage 1: Build Next.js app
FROM node:22-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN yarn install --frozen-lockfile

# Copy all source code
COPY . .

# Build Next.js app
RUN yarn build

# Stage 2: Production image
FROM node:22-alpine

# Create non-root user
RUN addgroup -g 1001 appgroup && adduser -D -u 1001 -G appgroup appuser

# Set working directory
WORKDIR /app

# Copy build output and dependencies from builder
COPY --from=builder /app ./

# Set correct permissions
RUN chown -R appuser:appgroup /app

# Expose port (Next.js defaults to 3000)
EXPOSE 3000

# Switch to non-root user
USER appuser

# Start the Next.js production server
CMD ["yarn", "start"]
