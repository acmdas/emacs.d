;; 20200701
;; 20200704 - uncommented org-roam to see how it works alongside my normal config.
;; 20200709 - moved to the new Debian installation - issues with font and window size resolved.
;; 20200803 - installed elfeed and began configuration - installed use-package - gave up and deleted.
;; 20200805 - recentf removed. org-agenda-files defined as inbox.org only. sdcv added
;; 20200816 - installed offlineimap, mu and mu4e
;; 20200919 - began using mu4e
;; 20200921-22 - fiddling with smtpmail & etc. to try to get sending working
;; 20201018 - installed elfeed
;; 20201022 - installed mu4e-views
;; 20201025 - commented-out org-roam

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
(setq
 mu4e-sent-folder "/sent"
 mu4e-drafts-folder "/drafts"
 mu4e-trash-folder "/trash"
 mu4e-refile-folder "/archive"
 mu4e-get-mail-command "offlineimap"
 mu4e-update-interval 600
 mail-user-agent 'mu4e-user-agent
 mu4e-html2test-command 'mu4e-shr2text
 mu4e-view-show-images t)

; configuring mu4e-views
(require 'mu4e-views)
(define-key mu4e-headers-mode-map (kbd "v") #'mu4e-views-mu4e-select-view-msg-method)


;; configuring smtpmail
;; as of 2209 0923 still getting "Process smtpmail not running" errors
; (require 'smtpmail)
; (require 'starttls)

; (setq mail-host-address "daslearns.ca")

; (setq message-send-mail-function 'smtpmail-send-it)
; (defun gnutls-available-p ()
;  "Function redefined so as to not use built-in GnuTLS support"
;  nil)
; (setq starttls-gnutls-program "gnutls-cli")
; (setq starttls-use-gnutls t)
; (setq smtpmail-stream-type 'starttls)
; (setq
;  smtpmail-default-smtp-server "mail.daslearns.ca"
;  smtpmail-smtpserver "mail.daslearns.ca"
;  smtpmail-smtp-service 465)

;; configure elfeed
(require 'elfeed)

(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-db-directory "~/data/elfeeddb")

(setq elfeed-feeds
      '(
	("https://consultingsmiths.com/feed/" me)
	;; emacs
	("https://sachachua.com/blog/feed" sachachua)
	("https://www.rousette.org.uk/index.xml" shesagirl)
	("http://irreal.org/blog/?feed=rss2" irreal)
	;; commentary
	("http://assistantvillageidiot.blogspot.com/feeds/posts/default" avi)
	("http://accordingtohoyt.com/feed/" hoyt)
	("http://www.anonymousconservative.com/blog/feed/" anoncons news twitter)
	;; writing
	("http://www.stevenpressfield.com/feed/" pressfield)
	("http://feeds.feedburner.com/typepad/sethsmainblog" godin)
	))

(setq-default elfeed-search-filter "@7-weeks")
; (setq-default elfeed-search-title-max-width 100)
; (setq-default elfeed-search-title-min-width 100)

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
(require 'org-journal)
(setq org-journal-file-type 'monthly)
;; (setq org-journal-date-prefix "#+TITLE: ")
;; (setq org-journal-file-format "%Y-%m.org")
(setq org-journal-dir "~/data/org/journal")
;; (setq org-journal-date-format "%A, %d %B %Y")
;; (global-set-key "\C-cnj" 'org-journal-new-entry)

;; configuring org-roam
;(setq org-roam-directory "~/data/org-roam")
;(add-hook 'after-init-hook 'org-roam-mode)
;(global-set-key (kbd "C-c n r") #'org-roam-buffer-toggle-display)
;(global-set-key (kbd "C-c n i") #'org-roam-insert)
;(global-set-key (kbd "C-c n /") #'org-roam-find-file)

;; org-roam templates
;(setq org-roam-capture-templates
;      '(("d" "default" plain
;         (function org-roam-capture--get-point)
;         "%?"
;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;         :head "#+TITLE: ${title}\n#+CREATED: %U\n#+LAST_MODIFIED: %U\n\n"
;         :unnarrowed t)
;        ("b" "book
;" plain
;         (function org-roam-capture--get-point)
;         "%?"
;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;         :head "#+TITLE: ${title}\nn#+CREATED: %U\n#+LAST_MODIFIED: %U\n\n"
;         :unnarrowed t)))

;; configuring sdcv for using the 1923 Websters Dictionary
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

(require 'whole-line-or-region)
(setq make-backup-files nil)
(setq sentence-end-double-space nil)

;; enable windmove - uses Shift-arrow to move between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Hands off the following:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (mu4e-views elfeed whole-line-or-region magit org-roam recently slime org-protocol-jekyll org-journal emacsql-sqlite markdown-mode)))
 '(smtpmail-smtp-server "daslearns.ca")
 '(smtpmail-smtp-service 465))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "gainsboro" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))
