#lang racket

;Part 1

(define (check-line line)
  (let ((count (make-hash)))
    (for ([chr (string->list line)])
         (if (hash-has-key? count chr)
             (hash-set! count chr (+ 1 (hash-ref count chr)))
             (hash-set! count chr 1)))
    (cons 
      (if (member 2 (hash-values count)) 1 0)
      (if (member 3 (hash-values count)) 1 0))))
  

(define (checksum)
  (let-values ([(a b) (for/fold ([twos 0] [threes 0])
                                ([line (file->lines "day2input.txt")])
                                (let ((vals (check-line line)))
                                  (values (+ twos (car vals)) (+ threes (cdr vals)))))])
    (* a b)))

(checksum)
