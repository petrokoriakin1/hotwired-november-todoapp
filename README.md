# Hotwired November Todoapp: https://hotwired-november-todoapp.fly.dev/

## Local dev setup

Make sure you have `ruby 3.2.2`, `rails 7.1.1` and `PostgreSQL 16.0` on your machine. To install them, [a brief guide from GoRails](https://gorails.com/setup) can be used.

```
bundle install

bin/rails db:create db:migrate db:seed

bin/dev
```

