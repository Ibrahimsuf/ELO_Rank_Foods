# ELO Rank US Foods

Rails app for ranking foods using the Elo rating system. You vote between two foods; winners gain rating, losers lose it. The leaderboard at `/foods` shows foods ordered by Elo.

## Overview

- **Vote**: choose the winner; Elo updates for both foods and you’re sent to the next matchup.
- **Leaderboard**: view the full ranking at `/foods`.

## Prerequisites

- **Ruby** 3.4.x (match `.ruby-version`/Dockerfile `ARG RUBY_VERSION`)
- **Bundler**
- **PostgreSQL** running and accessible per `config/database.yml`

## Setup

1. Install gems
   - `bundle install`
2. Create and migrate DB
   - `bin/rails db:create db:migrate`
3. Seed data (expects JPG images in `app/assets/images`)
   - Add `.jpg` images to `app/assets/images` (filename becomes food name via titleize)
   - `bin/rails db:seed`

## Run locally

- **Recommended** (Procfile.dev via foreman):
  - `bin/dev`
  - Starts Rails on `http://localhost:3000` and Tailwind watcher.

- **Alternatively**:
  - `bin/rails server`
  - In another shell: `bin/rails tailwindcss:watch`

Open:

- `/` to start voting
- `/foods` to see the leaderboard

## Seeding details

- Seeds iterate `app/assets/images` for files ending in `.jpg`.
- For each file `tacos.jpg`, creates `Food(name: "Tacos", image_filename: "tacos.jpg", elo: 1200)` if missing.

## Deployment

- **Docker (production image)**
  - Build: `docker build -t elo_rank_us_food .`
  - Run: `docker run -d -p 80:80 -e RAILS_MASTER_KEY=... --name elo_rank_us_food elo_rank_us_food`
  - Image uses Thruster to run Rails on port 80 by default.

- **Kamal**
  - Gem `kamal` is included and `config/deploy.yml` is present. Use Kamal if you prefer container‑based deploys to your servers.

## Routes (high level)

- **GET /** → random vote (`foods#random_edit`)
- **GET /foods** → leaderboard
- **GET /foods/:id/edit** → head‑to‑head vote
- **PATCH /foods/:id** → submit a vote (updates Elo and redirects)
