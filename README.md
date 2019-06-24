# Tasky (a-la trello task manager)

[![Build
Status](https://travis-ci.com/BrandyMint/tasky.svg?branch=master)](https://travis-ci.com/BrandyMint/tasky)


## Install

### 1. Setup `nvmrc` and `envrc`

### 2. Install applicaiton dependencies

> bundle
> yarn install

### action_cable

Link: https://github.com/rails/rails/issues/35501

We see broken action_cable webpacker support. It has but `TypeError: r is not a
function. (In 'r(Symbol.iterator)', 'r' is undefined)` in production mode.
And it can't be imported from sources becouse of it does not containt
`./internal.js`

That is why we generate `./internal.js` and copy `action_cable` to
`lib/action_cable` from `./node_modules` with `yarn postinstall`

You need do nothing. 

### Alternative react-trello compoments

* https://github.com/lourenci/react-kanban

### Markdown components

* https://github.com/sparksuite/simplemde-markdown-editor
* https://github.com/ianstormtaylor/slate
* imperavi redactor
* http://hallojs.org/demo/markdown/
* https://marked.js.org/demo/
* https://github.com/jonschlinkert/remarkable
* http://jedwatson.github.io/react-md-editor/
* https://github.com/OpusCapita/react-markdown
* https://andrerpena.me/react-mde/
* https://github.com/andrerpena/react-mde
