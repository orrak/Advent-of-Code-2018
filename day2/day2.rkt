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

;Part 2

(define (compare-strings s1 s2)
  (if (equal? (string-length s1) (string-length s2))
      (let ((ht (make-hash)))
        (hash-set! ht "diffs" 0)
        (for ([i (in-range (string-length s1))])
             (unless (equal? (string-ref s1 i) (string-ref s2 i))
               (hash-set! ht "diffs" (+ (hash-ref ht "diffs") 1))))
        (hash-ref ht "diffs"))
      2))

(define (common-part s1 s2)
  (for ([i (in-range (string-length s1))])
       (unless (not (equal? (string-ref s1 i) (string-ref s2 i)))
         (printf "~a" (string-ref s1 i))))
  (printf "\n"))

(define (find-boxes)
  ;Find two strings who differ only by one character
  (let ((all-lines (file->lines "day2input.txt")))
    (define (check-lines this-line other-lines)
      (for ([other-line other-lines])
           (unless (not (equal? 1 (compare-strings this-line other-line)))
             (common-part this-line other-line)))
      (unless (empty? (rest other-lines))
      (check-lines (first other-lines) (rest other-lines))))
    (unless (empty? (rest all-lines))
      (check-lines (first all-lines) (rest all-lines)))))


(find-boxes)
