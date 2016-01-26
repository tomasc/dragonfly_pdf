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
