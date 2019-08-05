# Movies

Sample app to fetch content from [The Movie Database (TMDb)](https://www.themoviedb.org/documentation/api).

## Prerequisites

There are some prerequisites needed to build the app.

They are:

- Ruby
- Bundler
- Cocoapods

### Ruby

There are some environment dependencies that need Ruby to run. In order to use
the same Ruby version it is recommended to install
[rbenv](https://github.com/rbenv/rbenv) or another Ruby version manager.

```sh
brew install rbenv
```

Install the Ruby version used on the project:

```sh
rbenv install `cat .ruby-version`
```

### Using [Bundler](https://bundler.io/)

Provides a consistent environment when using Ruby dependencies.

```sh
gem install bundler
```

### Using [CocoaPods](https://cocoapods.org/)

Dependency manager for Swift and Objective-C Cocoa projects.

```sh
bundle install
```

## App dependencies

The app use some third party dependencies and some development dependencies.

To install:

```sh
bundle exec pod install
```

### [SwiftLint](https://github.com/realm/SwiftLint)

A tool to enforce Swift style and conventions.
