#lang typed/racket

(require "object.rkt")

(provide (all-defined-out))

(define-type URIDictionary (List (Pairof 'S 'URI)
                                 (Pairof 'URI String)
                                 (Pairof 'IsMap (U PDFNull Boolean))))

(define-type CatalogURIDictionary (List (Pairof 'S 'URI)
                                        (Pairof 'Base String)))

(: uri (->* (String) (Boolean) URIDictionary))
(define (uri s [b (PDFNull)])
  (dictionary
   'S 'URI
   'URI s
   'IsMap b))


(: catalog-uri : String -> CatalogURIDictionary)
(define (catalog-uri s)
  (dictionary
   'S 'URI
   'Base s))