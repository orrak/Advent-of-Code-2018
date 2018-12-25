#lang racket

;Part 1

(define (sum-lines infile)
  (define (read-next-line infile sum)
    (let ((line (read-line infile 'any)))
      (if (eof-object? line)
          (displayln sum)
          (read-next-line infile (+ sum (string->number line))))))
  (read-next-line infile 0))

(call-with-input-file "day1input.txt" sum-lines)

;Part 2
(define (read-lines-to-list infile)
  (define (read-next-line infile lst)
    (let ((line (read-line infile 'any)))
      (if (eof-object? line)
          (reverse lst)
          (read-next-line infile (cons (string->number line) lst)))))
  (read-next-line infile null))

(define freq-changes (call-with-input-file "day1input.txt" read-lines-to-list))
;(define freq-changes (file->list "day1input.txt"))

(define (sum-list l s ht)
  (if (hash-has-key? ht s)
      (cons s #t)
      (let ((num (+ s (first l))) 
            (r (rest l)))
        (hash-set! ht s #t)
        (if (empty? r)
            (cons num #f)
            (sum-list r num ht)))))

(define (find-repeat-freq l s ht)
 (let ((result (sum-list l s ht)))
  (if (cdr result)
   (car result)
   (find-repeat-freq l (car result) ht))))

(find-repeat-freq freq-changes 0 (make-hash))
