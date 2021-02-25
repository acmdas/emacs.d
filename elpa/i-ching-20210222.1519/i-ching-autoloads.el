;;; i-ching-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "i-ching" "i-ching.el" (0 0 0 0))
;;; Generated autoloads from i-ching.el

(autoload 'i-ching-describe-hexagram "i-ching" "\
Show the name of a HEXAGRAM (between POINT and MARK) based on it's unicode name.

\(fn POINT MARK)" t nil)

(autoload 'i-ching-cast "i-ching" "\
Cast a Hexagram using a particular METHOD.

There are various methods to divine a specific hexagram.
Depending on the context and circumstance some methods may be more suitable.

see: `i-ching-divination-method' & `i-ching-randomness-source' for details.

\(fn &optional METHOD)" t nil)

(autoload 'i-ching-insert-hexagram "i-ching" "\
Insert a hexagram either by casting or it's NUMBER in the King Wen sequence.

\(fn &optional NUMBER)" t nil)

(autoload 'i-ching-insert-hexagram-and-name "i-ching" "\
Insert a hexagram either by casting or it's NUMBER in the King Wen sequence.

\(fn &optional NUMBER)" t nil)

(autoload 'i-ching-hexagram-and-name-string "i-ching" "\
Return a hexagram either by casting or it's NUMBER in the King Wen sequence.

\(fn &optional NUMBER)" t nil)

(autoload 'i-ching-interpretation "i-ching" "\
Consult the I Ching to show an interpretation of a single HEXAGRAM.
The hexagram can be entered as a string, or by number.

\(fn HEXAGRAM)" t nil)

(autoload 'i-ching-query-string "i-ching" "\
Consult the I Ching using a particular METHOD.

\(fn &optional METHOD)" t nil)

(autoload 'i-ching-query "i-ching" "\
Consult the I Ching using a particular METHOD.

\(fn &optional METHOD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "i-ching" '("i-ching-")))

;;;***

;;;### (autoloads nil nil ("i-ching-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; i-ching-autoloads.el ends here
