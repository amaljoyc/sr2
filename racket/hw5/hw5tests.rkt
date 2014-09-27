#lang racket

(require "hw5.rkt")
(require rackunit)

; Problem 1
(define rl1 (list (int 1) (int 2) (int 3) (int 4)))
(define ml1 (apair (int 1) (apair (int 2) (apair (int 3) (apair (int 4) (aunit))))))
(check-equal? (racketlist->mupllist rl1) ml1 "p1a01")
(check-equal? (mupllist->racketlist ml1) rl1 "p1a02")

; Problem 2
(check-equal? (int 13) (eval-exp (int 13)) "p2a01")
(check-equal? (int 13) (eval-under-env (var "x") (list (cons "x" (int 13)))) "p2a02")
(check-equal? (int 13) (eval-exp (add (int 1) (add (int 2) (int 10)))) "p2a03")
(check-equal? (eval-exp (ifgreater (int 1) (int 2) (add (var "crashifevaluated") (int 3)) (int 42)))
              (int 42)
              "Testing ifgreater 1 2")
(check-equal? (eval-exp (ifgreater (int 2) (int 1) (int 42) (add (var "crashifevaluated") (int 3))))
              (int 42)
              "Testing ifgreater 2 1")
(check-equal? (int 101) (eval-exp (ifgreater (int 1) (add (int 0) (int 0)) (add (int 100) (int 1)) (int 102))) "p2a04")
(check-equal? (int 12) (eval-exp (mlet "x" (int 12) (var "x"))) "p2a05")
(check-equal? (apair (int 1) (int 2)) (eval-exp (apair (int 1) (add (int 2) (int 0)))) "p2a06")
(check-equal? (int 1) (eval-exp (fst (apair (int 1) (add (int 2) (int 0))))) "p2a07")
(check-equal? (int 2) (eval-exp (snd(apair (int 1) (add (int 2) (int 0))))) "p2a08")
(check-equal? (aunit) (eval-exp (aunit)) "p2a09")
(check-equal? (int 1) (eval-exp (isaunit (aunit))) "p2a10")
(check-equal? (int 0) (eval-exp (isaunit (int 1))) "p2a11")
(check-equal? (int 12) (eval-under-env 
                        (mlet "x" (add (int 8) (var "y")) 
                              (add (var "x") (var "y"))) (list (cons "y" (int 2)))) "p2a12")
(check-equal? (int 2) (eval-exp (mlet "plus1" (fun #f "par" (add (var "par") (int 1))) (call (var "plus1") (int 1)))) "p2a13")
(check-equal? (int 14) 
              (eval-exp (call (fun "add-until>5" "v" 
                                   (ifgreater (var "v") (int 5) (int 0) (add (var "v") (call (var "add-until>5") (add (var "v") (int 1)))))) 
                              (int 2))) 
              "p2a14")

; Problem 3
(check-equal?
  (eval-exp (ifaunit (int 1) (int 2) (int 3)))
  (int 3))
(check-equal?
  (eval-exp (ifaunit (aunit) (int 2) (int 3)))
  (int 2))
(check-equal?
  (eval-exp (mlet* (list (cons "x" (int 1)) (cons "y" (add (var "x") (int 2))))
                   (add (var "x") (var "y"))))
  (int 4))
(check-equal?
  (eval-exp (ifeq (int 3) (add (int 1) (int 2)) (int 1) (int 2)))
  (int 1))
(check-equal?
  (eval-exp (ifeq (int 3) (add (int 1) (int 1)) (int 1) (int 2)))
  (int 2))

; Problem 4



; a test case that uses problems 1, 2, and 4
; should produce (list (int 10) (int 11) (int 16))
#;(define test1
  (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 7))
                   (racketlist->mupllist 
                    (list (int 3) (int 4) (int 9)))))))
