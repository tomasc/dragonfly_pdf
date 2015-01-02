# Dragonfly PDF

[![Build Status](https://travis-ci.org/tomasc/dragonfly_pdf.svg)](https://travis-ci.org/tomasc/dragonfly_pdf) [![Gem Version](https://badge.fury.io/rb/dragonfly_pdf.svg)](http://badge.fury.io/rb/dragonfly_pdf) [![Coverage Status](https://img.shields.io/coveralls/tomasc/dragonfly_pdf.svg)](https://coveralls.io/r/tomasc/dragonfly_pdf)

[Dragonfly](https://github.com/markevans/dragonfly) PDF analysers and processors.

## Installation

Add this line to your application's Gemfile:

    gem 'dragonfly_pdf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly_pdf

## Plugin
The analyser and processors are added by configuring the plugin

```ruby
Dragonfly.app.configure do
  plugin :pdf
end
```

## Analysers

### PDF properties

This processor has argument `spreads` (by default set to `false`). When `true`, the analyser assumes the PDF might contain 2 real pages per one PDF page (as when saving with the spreads option in InDesign) and recalculates the PDF properties accordingly (including situations when PDF starts or ends with single page).

```ruby
pdf.pdf_properties(spreads=false)
```

Returns Hash of PDF properties:

```ruby
{
    page_count: 4,
    spread_count: 3,
    page_numbers: [[1], [2, 3], [4]],
    widths: [[210.0], [210.0, 210.0], [210.0]],
    heights: [[297.0], [297.0, 297.0], [297.0]],
    aspect_ratios: [[0.71], [0.71, 0.71], [0.71]], 
    info: { … }
}
```

When the `spreads` argument is set to true, all page arrays (page_numbers, widths, heights, aspect_ratios) are two dimensional (as illustrated above), representing spreads and nested individual pages.

## Processors

### Page Thumb

Generates thumbnail of a specified page, in defined density (dpi) and format.

```ruby
pdf.page_thumb(page_number=0, opts={})
```

The available options and their default values are:

```ruby
{
    density: 600,
    format: :png,
    spreads: false
}
```

Similarly to the `#pdf_properties`, the `#page_thumb` processor takes into account the `spreads` option.

## TODO

* Add more tests for `#page_thumb`

## Contributing

1. Fork it ( https://github.com/tomasc/dragonfly_pdf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request