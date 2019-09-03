# Open source Kanban-style task manager

[![Build Status](https://travis-ci.org/BrandyMint/tasky.svg?branch=master)](https://travis-ci.org/BrandyMint/tasky)

This is a trello written on Ruby On Rails and React ;)

## Full featured online demo

[![Demo](https://tasky.online/demo.png)](https://tasky.online)

# Features

* Trello-like accounts, boards and cards with drag-n-drop support
* Full featured and swagger documented REST JSON:API
* File attachments with storage in Amazon S3
* Task comments (online chat)
* One task could be placed on to various boards

# Technical stack

* React 16.9 and Webpack 4 on frontend
* Internationalization support with i18next
* Postgresql as database
* Sidekiq for async jobs
* CI/CD with travis.org

# Road map

* Notifications (task changes and comments update)
* Archive of boards, cards. Possibility to restore.
* Improve UI (modal card page)
* Permission management
* Search cards, comments and users

## System Dependencies

1. Postgresql > 9.6
2. Redis > 3

## Install

1. Install `nvm` and required `nodejs`
2. Install `rbenv` and required `ruby`
3. Install Ruby and JS dependencies

> bundle
> ./bin/yarn install

## Development

1. Start webpack-dev-server:

> ./bin/webpack-dev-server

2. Start rails server:

> ./bin/rails s

3. Go to http://localhost:3000

4. Start guard to online testing

> ./bin/bundle exec guard

## Online support

* [Telegram bot](http://t.me/tasky_chaport_bot)

## Contributors

* [Danil Pismenny](https://github.com/dapi)

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## License

MIT License, see [LICENSE](LICENSE).
