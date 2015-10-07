;;; 0 -> λf.λx.x
(defun zero (f)
    #'(lambda (x) x)
)

;;; succ -> λn.λf.λx.(f (nf x))
(defun succ (n)
    #'(lambda (f)
        #'(lambda (x) (funcall f (funcall (funcall n f) x)))
    )
)

;;;
;1 -> succ(0)
;2 -> succ(1)
;3 -> succ(2)
;;;
(defun one (f) (funcall (succ #'zero) f))
(defun two (f) (funcall (succ #'one) f))
(defun three (f) (funcall (succ #'two) f))

;;; + -> λmn.λf.λx.(mf (nf x))
(defun add (m n)
    #'(lambda (f)
        #'(lambda (x) (funcall (funcall m f) (funcall (funcall n f) x)))
    )
)

;;; x -> λmn.λf.λx.((m nf) x)
(defun mul (m n)
    #'(lambda (f)
        #'(lambda (x) (funcall (funcall m (funcall n f)) x))
    )
)

;;; ^ -> λmn.λf.λx.((nm f) x)
(defun pow (m n)
    #'(lambda (f)
        #'(lambda (x) (funcall (funcall (funcall n m) f) x))
    )
)

;;; + -> λab.λf.λx.((((a succ) b) f) x)
(defun ya_add (a b)
    #'(lambda (f)
        #'(lambda (x)
		(funcall (funcall (funcall (funcall a #'succ) b) f) x)
	)
    )
)

;;; x -> λab.λf.λx.((((a +b) 0) f) x)
(defun ya_mul (a b)
    #'(lambda (f)
        #'(lambda (x)
		(let ((add_b #'(lambda (z) (ya_add b z))))
		(funcall (funcall (funcall (funcall a add_b) #'zero) f) x))
	)
    )
)

;;; ^ -> λab.λf.λx.((((b *a) 1) f) x)
(defun ya_pow (a b)
    #'(lambda (f)
        #'(lambda (x)
                (let ((mul_a #'(lambda (z) (ya_mul a z))))
                (funcall (funcall (funcall (funcall b mul_a) #'one) f) x))
        )
    )
)

; a helper func
(defun myfun(x) (+ x 1))

; do some check
; main
(format t
    "check zero ~A~%check one ~A~%check two ~A~%"
    (funcall (zero #'atom) '(1 2))
    (funcall (one #'atom) '(1 2))
    (funcall (two #'atom) '(1 2))
)
(format t
    "2+3=~A~%2*3=~A~%2^3=~A~%"
    (funcall (funcall (add #'two #'three) #'myfun) 0)
    (funcall (funcall (mul #'two #'three) #'myfun) 0)
    (funcall (funcall (pow #'two #'three) #'myfun) 0)
)

(format t
    "2+3=~A~%2*3=~A~%2^3=~A~%"
    (funcall (funcall (ya_add #'two #'three) #'myfun) 0)
    (funcall (funcall (ya_mul #'two #'three) #'myfun) 0)
    (funcall (funcall (ya_pow #'two #'three) #'myfun) 0)
)

