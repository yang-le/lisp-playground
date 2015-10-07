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

(defun ya_add (a b)
    #'(lambda (f x) (funcall a f (funcall b f x)))
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

