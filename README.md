# JavaCssInliner

Take an html template and css file and inline the css rules into style attributes.

This is mostly useful for sending emails.

This gem attempts to make the inlining process very performant. If you want a richer feature set and more usability please see [Roadie](https://github.com/Mange/roadie) or [PreMailer](http://premailer.dialect.ca/).

## Usage

Simplest possible usage:

```ruby
html = "<p>ohai</p>"
css = "p { color: #ff0000; }"

inliner = CSS::Inliner.new
inlined_html = inliner.inline(html, css) # => "<p style=\"color: #ff0000;\">ohai</p>"
```


## Current Issues

 * The doctype seems to be getting lost somewhere so a hardcoded doctype of <code><!DOCTYPE html></code> is being added automatically
