(define (reflecto msg)
  (lambda (st)
    (cond
     ((member (walk* msg (state-S st))
              (walk* (state-X st) (state-S st)))
      (printf "failure because loop detected!\n")
      (fail st))
     (else (state (state-S st) (state-C st) (cons msg (state-X st)))))))

(define inspecto
  (lambda (st)
    (for-each
     (lambda (x)  (printf "~a\n" x))
     (walk* (state-X st) (state-S st)))
    st))
