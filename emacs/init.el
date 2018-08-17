; Import package.el and add melpa to package list
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(setq use-package-always-ensure t) ; All packages should be installed by default

; Installing use-package to make package management easier and efficient
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

; Use custom.el for customize settings
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

; Use option as option key
(setq mac-option-key-is-meta nil
	mac-command-key-is-meta t
	mac-command-modifier 'meta
	mac-option-modifier nil)

; Display line numbers
(global-display-line-numbers-mode)

; Scroll options to mimic Vim
(setq scroll-margin 7 ; Start scrolling when 8 lines away from edges
      scroll-step 1
      scroll-conservatively 10000)

; Settings for backups
(setq version-control t     ;; Use version numbers for backups.
      backup-directory-alist `(("." . "~/.emacs.d/backups/"))
      kept-new-versions 5  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t  ;; Copy all files, don't rename them.
      auto-save-file-name-transforms `((".*" "~/.emacs.d/autosaves/")))

; Themes
(use-package gruvbox-theme)
(use-package atom-one-dark-theme)

; Add icon support
(use-package all-the-icons)

; Easy setup for vim like leader mappings
(use-package evil-leader
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "bb" 'helm-buffers-list
    "bd" 'kill-this-buffer
    "t" 'helm-semantic-or-imenu
    "ff" 'helm-find-files
    "rr" 'ranger)
  (global-evil-leader-mode))
  
; Indent guides support
(use-package highlight-indent-guides
  :init
  (setq highlight-indent-guides-method 'character)
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))
  
; Support for text surround
; Add new surround pairs to "evil-surround-pairs-alist", can be added based on hook
; Add new operator pairs to "evil-surround-operator-alist"
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

; Fuzzy search and completion framework
(use-package helm
  :config
  (helm-mode 1)
  (setq helm-autoresize-mode t)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark))

; Easy project management
(use-package projectile
  :config
  (projectile-mode +1))
(use-package helm-ag)

; Helm support for projectile
(use-package helm-projectile
  :after projectile
  :config
  (helm-projectile-on)
  (evil-leader/set-key
    "ps" 'helm-projectile-ag
    "pf" 'helm-projectile-find-file
    "pp" 'helm-projectile-switch-project
  ))

; Use evil-mode, obviously
(use-package evil
  :after evil-leader ; Ensures that evil-leader works in all buffers
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-insert-state-cursor '('nil bar))
  (setq evil-emacs-state-modes nil) ; Don't start in emacs state anywhere
  (setq evil-motion-state-modes nil) ; Don't start in motion state anywhere

  :config
  (evil-mode 1))

; Dependencies for org-evil
(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

; Org mode setup
(evil-leader/set-key-for-mode 'org-mode "tt" 'org-todo) ; Add shortcut to add new todo
(evil-leader/set-key-for-mode 'org-mode "od" 'org-deadline) ; Add shortcut org deadline
(evil-leader/set-key-for-mode 'org-mode "os" 'org-schedule) ; Add shortcut to org schedule
(setq org-agenda-files '("~/org")) ; Use org files in ~/org for agenda creation

; Use spaceline to beautify mode-line
(use-package spaceline
  :config
  (spaceline-spacemacs-theme)
  (spaceline-helm-mode))

; Icon support for spaceline
(use-package spaceline-all-the-icons 
  :after spaceline
  :init
  (setq spaceline-all-the-icons-separator-type 'none)
  :config (spaceline-all-the-icons-theme))

; Autocomplete support
(use-package company
  :init
  (setq company-idle-delay 0.2
	company-selection-wrap-around t
	company-require-match 'never)

  :config
  (global-company-mode)
  (define-key company-active-map [return] 'company-complete)
  (define-key company-active-map [tab] 'company-select-next))

; Doc popup for company autocomplete
(use-package pos-tip) ; Install latest for company-quickhelp
(use-package company-quickhelp
  :after company
  :config
  (company-quickhelp-mode))

; Matching pairs support for evil
(use-package smartparens
  :config
  (smartparens-global-mode))
(use-package evil-smartparens
  :config
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

; Automatically detect and set indentation
(use-package dtrt-indent
  :config
  (dtrt-indent-global-mode))

; Parse file to browse fast
(semantic-mode)

; Set PATH so that Emacs finds the correct executables
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

; Currently use to map 'jk' to ESC
(use-package key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define evil-normal-state-map "jk" 'evil-force-normal-state)
  (key-chord-define evil-visual-state-map "jk" 'evil-change-to-previous-state)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-replace-state-map "jk" 'evil-normal-state))

(use-package ranger
  :init
  (setq ranger-cleanup-on-disable t))
