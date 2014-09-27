#lang racket

; to make everything public
(provide (all-defined-out))

(define x 10)

(define y (+ x 2))

; lambda is used to denote anonymous function
(define cube1
  (lambda (x)
    (* x x x)))

(define (cube2 x)
  (* x x x))

(define (multiply1 x y z)
  (* x y z))

; using curring
(define multiply2
  (lambda (x)
    (lambda (y)
      (lambda (z)
        (* x y z)))))

; recursion example
(define (pow x y)
  (if (= y 0)
      1
      (* x (pow x (- y 1)))))

; Sum all the numbers in a list
(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

; Append two lists
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))

; cond is used as a syntactic sugar for if-else-if nested structure
; fun to find the sum of all elements in a list. Note that the list can containt other list of numbers as well.
(define (sum-list xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum-list (cdr xs)))]
        [#t (+ (sum-list (car xs)) (sum-list (cdr xs)))]))

; let examples
(define (let1 x)
  (let ([y (+ x 1)])
    y))

; here y will not use the x inside let binding but will use the parameter x
(define (let2 x)
  (let ([x (+ x 1)]
        [y (+ x 1)])
    (list x y)))

; let* is same as ml's let (ie. here y use the x inside the let expression)
(define (let3 x)
  (let* ([x (+ x 1)]
        [y (+ x 1)])
    (list x y)))

; letrec is used for mutual recursion. it can use the bindings before and after inside let.
(define (let4 x)
  (letrec ([w (+ x 1)]
           [f (lambda (z) (+ w y z))]
           [y 1])
    (f 2)))

; using define instead of let expression
(define (let5 x)
  (define y (+ x 1))
  (define z (+ x 2))
  (list y z))

; This is an example explaining that we can't redefine/shadow already defined bindings (but can be done inside a function)
(define myvar 100)
; (define myvar 50) ; this gives error as it is redefining myvar
(define (myvar_test)
  (define myvar 50) ; but we can redefine/shadow myvar inside a function
  ; (define myvar 30) ; but this will fail since its trying to redefine a binding already done inside the funtion once
  myvar)
;(define (myvar_test) (define myvar 30) myvar) ; this function will also give an error as it is redefining myvar_test

; But we can redefine variable bindings in racket using set!. But be very carefull with this. Not good to use it often
(define zoro "z")
(set! zoro "c")

; beign is used to do some side-effects. Only the final expression is assingned to b1 when begin is used.
(define b1 (begin
            10
            12
            13))

(define pr (cons 1 (cons 2 (cons 3 4))))
(define lst (cons 1 (cons 2 (cons 3 (cons 4 null)))))
; (list 1 2)
; (pair? (cons 1 2))

; mcons example - mcons can be used to make mutable lists or pairs
(define mutable-cons (mcons 1 (mcons 2 (mcons 3 null))))
(set-mcar! mutable-cons 50)
(set-mcdr! mutable-cons "hello")

; Three ways of defining....
;(define dog1 "dog1")
;dog1 ; early evaluation
;(define dog2 (lambda() "dog2"))
;(dog2) ; delayed evaluation (evaluated only when the function is called). Also called thunk
;(define (dog3) (+ 1 2)) ; donno how to return "dog3" string here..help plz
;(dog3) ; delayed evaluation (evaluated only when the function is called)

; Streams
; 1 1 1 1 ....
(define ones (lambda () (cons 1 ones)))

; 1 2 3 4 ....
(define nats 
  (letrec ([f (lambda (x) (cons x (lambda() (f (+ x 1)))))])
    (lambda() (f 1))))

; Problem 4 using helper function
(define (stream-for-n-steps1 s n)
  (letrec ([helper (lambda (s lst counter)
                     (cond [(= counter n) lst]
                           [#t (helper (cdr (s)) (cons (car (s)) lst) (+ counter 1))]))])
    (helper s null 0)))

; Problem 6 using letrec
(define dan-then-dog
  (letrec ([f (lambda (x)
              (cond [(equal? x "") (cons "dan.jpg" (lambda() (f "dog.jpg")))]
                    [(equal? x "dan.jpg") (cons "dan.jpg" (lambda() (f "dog.jpg")))]
                    [#t (cons "dog.jpg" (lambda() (f "dan.jpg")))]))])
    (lambda() (f ""))))

; macros
; 1) if then else
(define-syntax my-if
  (syntax-rules (then else)
    [(my-if e1 then e2 else e3) 
     (if e1 e2 e3)]))
; 2) commenting-out the first expression
(define-syntax comment-out
  (syntax-rules ()
    [(comment-out e1 e2) e2]))

; macro to explain a the concept that follows
(define-syntax dbl
  (syntax-rules ()
    [(dbl x) (* 2 x)]))
(define (test-macro)
  (let [(* +)]
    (dbl 42)))
; In the above function '*' is replaced with '+' function but still the macro uses '*' as '*' itself because of the lexical scope
; But in c/c++ macros this will produce 44 instead of 84 since it will replace '*' with '+' because of its dynamic scope