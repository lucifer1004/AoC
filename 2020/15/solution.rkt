#lang racket

(define in
  (open-input-file "input.txt"))
(define nums
  (list->vector
   (map string->number
        (string-split
         (read-line in) ","))))
(define occur (make-hash))

(define (call-next last turn target)
  (cond
    [(equal? turn target) last]
    [(< turn (vector-length nums))
     (let ([num (vector-ref nums turn)])
       (begin
         (hash-set! occur num (list turn))
         (call-next num (add1 turn) target))
       )]
    [(equal? 1 (length (hash-ref occur last)))
     (begin
       (hash-set! occur 0 (cons turn (hash-ref occur 0 '())))
       (call-next 0 (add1 turn) target)
       )]
    [else
     (begin
       (define last-occur (hash-ref occur last))
       (define num (- (first last-occur) (first (rest last-occur))))
       (define num-occur (hash-ref occur num '()))
       (hash-set! occur num 
        (if (equal? 0 (length num-occur))
          (list turn)
          (list turn (first num-occur))
          ))
       (call-next num (add1 turn) target)
       )
     ]
    ))

#| Part I |#
(display (call-next 0 0 2020))
(printf "\n")

#| Part II (Too slow) |#
(display (call-next 0 0 30000000))