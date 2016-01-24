# Dragonfly PDF

[![Build Status](https://travis-ci.org/tomasc/dragonfly_pdf.svg)](https://travis-ci.org/tomasc/dragonfly_pdf) [![Gem Version](https://badge.fury.io/rb/dragonfly_pdf.svg)](http://badge.fury.io/rb/dragonfly_pdf) [![Coverage Status](https://img.shields.io/coveralls/tomasc/dragonfly_pdf.svg)](https://coveralls.io/r/tomasc/dragonfly_pdf)

[Dragonfly](https://github.com/markevans/dragonfly) PDF analysers and processors.

## Dependencies

* [ImageMagick](http://www.imagemagick.org)
* [GhostScript](http://www.ghostscript.com)

## Installation

Add this line to your application's Gemfile:

    gem 'dragonfly_pdf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly_pdf

## Usage
The analyser and processors are added by configuring the plugin

```ruby
Dragonfly.app.configure do
  plugin :pdf
end
```

## Analysers

### PDF properties

Reads properties from a PDF.

```ruby
pdf.pdf_properties
```

It returns a hash of properties:

```ruby
{
    page_count: 4,
    page_dimensions: [[210.0, 297.0], [210.0, 297.0], [210.0, 297.0], [210.0, 297.0]],
    page_numbers: [1, 2, 3, 4],
    widths: [210.0, 210.0, 210.0, 210.0],
    heights: [297.0, 297.0, 297.0, 297.0],
    aspect_ratios: [0.71, 0.71, 0.71, 0.71]
}
```

## Processors

### Append

Append PDFs.

```ruby
pdf.append([pdf_1, pdf_2, pdf_3])
```

### Page

Extracts page from PDF.

```ruby
pdf.page(page_number=1)
```

### Page Thumb

Generates thumbnail of a specified page, in defined density (dpi) and format.

```ruby
pdf.page_thumb(page_number=1, opts={})
```

The available options and their default values are:

```ruby
{
    density: 600,
    format: :png,
}
```

### Stamp

Stamp every page of a PDF with another PDF.

```ruby
pdf.stamp(stamp_pdf)
```

### Subset Fonts

Subset fonts in PDF.

```ruby
pdf.subset_fonts
```

## Contributing

1. Fork it ( https://github.com/tomasc/dragonfly_pdf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
