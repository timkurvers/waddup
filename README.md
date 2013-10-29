# Waddup

[![Gem Version](https://badge.fury.io/rb/waddup.png)](https://rubygems.org/gems/waddup)
[![Build Status](https://secure.travis-ci.org/timkurvers/waddup.png?branch=master)](https://travis-ci.org/timkurvers/waddup)
[![Dependency Status](https://gemnasium.com/timkurvers/waddup.png)](https://gemnasium.com/timkurvers/waddup)
[![Code Climate](https://codeclimate.com/github/timkurvers/waddup.png)](https://codeclimate.com/github/timkurvers/waddup)
[![Coverage Status](https://coveralls.io/repos/timkurvers/waddup/badge.png?branch=master)](https://coveralls.io/r/timkurvers/waddup)

Waddup is a Ruby gem that retraces your activities from arbitrary sources - such as version control, issue tracking software and mail clients - and displays them in a neat chronological overview.

Perfect for those who have lost track of what they have worked on.

**Supported Ruby versions: 1.8.7 or higher**

Licensed under the **MIT** license, see LICENSE for more information.

![Waddup](http://office.moonsphere.net/waddup.png?v1)


## Installation

Waddup is available from RubyGems and can be installed through the command-line.

Fire up your favourite terminal and run:

    gem install waddup

Installing on **OSX** and using the **default system Ruby**? Run:

    sudo gem install waddup


## Usage

Once installed, use the command `waddup` or its alias `sup` as follows:

    waddup with git and mail since last week until yesterday 23:00

Waddup is fairly liberal in what it accepts. The keywords described below may be mixed or ommitted as desired.


### Sources

At present, Waddup ships with three sources:

* Git `git`
* Apple Mail `mail`
* Apple Calendar `ical`

To specify one or multiple sources, use the `with`-keyword forming a regular sentence with the listed aliases:

    waddup with git
    waddup with git, mail and ical

When the `with`-keyword is ommitted it will default to all usable sources.


### Start date

To specify a start date, use either `from` or `since` as a keyword:

    waddup from october 29, 2013 9:00 AM
    waddup since last friday

Defaults to right now if a start date is ommitted. This default is likely to change in the future.

Dates/times are liberally parsed using [Chronic](https://github.com/mojombo/chronic). A grasp of crazy inputs one can use:

* yesterday
* last night
* last winter
* 3rd wednesday in november
* may seventh '97 at three in the morning


### End date

To specify an end date, use one of `to`, `until`, `uptil`, `upto` or `through`:

    waddup upto one week ago
    waddup through yesterday

Defaults to right now if an end date is ommitted.
