#lang racket

(define (sum-lines infile)
    (define (read-next-line infile sum)
        (let ((line (read-line infile 'any)))
         (if (eof-object? line)
          (displayln sum)
          (read-next-line infile (+ sum (string->number line))))))
    (read-next-line infile 0))

(call-with-input-file "day1input.txt" sum-lines)
