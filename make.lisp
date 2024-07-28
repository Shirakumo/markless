#|
exec sbcl \
  --noinform \
  --disable-debugger \
  --eval "(ql:quickload '(clip cl-markless-plump) :silent T)" \
  --load "$0" \
  --eval "(cl-user::run)" \
  --quit \
  --end-toplevel-options "${@:1}"
|#

(defvar *here* (make-pathname :name NIL :type NIL
                              :defaults #.(or *load-pathname*
                                              (error "Please simply LOAD this file."))))

(defun file (name type)
  (make-pathname :name name :type type :defaults *here*))

(defclass example (org.shirakumo.markless.plump:plump) ())

(defmethod cl-markless:output-component ((component cl-markless-components:code-block) (target plump-dom:nesting-node) (format example))
  (if (and (string= "markless" (cl-markless-components:language component))
           (find "example" (cl-markless-components:options component) :test #'string=))
      (let ((container (plump-dom:make-element target "div")))
        (setf (plump-dom:attribute container "class") "example")
        (cl-markless:output-component component container 'org.shirakumo.markless.plump:plump)
        (cl-markless:output (cl-markless-components:text component) :target container :format format))
      (call-next-method)))

(clip:define-tag-processor "main" (node)
  (cl-markless:output (file "README" "mess")
                      :target node :format 'example))

(defun run (&key (input (file "template" "ctml"))
                 (output (file "index" "html")))
  (with-open-file (output output :direction :output
                                 :if-exists :supersede)
    (plump:serialize (clip:process input) output)))
