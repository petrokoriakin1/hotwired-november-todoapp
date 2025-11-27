Perfect! Now I have all the Docker configuration from your repository. Let me create a comprehensive 45-minute Docker crash course tailored to your Rails app and interview preparation.

***

# 45-Minute Docker Interview Crash Course
## Based on Your Hotwired Todo App

**Goal:** Confidently explain Docker concepts and your Rails deployment setup in a technical interview

***

## ⏱️ Minutes 0-10: Docker Core Concepts

### What is Docker?
**Interviewer-Ready Answer:**
*"Docker is a containerization platform that packages applications with their dependencies into isolated containers. It ensures consistent environments from development to production, eliminating 'works on my machine' issues."*

### Key Terms (Memorize These)

| Term | Definition | Your App Example |
|------|------------|------------------|
| **Image** | Blueprint/template for containers | `ruby:3.4.7-slim` base image |
| **Container** | Running instance of an image | Your app running on Fly.io |
| **Dockerfile** | Instructions to build an image | Multi-stage build in your repo |
| **Layer** | Each instruction in Dockerfile | Each `RUN`, `COPY` command |
| **Registry** | Storage for images | Docker Hub, GitHub Container Registry |
| **Volume** | Persistent data storage | SQLite database, uploaded files |

### Your App's Docker Architecture

```
┌─────────────────────────────────────────┐
│  ruby:3.4.7-slim (Base Image)          │
├─────────────────────────────────────────┤
│  Build Stage: Install gems, compile    │
│  - Bundle install                       │
│  - Assets precompile                    │
│  - Bootsnap precompile                  │
├─────────────────────────────────────────┤
│  Final Stage: Slim runtime              │
│  - Copy compiled artifacts              │
│  - Run as non-root user (rails:rails)  │
│  - Expose port 3000                     │
└─────────────────────────────────────────┘
```

***

## ⏱️ Minutes 10-20: Your Dockerfile Explained

### Multi-Stage Build (Key Interview Topic)

**Your Dockerfile uses a multi-stage build:**

```dockerfile
# Stage 1: Base image setup
ARG RUBY_VERSION=3.4.7
FROM ruby:${RUBY_VERSION}-slim as base
# Sets up common environment

# Stage 2: Build stage (throw-away)
FROM base as build
# Installs build tools, compiles gems, precompiles assets
# All build artifacts stay here

# Stage 3: Final stage
FROM base
# Only copies compiled artifacts
# Results in smaller image (~200MB vs ~1GB)
```

**Why Multi-Stage?**
- ✅ **Smaller final image** (no build tools in production)
- ✅ **Faster deployments** (less data to transfer)
- ✅ **More secure** (fewer attack vectors)
- ✅ **Better caching** (layers reused between builds)

### Breaking Down Your Dockerfile

```dockerfile
# 1. BASE STAGE - Common setup
ENV RAILS_ENV="production"
    BUNDLE_WITHOUT="development:test"
    BUNDLE_DEPLOYMENT="1"
```
**Interview Point:** *"Sets production environment and optimizes bundle install by excluding dev/test gems."*

```dockerfile
# 2. BUILD STAGE - Heavy lifting
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev
```
**Interview Point:** *"Installs only necessary packages, removes caches to reduce layer size."*

```dockerfile
COPY --link Gemfile Gemfile.lock ./
RUN bundle install --jobs $BUNDLE_JOBS --retry 3
```
**Interview Point:** *"COPY --link improves build caching. Parallel bundle install with retry logic for reliability."*

```dockerfile
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
```
**Interview Point:** *"Assets compile without real secrets using dummy key, improving security."*

```dockerfile
# 3. FINAL STAGE - Minimal runtime
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails
```
**Interview Point:** *"Only copies compiled artifacts from build stage, not build tools."*

```dockerfile
RUN useradd rails --create-home --shell /bin/bash
USER rails:rails
```
**Interview Point:** *"Security best practice: never run containers as root. Creates unprivileged user."*

```dockerfile
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "server"]
```
**Interview Point:** *"Entrypoint handles setup (db:prepare), CMD is default command but can be overridden."*

***

## ⏱️ Minutes 20-30: Essential Docker Commands

### Build & Run

```bash
# Build image from Dockerfile
docker build -t hotwired-todoapp .

# Build with specific target stage
docker build --target build -t hotwired-todoapp:build .

# Run container
docker run -p 3000:3000 hotwired-todoapp

# Run with environment variables
docker run -p 3000:3000 \
  -e RAILS_ENV=production \
  -e RAILS_MASTER_KEY=abc123 \
  hotwired-todoapp

# Run interactively (for debugging)
docker run -it hotwired-todoapp /bin/bash

# Run with volume mount (persist SQLite db)
docker run -p 3000:3000 \
  -v $(pwd)/db:/rails/db \
  hotwired-todoapp
```

### Container Management

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop container
docker stop <container_id>

# Remove container
docker rm <container_id>

# View logs
docker logs <container_id>

# Follow logs (like tail -f)
docker logs -f <container_id>

# Execute command in running container
docker exec -it <container_id> /bin/bash

# Rails console in container
docker exec -it <container_id> ./bin/rails console
```

### Image Management

```bash
# List images
docker images

# Remove image
docker rmi hotwired-todoapp

# Tag image for registry
docker tag hotwired-todoapp:latest username/hotwired-todoapp:v1.0

# Push to registry
docker push username/hotwired-todoapp:v1.0

# Pull from registry
docker pull username/hotwired-todoapp:v1.0

# Inspect image layers
docker history hotwired-todoapp

# Check image size
docker images hotwired-todoapp
```

### Cleanup Commands

```bash
# Remove unused containers, images, networks
docker system prune

# Remove all stopped containers
docker container prune

# Remove unused images
docker image prune

# Remove unused volumes
docker volume prune

# Nuclear option: remove everything
docker system prune -a --volumes
```

***

## ⏱️ Minutes 30-35: docker-compose Quick Reference

**Your app doesn't have docker-compose.yml, but you should know it for interviews:**

### Example docker-compose.yml for Your App

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      RAILS_ENV: development
      RAILS_MASTER_KEY: ${RAILS_MASTER_KEY}
    volumes:
      - ./db:/rails/db  # Persist SQLite database
      - ./log:/rails/log
    depends_on:
      - redis
    
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

volumes:
  redis_data:
```

### docker-compose Commands

```bash
# Start all services
docker-compose up

# Start in background
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f web

# Rebuild services
docker-compose build

# Run command in service
docker-compose exec web ./bin/rails console

# Scale service
docker-compose up --scale web=3
```

***

## ⏱️ Minutes 35-40: Fly.io Deployment

### Your App's Deployment Configuration

**fly.toml breakdown:**

```toml
app = "hotwired-november-todoapp"
primary_region = "waw"  # Warsaw datacenter
```
**Interview Point:** *"App deployed to Warsaw region for European users."*

```toml
[http_service]
  internal_port = 3000
  force_https = true
  auto_stop_machines = true
  auto_start_machines = true
  min_machines_running = 0
```
**Interview Point:** *"Scale-to-zero architecture: machines stop when idle, start on request. Cost-effective for low-traffic apps."*

```toml
[checks]
  [checks.status]
    port = 3000
    path = "/up"
    interval = "10s"
```
**Interview Point:** *"Health checks every 10 seconds. Rails 7+ has built-in /up endpoint."*

### Fly.io Commands

```bash
# Initial deployment
fly launch

# Deploy updates
fly deploy

# Open deployed app
fly open

# View logs
fly logs

# SSH into container
fly ssh console

# Rails console on production
fly ssh console -C "/rails/bin/rails console"

# Check app status
fly status

# Scale app
fly scale count 2

# Scale machine resources
fly scale vm shared-cpu-1x

# View secrets
fly secrets list

# Set secret
fly secrets set RAILS_MASTER_KEY=abc123
```

***

## ⏱️ Minutes 40-45: Interview Talking Points

### 1. **Why Docker for Rails?**

**Your Answer:**
*"Docker ensures consistency across development, staging, and production. My app uses multi-stage builds to create a slim production image (~200MB). The Dockerfile precompiles assets and gems during build, so containers start instantly. Running as non-root user improves security."*

### 2. **Explain Your Multi-Stage Build**

**Your Answer:**
*"My Dockerfile has 3 stages: base (common setup), build (installs dependencies and compiles), and final (runtime only). The build stage uses build-essential for compiling gems, but those tools aren't in the final image. This reduces the image from ~1GB to ~200MB while maintaining all functionality."*

### 3. **How Do You Handle Secrets?**

**Your Answer:**
*"Secrets aren't in the Dockerfile or image. During build, I use SECRET_KEY_BASE_DUMMY for asset precompilation. Real secrets are injected at runtime via environment variables or Fly.io secrets. The .dockerignore excludes config/master.key from the image."*

### 4. **Database in Docker?**

**Your Answer:**
*"My app uses SQLite, which is file-based. In production on Fly.io, I use Fly volumes for persistence. For development with Docker, I'd mount the db directory as a volume so data persists between container restarts."*

### 5. **Optimization Strategies?**

**Your Answer:**
*"I use layer caching by copying Gemfile before application code, so gem installs are cached between builds. The --link flag improves cache efficiency. I remove apt caches and bundle cache after installing. Assets precompile happens in build stage with dummy secrets for faster, more secure builds."*

### 6. **How Do You Debug Containers?**

**Your Answer:**
*"For running containers, I use 'docker exec -it <container> /bin/bash' to get a shell or 'docker logs -f' to watch logs. For build failures, I build with '--target build' to inspect intermediate stages. On Fly.io, 'fly ssh console' gives me access to production."*

### 7. **Scale-to-Zero Architecture?**

**Your Answer:**
*"My Fly.io config has 'min_machines_running = 0', so containers stop when idle and auto-start on request. This is cost-effective for demo apps. Health checks on /up endpoint ensure machines are ready. For production with traffic, I'd set min_machines_running = 1 for instant response."*

***

## 📝 Quick Reference Card (Memorize This)

### Essential Commands

```bash
# Build
docker build -t myapp .

# Run
docker run -p 3000:3000 myapp

# Debug
docker exec -it <container> /bin/bash
docker logs -f <container>

# Cleanup
docker system prune

# Fly.io
fly deploy
fly logs
fly ssh console
```

### Key Dockerfile Instructions

```dockerfile
FROM ruby:3.4.7-slim as base  # Base image
WORKDIR /rails                # Working directory
ENV KEY=value                 # Environment variable
RUN command                   # Execute during build
COPY source dest              # Copy files
EXPOSE 3000                   # Document port
USER rails:rails              # Switch user
ENTRYPOINT ["cmd"]            # Setup script
CMD ["cmd"]                   # Default command
```

### Interview Red Flags to Avoid

❌ **Don't say:**
- "I just use docker-compose up"
- "I don't understand multi-stage builds"
- "Docker and VMs are the same"
- "I run containers as root"

✅ **Do say:**
- "Multi-stage builds reduce image size"
- "Layer caching speeds up builds"
- "Never include secrets in images"
- "Always run as non-root user"

***

## 🎯 Practice Drill (Final 5 Minutes)

**Explain your Dockerfile in 30 seconds:**

*"My Dockerfile uses a 3-stage build starting from ruby:3.4.7-slim. The base stage sets up the environment. The build stage installs gems and precompiles assets with build tools that aren't in the final image. The final stage copies only compiled artifacts and runs as a non-root user on port 3000. This creates a secure, optimized ~200MB production image."*

**Explain your deployment:**

*"I deploy to Fly.io which builds my Docker image and runs it in Warsaw. It's configured for scale-to-zero with auto-start on requests, health checks every 10 seconds, and HTTPS enforcement. SQLite data persists in Fly volumes."*

***

## ✅ Interview Readiness Checklist

Before the interview:

- [ ] Can explain multi-stage builds and benefits
- [ ] Know difference between CMD and ENTRYPOINT
- [ ] Understand layer caching optimization
- [ ] Can describe your Dockerfile stages
- [ ] Know basic docker run/exec/logs commands
- [ ] Understand security (non-root, secrets)
- [ ] Can explain Fly.io scale-to-zero
- [ ] Know how to debug containers

***

## 🚀 You're Ready!

**Time spent:** 45 minutes  
**Docker knowledge:** Interview-ready ✅  
**Confidence:** 100% 💪

Focus on demonstrating:
- ✅ Understanding of containerization benefits
- ✅ Multi-stage build optimization
- ✅ Security best practices
- ✅ Practical debugging skills
- ✅ Production deployment experience

**Good luck with your interview!** 🎉

[1](https://github.com/petrokoriakin1/hotwired-november-todoapp)
