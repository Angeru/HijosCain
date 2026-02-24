# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About the App

"Hijos de Caín" is a Ruby on Rails 7 membership management system for an association. It handles members, periodic fee quotes, and charge tracking.

## Commands

```bash
# Start the server
bin/rails server

# Run all tests
bin/rails test

# Run a single test file
bin/rails test test/models/member_test.rb

# Database
bin/rails db:migrate
bin/rails db:seed

# Rails console
bin/rails console
```

## Stack

- Ruby 3.1.2, Rails 7.0.4
- SQLite (all environments)
- Hotwire (Turbo + Stimulus) with importmap — no webpack/bundler
- `will_paginate` for pagination
- RemixIcon (CDN) for icons, jQuery (CDN)
- `bcrypt` + `has_secure_password` for authentication — no Devise

## Architecture

**Authentication:** `ApplicationController` has a global `before_action :authenticate` that redirects unauthenticated users to the login page. `SessionsController` skips it for `new`/`create`. The `Member` model serves as the user — there is no separate User model. Authentication uses `session[:user_id]`.

**Domain models:**
- `Member` — association members who also log in. Has `role` and `number` fields. `full_name` helper combines `first_name` + `surnames`. The `status` method is stubbed (always returns `'Al corriente'`).
- `Quote` — a periodic fee with a date range and amount (e.g., annual dues).
- `Charge` — links a `Member` to a `Quote`, recording when/if they paid. The model currently says `belongs_to :brother` but the DB column is `member_id` — this needs to be `belongs_to :member`.

**Known bugs / inconsistencies:**
- `Charge` model: `belongs_to :brother` should be `belongs_to :member` (column is `member_id`).
- `MemberConfirmationController`: uses `User.find_by_id` — should be `Member.find_by_id`.
- Routes has a typo: `member_confimation#qr` (missing 'r') — the actual controller file is `member_confirmation_controller.rb`.
- `QuotesController#generate_charges`: references undefined `Member.active` scope, uses bare `quote` and `brother` instead of `@quote` and `member`.
- `MembersController` has duplicate `edit` and `update` method definitions.
- `member_params` permits `:surname` but the DB column is `surnames`.

**Views:** ERB templates. No shared partials yet. Layout (`application.html.erb`) loads RemixIcon and jQuery from CDN.
