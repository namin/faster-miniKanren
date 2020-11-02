(define (rfl-appendo xs ys zs)
  (fresh () (reflecto `(appendo ,xs ,ys, zs))
  (conde
   ((== xs '()) (== ys zs))
   ((fresh (a d r)
      (== xs (cons a d))
      (== zs (cons a r))
      (rfl-appendo d ys r))))))

(test "rfl-appendo-0"
      (run* (q) (rfl-appendo '(a b c) '(d e) q) inspecto)
      '((a b c d e)))
