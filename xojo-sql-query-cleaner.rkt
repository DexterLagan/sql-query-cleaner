#lang racket/gui

(define appname "Query Tester")

(define (get-clipboard-text)
  (send the-clipboard get-clipboard-string 0))

(define (set-clipboard-text s)
  (send the-clipboard set-clipboard-string s 0))

(define query-str (get-clipboard-text)) ;(get-text-from-user appname "   Please paste your Xojo SQL query here:    "))
(define (all-but-last l) (reverse (cdr (reverse l))))

(let* ((s query-str)
       (s1 (string-replace s "\"+_" ""))               ; remote Xojo line breaks
       (s2 (string-replace s1 "\"" ""))                ; remove double-quotes
       (s3 (string-replace s2 "\n" ""))                ; remove line feeds
       (s4 (if (string-prefix? s3 "(")                 ; remove accidental leading "("
               (list->string (cdr (string->list s3)))
               s3))
       (s5 (if (string-suffix? s3 ")")                 ; remove accidental trailing ")"
               (list->string (all-but-last (string->list s4)))
               s4)))
  (set-clipboard-text s5))
