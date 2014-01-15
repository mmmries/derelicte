# JavaCssInliner

Take an html template and css file and inline the css rules into style attributes.

This is mostly useful for sending emails.

This gem attempts to make the inlining process very performant. If you want a richer feature set and more usability please see [Roadie](https://github.com/Mange/roadie) or [PreMailer](http://premailer.dialect.ca/).

## How much time are we talking about?

I used an example welcome email from my current job that uses the [Zurb Ink](https://github.com/zurb/ink) email css framework. It has a slightly complex DOM and lots of CSS. Both benchmarks have a warmup phase where they inline 1,000 emails before being measured (to account for JVM and JIT warming up)

```bash
                                     user     system      total        real
roadie 3                         0.430000   0.030000   0.460000 (  0.499000)
java_css_inliner                 0.000000   0.000000   0.000000 (  0.010000)
```

Saving roughly 50x is not too shabby, but we definitely make some tradeoffs to get that performance.

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
 * Since we use a basic XML parser it is pretty sensitive to bad markup. Things like unclosed breaks (<code><br></code> instead of <code><br /></code>) will cause it to choke. Make sure you double-check your templates.
