;; 20200701
;; 20200704 - uncommented org-roam to see how it works alongside my normal config.
;; 20200709 - moved to the new Debian installation - issues with font and window size resolved.
;; 20200803 - installed elfeed and began configuration - installed use-package - gave up and deleted.
;; 20200805 - recentf removed. org-agenda-files defined as inbox.org only. sdcv added
;; 20200816 - installed offlineimap, mu and mu4e

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'exec-path "/usr/bin/sqlite3")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

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

;; configuring package
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; configuring mu4e
(require 'mu4e)

;; configuring ido-mode
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)

;; configuring org-mode
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/") t)
(require 'org)
(setq org-directory "~/data/org")
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
(setq org-agenda-files "~/data/org/inbox.org")

;; file to save todo items - 20200805 changed from .org to inbox.org
(setq org-agenda-files (file-expand-wildcards "~/data/org/inbox.org"))

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
(customize-set-variable 'org-journal-dir "~/data/org/journal")
(customize-set-variable 'org-journal-date-format "%A, %d %B %Y")
(global-set-key "\C-cnj" 'org-journal-new-entry)

;; configuring org-roam
(setq org-roam-directory "~/data/org-roam")
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

;; configuring sdcv
(require 'sdcv-mode)
(global-set-key (kbd "C-c d") 'sdcv-search)

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

;; configuring recent
(require 'recentf)
(recentf-mode t)
(global-set-key "\C-xf" 'recentf-open-files)
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(setq recentf-max-saved-items 50)

;; more stuff

(setq make-backup-files nil)
(setq sentence-end-double-space nil)

;; enable windmove - uses Shift-arrow to move between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit org-roam recently slime org-protocol-jekyll org-journal emacsql-sqlite markdown-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "gainsboro" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))
