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

(test "rfl-appendo-0"
      (run* (q) (rfl-appendo '(a b c) '(d e) q) inspecto)
      '((a b c d e)))

(test "rfl-anyo-0"
      (run* (q) (rfl-anyo (== q '())) inspecto)
      '(()))
