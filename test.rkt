#lang typed/racket

(require "object.rkt"
         "catalog.rkt"
         "font.rkt"
         "text.rkt"
         "page.rkt"
         "build.rkt")

(: page1 Page)
(define page1 (page #:contents (Indirect (text->stream 'F1 12
                                                       50
                                                       72 770
                                                       (list "He" 100 "llo" 100 " there")))
                    #:resources (ann (dictionary
                                      'Font (make-font 'F1 (type1 'Times-Roman))) Dictionary)))

(: page2 Page)
(define page2 (page #:contents (Indirect (stream #"BT /F1 12 Tf 14.5 TL 297.5 421 Td (He) ' (llo) ' (there) '"))
                    #:resources (ann (dictionary
                                      'Font (make-font 'F1 (type1 'Times-Roman))) Dictionary)))

(: page3 Page)
(define page3 (page #:media-box (list 0 0 595 842)
                    #:contents (Indirect (text->paragraph
                                          'F1 12
                                          80
                                          16.8
                                          72 770
                                          "This is a paragraph. It was generated with racket. It contains a number of sentences delimited with a full stop and separated with a single space. Each sentence in turn is comprised of a number words seprated with spaces. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vehicula purus a massa pharetra consectetur. In nec purus lobortis, rutrum elit varius, pharetra ipsum. Fusce nec ornare augue, eget venenatis est. Pellentesque enim nibh, malesuada imperdiet ante quis, pretium maximus dui. Proin venenatis tortor lacinia egestas gravida. Sed consectetur lacus et risus hendrerit feugiat. Donec pretium accumsan orci eu dapibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam interdum diam sed tortor varius commodo. Nam libero diam, vehicula a libero at, fermentum malesuada lorem. Mauris ut ligula nisi. Proin erat tellus, aliquet at pharetra sit amet, iaculis tempor sapien. Maecenas quis metus elit. In est lacus, ornare sollicitudin ultrices ac, ullamcorper a mi."))
                    #:resources (ann (dictionary
                                      'Font (make-font 'F1 (type1 'Times-Roman))) Dictionary)))

(: pages PageTree)
(define pages (pagetree #:parent (PDFNull) ; This our root PageTree so we pass PDFNull as parent
                    #:media-box (list 0 0 595 842)
                    (list
                     (Indirect page3)
                     (Indirect page1)
                     (Indirect page2))
                    3))

;(display (compile-pdf cat)) (write-pdf (compile-pdf cat) "test.pdf")

;(display (compile-pdf (catalog (->tree (list (Indirect (page)) (Indirect (page)) (Indirect (page)) (Indirect (page))) 2))))

(: cat Catalog)
(define cat (catalog (->tree (list
                              (Indirect page3)
                              (Indirect page3)
                              (Indirect page3)
                              (Indirect page3)) 2 #t)))
                     ;(Indirect pages)))
(display (compile-pdf cat))
(write-pdf (compile-pdf cat)
           "test.pdf")