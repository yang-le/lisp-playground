(defun succ (n)
    #'(lambda (f x) (funcall f (funcall n f x)))
)

(setf zero (lambda (f x) x))
(setf one (succ zero))
(setf two (succ one))
(setf three (succ two))

(defun add (a b)
    (funcall a #'succ b)
)
(defun mul (a b)
    (funcall a #'(lambda (x) (add x b)) zero)
)
(defun pow (a b)
    (funcall b #'(lambda (x) (mul x a)) one)
)

; a helper func
(defun myfun(x) (+ x 1))

; do some check
(defun number_check ()
    (format t
        "check zero ~A~%check one ~A~%check two ~A~%"
        (funcall zero #'atom '(1 2))
        (funcall one #'atom '(1 2))
        (funcall two #'atom '(1 2))
    )
    (format t
        "2+3=~A~%2*3=~A~%2^3=~A~%"
        (funcall (add two three) #'myfun 0)
        (funcall (mul two three) #'myfun 0)
        (funcall (pow two three) #'myfun 0)
    )    
)

