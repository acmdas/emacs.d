;; 20200701
;; 20200704 - uncommented org-roam to see how it works alongside my normal config.
;; 20200709 - moved to the new Debian installation - issues with font and window size resolved.
;; 20200803 - installed elfeed and began configuration - installed use-package - gave up and deleted.

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'exec-path "/usr/bin/sqlite3")
(setq org-roam-directory "~/data/org-roam")
(setq org-directory "~/data/org")

;; configure visual interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq visible-bell 1)

;; configure initial window size - added 20200704 1145
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

;; configuring recentf 20200717 - from masteringemacs.org
(require 'recentf)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; enable recent files mode.
(recentf-mode t)

;; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; configuring package
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; configuring org-mode
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/") t)
(require 'org)
(setq org-startup-truncated nil)
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; Configuring org-capture
(setq org-default-notes-file (concat org-directory "/data/org/inbox.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/data/org/inbox.org" "Tasks")
	 "* TODO [#A]  %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
       ("j" "Journal" entry (file+datetree "~/data/org/inbox.org")
	"* %?\nEntered on %U\n %i\n %a")))

;; configuring org-agenda
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-window-setup (quote current-window))

;; file to save todo items
(setq org-agenda-files (file-expand-wildcards "~/data/org/*.org"))

;; set priority range from A to C with default A
(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?A)

;; set colors for priorities
(setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
			   (?B . (:foreground "LightSteelBlue"))
			   (?C . (:foreground "OliveDrab"))))

;; Configuring org-protocol
(require 'org-protocol)

;; Configuring org-journal
(customize-set-variable 'org-journal-date-prefix "#+TITLE: ")
(customize-set-variable 'org-journal-file-format "%Y-%m-%d.org")
(customize-set-variable 'org-journal-dir "~/data/org/")
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
        ("b" "book
" plain
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
 '(org-agenda-files
   (quote
    ("~/data/org/2020-02-20.org" "~/data/org/2020-02-21.org" "~/data/org/2020-02-22.org" "~/data/org/2020-02-23.org" "~/data/org/2020-02-24.org" "~/data/org/2020-02-25.org" "~/data/org/2020-02-26.org" "~/data/org/2020-02-27.org" "~/data/org/2020-02-28.org" "~/data/org/2020-02-29.org" "~/data/org/2020-03-01.org" "~/data/org/2020-03-02.org" "~/data/org/2020-03-04.org" "~/data/org/2020-03-05.org" "~/data/org/2020-03-06.org" "~/data/org/2020-03-07.org" "~/data/org/2020-03-08.org" "~/data/org/2020-03-09.org" "~/data/org/2020-03-11.org" "~/data/org/2020-03-12.org" "~/data/org/2020-03-15.org" "~/data/org/2020-03-16.org" "~/data/org/2020-03-20.org" "~/data/org/2020-03-21.org" "~/data/org/2020-03-22.org" "~/data/org/2020-03-23.org" "~/data/org/2020-03-27.org" "~/data/org/2020-03-28.org" "~/data/org/2020-03-30.org" "~/data/org/2020-03-31.org" "~/data/org/2020-04-02.org" "~/data/org/2020-04-03.org" "~/data/org/2020-04-05.org" "~/data/org/2020-04-09.org" "~/data/org/2020-04-11.org" "~/data/org/2020-04-18.org" "~/data/org/2020-04-26.org" "~/data/org/2020-04-27.org" "~/data/org/2020-04-28.org" "~/data/org/2020-05-03.org" "~/data/org/2020-05-07.org" "~/data/org/2020-05-08.org" "~/data/org/2020-05-09.org" "~/data/org/2020-05-15.org" "~/data/org/2020-05-16.org" "~/data/org/2020-05-18.org" "~/data/org/2020-05-19.org" "~/data/org/2020-05-20.org" "~/data/org/2020-06-28.org" "~/data/org/2020-06-29.org" "~/data/org/2020-06-30.org" "~/data/org/2020-07-01.org" "~/data/org/2020-07-02.org" "~/data/org/2020-07-03.org" "~/data/org/2020-07-04.org" "~/data/org/2020-07-05.org" "~/data/org/2020-07-06.org" "~/data/org/2020-07-07.org" "~/data/org/2020-07-08.org" "~/data/org/2020-07-09.org" "~/data/org/2020-07-10.org" "~/data/org/2020-07-11.org" "~/data/org/2020-07-12.org" "~/data/org/2020-07-13.org" "~/data/org/2020-07-14.org" "~/data/org/2020-07-15.org" "~/data/org/2020-07-16.org" "~/data/org/2020-07-17.org" "~/data/org/2020-07-18.org" "~/data/org/2020-07-19.org" "~/data/org/2020-07-20.org" "~/data/org/2020-07-21.org" "~/data/org/2020-07-22.org" "~/data/org/2020-07-23.org" "~/data/org/2020-07-24.org" "~/data/org/2020-07-25.org" "~/data/org/emacs_tutorial.org" "~/data/org/emacsnotes.org" "~/data/org/exegesis.org" "~/data/org/inbox.org" "~/data/org/org-mode.org" "~/data/org/tutorial.org")))
 '(package-selected-packages
   (quote
    (use-package elfeed slime org-protocol-jekyll org-journal emacsql-sqlite org-roam markdown-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "gainsboro" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))
