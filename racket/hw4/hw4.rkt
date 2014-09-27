
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; Problem 1
(define (sequence low high stride)
  (cond [(> low high) null]
        [#t (cons low (sequence (+ low stride) high stride))]))

; Problem 2
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

; Problem 3
(define (list-nth-mod xs n)
  (cond [(negative? n) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

; Problem 4
(define (stream-for-n-steps s n)
  (cond [(= n 0) null]
        [#t (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))]))

; Problem 5
(define funny-number-stream
  (letrec ([f (lambda (x)
                (cond [(= 0 (modulo x 5)) (cons (- x) (lambda() (f (+ x 1))))]
                      [#t (cons x (lambda() (f (+ x 1))))]))])
    (lambda() (f 1))))

; Problem 6
(define (dan-then-dog)
  (define (f x)
    (cond [(equal? x "") (cons "dan.jpg" (lambda() (f "dog.jpg")))]
          [(equal? x "dan.jpg") (cons "dan.jpg" (lambda() (f "dog.jpg")))]
          [#t (cons "dog.jpg" (lambda() (f "dan.jpg")))]))
  (f ""))

; Problem 7
(define (stream-add-zero s)
  (letrec ([f (lambda ()
                (cons (cons 0 (car (s))) (stream-add-zero (cdr (s)))))])
    f))
