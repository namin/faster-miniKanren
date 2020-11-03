(define (rfl-appendo xs ys zs)
  (fresh () (reflecto `(appendo ,xs ,ys, zs))
  (conde
   ((== xs '()) (== ys zs))
   ((fresh (a d r)
      (== xs (cons a d))
      (== zs (cons a r))
      (rfl-appendo d ys r))))))

(define rfl-anyo
  (lambda (g)
    (fresh () (reflecto `(anyo ,g))
    (conde
     (g)
     ((rfl-anyo g))))))

(define rfl-loopanyo
  (lambda (stamp g)
    (fresh () (reflecto `(loopanyo ,stamp ,g))
    (conde
     (g)
     ((fresh (stamp2)
        (rfl-loopanyo stamp2 g)))))))

(define rfl-loopanyo2
  (lambda (stamp g)
    (fresh () (reflecto `(loopanyo2 ,stamp ,g))
    (conde
     (g)
     ((fresh (stamp2)
        (== stamp stamp2)
        (rfl-loopanyo2 stamp2 g)))))))

(test "rfl-appendo-0"
      (run* (q) (rfl-appendo '(a b c) '(d e) q) inspecto)
      '((a b c d e)))

(test "rfl-anyo-0"
      (run* (q) (rfl-anyo (== q '())) inspecto)
      '(()))

(test "rfl-loopanyo-1"
      (run 3 (q) (fresh (x) (rfl-loopanyo x (== q '())) inspecto))
      '(() () ()))

(test "rfl-loopanyo-2"
      (run* (q) (fresh (x) (rfl-loopanyo2 x (== q '())) inspecto))
      '(()))
