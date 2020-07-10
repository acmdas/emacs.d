;; 20200701
;; 20200704 - uncommented org-roam to see how it works alongside my normal config.
;; 20200709 - moved to the new Debian installation - issues with font and window size.

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'exec-path "/usr/bin/sqlite3")
(setq org-roam-directory "~/data/org-roam")

;; configure visual interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

;; configure initial window size - added 20200704 1145
;; commented out 0709 to redo visual customization
 (setq initial-frame-alist
      '(
	(width . 102) ; character
	(height . 55) ; lines
	))
(setq default-frame-alist
      '(
	(width . 102) ; character
	(height . 55) ; lines
	))

;; configuring package
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; configuring org-mode
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/") t)
(require 'org)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; Configuring org-journal
(customize-set-variable 'org-journal-date-prefix "#+TITLE: ")
(customize-set-variable 'org-journal-file-format "%Y-%m-%d.org")
(customize-set-variable 'org-journal-dir "~/data/davids/journal/")
(customize-set-variable 'org-journal-date-format "%A, %d %B %Y")
(global-set-key "\C-cnj" 'org-journal-new-entry)

;; configuring org-roam
(add-hook 'after-init-hook 'org-roam-mode)
(global-set-key (kbd "C-c n r") #'org-roam-buffer-toggle-display)
(global-set-key (kbd "C-c n i") #'org-roam-insert)
(global-set-key (kbd "C-c n /") #'org-roam-find-file)
;; org-roam templates
(setq org-roam-capture-templates
      '(("d" "default" plain
         (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+TITLE: ${title}\n#+CREATED: %U\n#+LAST_MODIFIED: %U\n\n"
         :unnarrowed t)
        ("D" "default copy" plain
         (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+TITLE: ${title}\nn#+CREATED: %U\n#+LAST_MODIFIED: %U\n\n"
         :unnarrowed t)))

;; configure markdown
(require 'typopunct)
(typopunct-change-language 'english t)
(add-hook 'markdown-mode-hook 'my-markdown-init)
(defun my-markdown-init ()
  (require 'typopunct)
  (typopunct-change-language 'english)

  ;; add more superscripts
(typopunct-mode 1))
(require 'iso-transl)
    (iso-transl-define-keys
     `(("^0" . ,(vector (decode-char 'ucs #x2070)))
       ("^4" . ,(vector (decode-char 'ucs #x2074))) 
       ("^5" . ,(vector (decode-char 'ucs #x2075)))
       ("^6" . ,(vector (decode-char 'ucs #x2076)))
       ("^7" . ,(vector (decode-char 'ucs #x2077)))
       ("^8" . ,(vector (decode-char 'ucs #x2078)))
       ("^9" . ,(vector (decode-char 'ucs #x2079)))
       ("^+" . ,(vector (decode-char 'ucs #x207A)))
       ("^-" . ,(vector (decode-char 'ucs #x207B)))
       ("^=" . ,(vector (decode-char 'ucs #x207C)))
       ("^(" . ,(vector (decode-char 'ucs #x207D)))
       ("^)" . ,(vector (decode-char 'ucs #x207E)))
       ("_0" . ,(vector (decode-char 'ucs #x2080)))
       ("_1" . ,(vector (decode-char 'ucs #x2081)))
       ("_2" . ,(vector (decode-char 'ucs #x2082)))
       ("_3" . ,(vector (decode-char 'ucs #x2083)))
       ("_4" . ,(vector (decode-char 'ucs #x2084)))
       ("_5" . ,(vector (decode-char 'ucs #x2085)))
       ("_6" . ,(vector (decode-char 'ucs #x2086)))
       ("_7" . ,(vector (decode-char 'ucs #x2087)))
       ("_8" . ,(vector (decode-char 'ucs #x2088)))
       ("_9" . ,(vector (decode-char 'ucs #x2089)))
       ("_+" . ,(vector (decode-char 'ucs #x208A)))
       ("_-" . ,(vector (decode-char 'ucs #x208B)))
       ("_=" . ,(vector (decode-char 'ucs #x208C)))
       ("_(" . ,(vector (decode-char 'ucs #x208D)))
       ("_)" . ,(vector (decode-char 'ucs #x208E)))))

;; more stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (org-journal emacsql-sqlite org-roam markdown-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "gainsboro" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))
