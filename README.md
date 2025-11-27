# Hotwired November Todoapp: https://hotwired-november-todoapp.fly.dev/

# `tailwind` + `stimulus` + `hotwire` + `agenticAI`

## Local dev setup

Make sure you have `ruby 3`, `rails 8` and `SQLite3` on your machine. To install them, [a brief guide from GoRails](https://gorails.com/setup) can be used.

```
bundle install

bin/rails db:create db:migrate db:seed

bin/dev
```

Or using overmind (if installed):
```
overmind start
```

## Development

### Asset Pipeline
The application uses Rails asset pipeline with:
- **Tailwind CSS** - Utility-first CSS framework (compiled with `tailwindcss:watch`)
- **Importmap** - ES modules without the build pipeline
- **Hotwired Turbo & Stimulus** - Dynamic frontend with minimal JavaScript

For asset pipeline details and recent fixes, see [`.github/ASSET_PIPELINE_FIX.md`](.github/ASSET_PIPELINE_FIX.md)

### Running Tests
```
bundle exec rspec                 # Run all tests
bundle exec rubocop               # Lint code
bin/rails assets:precompile       # Precompile assets
```

### Docker
```
docker build --tag hotwired-november-todoapp .
docker run -p 3000:3000 hotwired-november-todoapp
```

