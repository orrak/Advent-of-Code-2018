#lang racket

(define in (open-input-file "day1input.txt"))

(define (read-next-line infile sum)
    (let ((line (read-line infile 'any)))
     (if (eof-object? line)
      (displayln sum)
      (read-next-line infile (+ sum (string->number line))))))

(read-next-line in 0)
