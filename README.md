# Movies

Sample app to fetch content from [The Movie Database (TMDb)](https://www.themoviedb.org/documentation/api).

## Requirements

In order for the app to work, it is required an API key to access TMDB. There is a
build phase script that inserts it into the project but it is necessary to have
an environment variable named **API_KEY**.

This variable can be set in the CI or through a bash script. The build phase
script expects for a bash script named **env-vars.sh**. That script will be
executed in case the variable was not set. **(That script must be at the same
directory level of Movies.xcworkspace)**

That bash script can be created manually with a content as below for example:

```sh
export API_KEY={api key}
```

(Change _{api key}_ for the correct api key)

Or it can be generated using an other script called **create-env-vars.sh**.
For example:

```sh
./create-env-vars.sh {api key}
```

(Again, change _{api key}_ for the correct api key)

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

### [Kingfisher](https://github.com/onevcat/Kingfisher)

Kingfisher is a powerful, pure-Swift library for downloading and caching images
from the web.

It is used to cache the poster and backdrop images from the movies.

### [SwiftLint](https://github.com/realm/SwiftLint)

A tool to enforce Swift style and conventions.

### [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

A code generator for Swift language, built on top of Apple's own SourceKit.
It extends the language abstractions to allow you to generate boilerplate
code automatically.

### [Nimble](https://github.com/Quick/Nimble)

A Matcher Framework for Swift and Objective-C
