# CHANGELOG

## 2.2.1

* all paths in quotes

## 2.2.0

* upgrade `dragonfly_libvips` to `~> 2.4.0`
* symbolize keys passed to `ruby-vips`

## 2.1.1

* improved `SUPPORTED_FORMATS` matching that ignores case

## 2.1.0

* add `SUPPORTED_FORMATS` and `SUPPORTED_OUTPUT_FORMATS` and raise errors when formats are not matching
* add more thorough tests for supported formats

## 2.0.1

* fixed: a bug in Convert and Page Thumb Processors which caused the url to not include file extension
* refactored: Page Thumb Processor is now a class
* added: tests for Convert and Page Thumb Processor

## 2.0.0

* PDF rendering to use `mupdf` which results in siginificant performance boost

## 1.1.0

* match `dragonfly_libvips` dependency

## 1.0.0

* updated: `:page_thumb` now uses `dragonfly_libvips ~> 1.0.0`, optimized using `vips-ruby`

## 0.3.0

* refactored: `:page_thumb` now depends on `dragonfly_libvips` for faster processing and ability to specify dimensions (`100x100`) directly

## 0.2.4

* added: `:remove_password`

## 0.2.3

* added: `:page_rotations` data to `pdf_properties`

## 0.2.0

* refactor: read PDF attributes directly
* dependency: `pdftk` for adjustments to PDFs
* added: `append` to combine multiple PDFs together
* added: `rotate` to rotate pages of a PDF
* added: `stamp` to stamping pages with content of another PDF

## 0.1.0

* added: `page_dimensions`
* fixed: calculating page dimensions based on crop area
* removed: the `spread` setting and related calculations have been removed (the logic is better situated on a model using the PDF)
