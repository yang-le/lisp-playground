;;; true -> λx.λy.x
(defun true (x)
    #'(lambda (y) x)
)

;;; false -> λx.λy.y
(defun false (x)
    #'(lambda (y) y)
)

;;; and -> λpq.(pq false)
(defun and. (p q)
    (funcall (funcall p q) #'false)
)

;;; or -> λpq.((p true) q)
(defun or. (p q)
    (funcall (funcall p #'true) q)
)

;;; not -> λp.((p false) true)
(defun not. (p)
    (funcall (funcall p #'false) #'true)
)

;;; cond -> λpxy.((p x) y)
(defun cond. (p x y)
    (funcall (funcall p x) y)
)

;;; iszero -> λn.((n λx.false) true)
(defun iszero (n)
    (funcall (funcall n #'(lambda (x) #'false)) #'true)
)

; do some check
; main
(format t
    "check true ~A~%check false ~A~%"
    (funcall (true t) nil)
    (funcall (false t) nil)
)
(format t
    "true and true = ~A~%true and false = ~A~%"
    (and. #'true #'true)
    (and. #'true #'false)
)
(format t
    "false or true = ~A~%false or flase = ~A~%"
    (or. #'false #'true)
    (or. #'false #'false)
)
(format t
    "not false = ~A~%not true = ~A~%"
    (not. #'false)
    (not. #'true)
)
(load "number.cl")
(format t
    "0 is zero? ~A~%3 is zero? ~A~%"
    (iszero #'zero)
    (iszero #'three)
)

