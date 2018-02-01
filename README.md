# Waddup

[![Gem Version](https://img.shields.io/gem/v/waddup.svg?style=flat)](https://rubygems.org/gems/waddup)
[![Build Status](https://img.shields.io/travis/timkurvers/waddup.svg?style=flat)](https://travis-ci.org/timkurvers/waddup)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/timkurvers/waddup.svg)](https://codeclimate.com/github/timkurvers/waddup)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/timkurvers/waddup.svg)](https://codeclimate.com/github/timkurvers/waddup)

Waddup is a Ruby gem that retraces your activities from arbitrary sources - such
as version control, issue tracking software and mail clients - and displays them
in a neat chronological overview.

Perfect for those who have lost track of what they have worked on.

**Supported Ruby versions: 2.2 or higher**

Licensed under the **MIT** license, see LICENSE for more information.

![Waddup](https://user-images.githubusercontent.com/378235/27263652-30b4fc90-546e-11e7-80eb-965e33957b1e.png)

## Installation

Waddup is available from RubyGems and can be installed through the command-line.

Fire up your favourite terminal and run:

```shell
gem install waddup
```

Installing on **OSX** and using the **default system Ruby**? Run:

```shell
sudo gem install waddup
```

## Usage

Once installed, use the command `waddup` or its alias `sup` as follows:

```shell
waddup with git and mail since last week through yesterday 23:00
```

Waddup is fairly liberal in what it accepts. The keywords described below may be
mixed or omitted as desired.

### Sources

At present, Waddup ships with three sources:

- Git `git`
- Apple Mail `mail`
- Apple Calendar `ical`

To specify one or multiple sources, use the `with`-keyword forming a regular
sentence with the listed aliases:

```shell
waddup with git
```

```shell
waddup with git, mail and ical
```

When the `with`-keyword is omitted it will default to all usable sources.

### Start date

To specify a start date, use either `from` or `since` as a keyword:

```shell
waddup from october 29, 2013 9:00 AM
```

```shell
waddup since last friday
```

Defaults to right now if a start date is omitted. This default is likely to
change in the future.

Dates/times are liberally parsed using [Chronic]. A grasp of crazy inputs one
can use:

- yesterday
- last night
- last winter
- 3rd wednesday in november
- may seventh '97 at three in the morning

### End date

To specify an end date, use one of `to`, `until`, `uptil`, `upto` or `through`:

```shell
waddup upto one week ago
```

```shell
waddup through yesterday
```

Defaults to right now if an end date is omitted.

### Formats

At present, Waddup supports two formats: visual (see screenshot) and JSON.

Use the `--format` flag to indicate the desired output format:

```shell
waddup since yesterday --format json
```

[Chronic]: https://github.com/mojombo/chronic
