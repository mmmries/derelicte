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

inliner = CSS::Inliner.new
inlined_html = inliner.inline(html, css) # => "<p style=\"color: #ff0000;\">ohai</p>"
```


## Current Issues

 * doctypes with full URLs (like xhtml) will make the process extremely slow since the standard java libraries attempt to fetch and parse the DTD. It is highly recommended that you simply use an HTML 5 style doctype (<code><!DOCTYPE html></code>)
 * Since we use a basic XML parser it is pretty sensitive to bad markup. Things like unclosed breaks will cause it to choke. Make sure you double-check your templates.

```html
<!-- Things that will break the XML parsing -->
<br>
<img href="/icon.png">
<meta charset='utf-8'>
<hr>

<!-- These things are okay for the XML parser -->
<br/>
<img href="/icon.png" />
<meta charset='utf-8' />
<hr/>
```
