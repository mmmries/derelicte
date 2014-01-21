# Derelicte

[![Build Status](https://travis-ci.org/hqmq/derelicte.png)](https://travis-ci.org/hqmq/derelicte)
[![Code Climate](https://codeclimate.com/github/hqmq/derelicte.png)](https://codeclimate.com/github/hqmq/derelicte)
[![Dependency Status](https://gemnasium.com/hqmq/derelicte.png)](https://gemnasium.com/hqmq/derelicte)

![Derelicte Gif](http://24.media.tumblr.com/d7c64874eeae527c2661cda9c107984c/tumblr_msas87gWdt1qaehqco1_400.gif)

A JRuby specific gem that takes an html template and css file and inlines the css rules into style attributes.  This is mostly useful for sending emails.

This gem attempts to make the inlining process very performant. If you want a richer feature set please see [Roadie](https://github.com/Mange/roadie) or [PreMailer](http://premailer.dialect.ca/).

This gem was only created because I was involved in a project where the above options were too slow to be feasible in day-to-day operations.

## How much time are we talking about?

I used an example welcome email from my current job that uses the [Zurb Ink](https://github.com/zurb/ink) email css framework. It has a slightly complex DOM and lots of CSS. Both benchmarks have a warmup phase where they inline 1,000 emails before being measured (to account for JVM and JIT warming up)

```bash
                                     user     system      total        real
roadie 3                         0.430000   0.030000   0.460000 (  0.499000)
derelicte                        0.000000   0.000000   0.000000 (  0.010000)
```

Saving roughly 50x is not too shabby, but we definitely make some tradeoffs to get that performance.

Derelicte uses a handful of native jars (can only used with JRuby) and does not change url paths or inline images via base64 data in tags.

## Usage

Simplest possible usage:

```ruby
html = "<p>ohai</p>"
css = "p { color: #ff0000; }"

inlined_html = ::Derelicte.inline(html, css) # => "<p style=\"color: #ff0000;\">ohai</p>"
```

## Roadmap

Some basic profiling shows that the current process spends about 1/3 of its time parsing the css rules and 1/3 of its time applying the rules to the DOM.

Future versions will probably have a threadsafe way of caching the parsed css files since you generally only have a couple of different css sources.

Future versions will also explore the possiblity of applying the rules to the DOM with raw java code to see how much of that time we can eliminate.
