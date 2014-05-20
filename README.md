# generator-webapp-full-mocha [![Build Status](https://secure.travis-ci.org/raymond-h/generator-webapp-full-mocha.png?branch=master)](https://travis-ci.org/raymond-h/generator-webapp-full-mocha)

A generator for [Yeoman](http://yeoman.io), using Mocha as testing framework for server unit, client unit and end to end testing, Chai + Chai as Promised included.


## Getting Started

### What is Yeoman?

Trick question. It's not a thing. It's this guy:

![](http://i.imgur.com/JHaAlBJ.png)

Basically, he wears a top hat, lives in your computer, and waits for you to tell him what kind of application you wish to create.

Not every new computer comes with a Yeoman pre-installed. He lives in the [npm](https://npmjs.org) package repository. You only have to ask for him once, then he packs up and moves into your hard drive. *Make sure you clean up, he likes new and shiny things.*

```
$ npm install -g yo
```

### Yeoman Generators

Yeoman travels light. He didn't pack any generators when he moved in. You can think of a generator like a plug-in. You get to choose what type of application you wish to create, such as a Backbone application or even a Chrome extension.

To install generator-webapp-full-mocha from npm, run:

```
$ npm install -g generator-webapp-full-mocha
```

Finally, initiate the generator:

```
$ yo webapp-full-mocha
```

### Getting To Know Yeoman

Yeoman has a heart of gold. He's a person with feelings and opinions, but he's very easy to work with. If you think he's too opinionated, he can be easily convinced.

If you'd like to get to know Yeoman better and meet some of his friends, [Grunt](http://gruntjs.com) and [Bower](http://bower.io), check out the complete [Getting Started Guide](https://github.com/yeoman/yeoman/wiki/Getting-Started).

### Some more details

#### Folder structure
- `src/`: Server-side script files (either JS or CS)
- `app/`: Client-side files (CS, LESS + JS, CSS, HTML)
- `lib/`: Compiled server-side files (files that don't have to be compiled are copied from `src/`)
- `built-app/`: Compiled client-side files (files that don't have to be compiled are copied from `app/`)
- `test/`: All tests
    - `server/`: Server-side unit tests
    - `client/`: Client-side tests
        - `unit/`: Unit tests
        - `e2e/`: End to end tests

This project is mainly meant for doing AngularJS development; as such, Protractor is used for end-to-end testing. Karma with PhantomJS is used for client unit testing, whereas just Mocha is used for server unit tests. There are no restrictions on folder layout in `app/` or `src/`, aside from filename of main server script file being `main`.

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
