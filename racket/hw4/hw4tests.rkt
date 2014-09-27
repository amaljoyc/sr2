#lang racket

(require "hw4.rkt") 

;; A simple library for displaying a 2x3 grid of pictures: used
;; for fun in the tests below (look for "Tests Start Here").

(require (lib "graphics.rkt" "graphics"))

(open-graphics)

(define window-name "Programming Languages, Homework 4")
(define window-width 700)
(define window-height 500)
(define border-size 100)

(define approx-pic-width 200)
(define approx-pic-height 200)
(define pic-grid-width 3)
(define pic-grid-height 2)

(define (open-window)
  (open-viewport window-name window-width window-height))

(define (grid-posn-to-posn grid-posn)
  (when (>= grid-posn (* pic-grid-height pic-grid-width))
    (error "picture grid does not have that many positions"))
  (let ([row (quotient grid-posn pic-grid-width)]
        [col (remainder grid-posn pic-grid-width)])
    (make-posn (+ border-size (* approx-pic-width col))
               (+ border-size (* approx-pic-height row)))))

(define (place-picture window filename grid-posn)
  (let ([posn (grid-posn-to-posn grid-posn)])
    ((clear-solid-rectangle window) posn approx-pic-width approx-pic-height)
    ((draw-pixmap window) filename posn)))

(define (place-repeatedly window pause stream n)
  (when (> n 0)
    (let* ([next (stream)]
           [filename (cdar next)]
           [grid-posn (caar next)]
           [stream (cdr next)])
      (place-picture window filename grid-posn)
      (sleep pause)
      (place-repeatedly window pause stream (- n 1)))))

;; Tests Start Here

; These definitions will work only after you do some of the problems
; so you need to comment them out until you are ready.
; Add more tests as appropriate, of course.

; Problem 1
(print "Problem 1 :")
(equal? (sequence 3 11 2) '(3 5 7 9 11))
(equal? (sequence 3 8 3) '(3 6))
(equal? (sequence 3 2 1) '())

; Problem 2
(print "Problem 2 :")
(equal? (string-append-map '("this" "is" "cool") "#123") '("this#123" "is#123" "cool#123"))

; Problem 3
(print "Problem 3 :")
(equal? (list-nth-mod '(1 2 3 4 5 6) 10) 5)

; Problem 4
(print "Problem 4 :")
(define nats 
  (letrec ([f (lambda (x) (cons x (lambda() (f (+ x 1)))))])
    (lambda() (f 1))))
(equal? (stream-for-n-steps nats 5) '(1 2 3 4 5))

; Problem 5
(print "Problem 5 :")
(equal? (stream-for-n-steps funny-number-stream 15) '(1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15))

; Problem 6
(print "Problem 6 :")
(equal? (stream-for-n-steps dan-then-dog 5) '("dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg" "dan.jpg"))

; Problem 7
(print "Problem 7 :")
(equal? (stream-for-n-steps (stream-add-zero funny-number-stream) 10)
        (list (cons 0 1) (cons 0 2) (cons 0 3) (cons 0 4) (cons 0 -5) (cons 0 6) (cons 0 7) (cons 0 8) (cons 0 9) (cons 0 -10)))

(define nums (sequence 0 5 1))

(define files (string-append-map 
               (list "dan" "dog" "curry" "dog2") 
               ".jpg"))

(define funny-test (stream-for-n-steps funny-number-stream 16))

; a zero-argument function: call (one-visual-test) to open the graphics window, etc.
#;(define (one-visual-test)
  (place-repeatedly (open-window) 0.5 (cycle-lists nums files) 27))

; similar to previous but uses only two files and one position on the grid
(define (visual-zero-only)
  (place-repeatedly (open-window) 0.5 (stream-add-zero dan-then-dog) 27))
