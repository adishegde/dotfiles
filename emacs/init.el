; Disable tool bar
(tool-bar-mode -1)

; Disable scroll bar
(toggle-scroll-bar -1) 

; Enable auto revert mode
(global-auto-revert-mode)

; Follow symlinks
(setq vc-follow-symlinks t)

; Import package.el and add melpa to package list
(setq use-package-always-ensure t) ; All packages should be installed by default
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

; Installing use-package to make package management easier and efficient
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

; Import use-package
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

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

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

(use-package htmlize)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (evil-leader/set-key
    "en" 'flycheck-next-error
    "ep" 'flycheck-previous-error))

; Add icon support
(use-package all-the-icons)

; Easy setup for vim like leader mappings
(use-package evil-leader
  :init
  (setq evil-want-integration nil) ; Required by evil-collection, assigned here since this is loaded before evil
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "bb" 'helm-buffers-list
    "bd" 'kill-this-buffer
    "t" 'helm-semantic-or-imenu
    "ff" 'helm-find-files
    "rr" 'ranger
    "wl" 'evil-window-right
    "wh" 'evil-window-left
    "wk" 'evil-window-up
    "wj" 'evil-window-down)
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
  :after evil
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
  (setq evil-search-module 'evil-search
        evil-insert-state-cursor '('nil bar)
        evil-emacs-state-modes nil ; Don't start in emacs state anywhere
        evil-motion-state-modes nil) ; Don't start in motion state anywhere

  (add-hook 'prog-mode-hook #'hs-minor-mode) ; Folding
        
  :config
  (evil-mode 1))

; Dependencies for org-evil
(use-package evil-org
  :after org evil

  :init
  (setq org-agenda-files '("~/org")) ; Use org files in ~/org for agenda creation

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  (evil-leader/set-key-for-mode 'org-mode "tt" 'org-todo)) ; Add shortcut to add new todo

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
  (define-key company-active-map [return] 'company-complete)
  (global-company-mode))

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

(use-package tablist)

; Pdf-tools
(use-package pdf-tools
  :after tablist
  :init
  (setenv "PKG_CONFIG_PATH" "/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig"))

; Make evil work normally in various modes
(use-package evil-collection
  :after evil

  :init
  (setq evil-collection-company-use-tng nil)

  :config
  (evil-collection-init))

; Ligature support via Fira Code Symbol
;; This works when using emacs --daemon + emacsclient
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
;; This works when using emacs without server/client
(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
;; I haven't found one statement that makes both of the above situations work, so I use both for now

(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
            `(,(car regex-char-pair)
              (0 (prog1 ()
                   (compose-region (match-beginning 1)
                                   (match-end 1)
                                   ;; The first argument to concat is a string containing a literal tab
                                   ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
          '(("\\(www\\)"                   #Xe100)
            ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
            ("\\(\\*\\*\\*\\)"             #Xe102)
            ("\\(\\*\\*/\\)"               #Xe103)
            ("\\(\\*>\\)"                  #Xe104)
            ("[^*]\\(\\*/\\)"              #Xe105)
            ("\\(\\\\\\\\\\)"              #Xe106)
            ("\\(\\\\\\\\\\\\\\)"          #Xe107)
            ("\\({-\\)"                    #Xe108)
            ("\\(\\[\\]\\)"                #Xe109)
            ("\\(::\\)"                    #Xe10a)
            ("\\(:::\\)"                   #Xe10b)
            ("[^=]\\(:=\\)"                #Xe10c)
            ("\\(!!\\)"                    #Xe10d)
            ("\\(!=\\)"                    #Xe10e)
            ("\\(!==\\)"                   #Xe10f)
            ("\\(-}\\)"                    #Xe110)
            ("\\(--\\)"                    #Xe111)
            ("\\(---\\)"                   #Xe112)
            ("\\(-->\\)"                   #Xe113)
            ("[^-]\\(->\\)"                #Xe114)
            ("\\(->>\\)"                   #Xe115)
            ("\\(-<\\)"                    #Xe116)
            ("\\(-<<\\)"                   #Xe117)
            ("\\(-~\\)"                    #Xe118)
            ("\\(#{\\)"                    #Xe119)
            ("\\(#\\[\\)"                  #Xe11a)
            ("\\(##\\)"                    #Xe11b)
            ("\\(###\\)"                   #Xe11c)
            ("\\(####\\)"                  #Xe11d)
            ("\\(#(\\)"                    #Xe11e)
            ("\\(#\\?\\)"                  #Xe11f)
            ("\\(#_\\)"                    #Xe120)
            ("\\(#_(\\)"                   #Xe121)
            ("\\(\\.-\\)"                  #Xe122)
            ("\\(\\.=\\)"                  #Xe123)
            ("\\(\\.\\.\\)"                #Xe124)
            ("\\(\\.\\.<\\)"               #Xe125)
            ("\\(\\.\\.\\.\\)"             #Xe126)
            ("\\(\\?=\\)"                  #Xe127)
            ("\\(\\?\\?\\)"                #Xe128)
            ("\\(;;\\)"                    #Xe129)
            ("\\(/\\*\\)"                  #Xe12a)
            ("\\(/\\*\\*\\)"               #Xe12b)
            ("\\(/=\\)"                    #Xe12c)
            ("\\(/==\\)"                   #Xe12d)
            ("\\(/>\\)"                    #Xe12e)
            ("\\(//\\)"                    #Xe12f)
            ("\\(///\\)"                   #Xe130)
            ("\\(&&\\)"                    #Xe131)
            ("\\(||\\)"                    #Xe132)
            ("\\(||=\\)"                   #Xe133)
            ("[^|]\\(|=\\)"                #Xe134)
            ("\\(|>\\)"                    #Xe135)
            ("\\(\\^=\\)"                  #Xe136)
            ("\\(\\$>\\)"                  #Xe137)
            ("\\(\\+\\+\\)"                #Xe138)
            ("\\(\\+\\+\\+\\)"             #Xe139)
            ("\\(\\+>\\)"                  #Xe13a)
            ("\\(=:=\\)"                   #Xe13b)
            ("[^!/]\\(==\\)[^>]"           #Xe13c)
            ("\\(===\\)"                   #Xe13d)
            ("\\(==>\\)"                   #Xe13e)
            ("[^=]\\(=>\\)"                #Xe13f)
            ("\\(=>>\\)"                   #Xe140)
            ("\\(<=\\)"                    #Xe141)
            ("\\(=<<\\)"                   #Xe142)
            ("\\(=/=\\)"                   #Xe143)
            ("\\(>-\\)"                    #Xe144)
            ("\\(>=\\)"                    #Xe145)
            ("\\(>=>\\)"                   #Xe146)
            ("[^-=]\\(>>\\)"               #Xe147)
            ("\\(>>-\\)"                   #Xe148)
            ("\\(>>=\\)"                   #Xe149)
            ("\\(>>>\\)"                   #Xe14a)
            ("\\(<\\*\\)"                  #Xe14b)
            ("\\(<\\*>\\)"                 #Xe14c)
            ("\\(<|\\)"                    #Xe14d)
            ("\\(<|>\\)"                   #Xe14e)
            ("\\(<\\$\\)"                  #Xe14f)
            ("\\(<\\$>\\)"                 #Xe150)
            ("\\(<!--\\)"                  #Xe151)
            ("\\(<-\\)"                    #Xe152)
            ("\\(<--\\)"                   #Xe153)
            ("\\(<->\\)"                   #Xe154)
            ("\\(<\\+\\)"                  #Xe155)
            ("\\(<\\+>\\)"                 #Xe156)
            ("\\(<=\\)"                    #Xe157)
            ("\\(<==\\)"                   #Xe158)
            ("\\(<=>\\)"                   #Xe159)
            ("\\(<=<\\)"                   #Xe15a)
            ("\\(<>\\)"                    #Xe15b)
            ("[^-=]\\(<<\\)"               #Xe15c)
            ("\\(<<-\\)"                   #Xe15d)
            ("\\(<<=\\)"                   #Xe15e)
            ("\\(<<<\\)"                   #Xe15f)
            ("\\(<~\\)"                    #Xe160)
            ("\\(<~~\\)"                   #Xe161)
            ("\\(</\\)"                    #Xe162)
            ("\\(</>\\)"                   #Xe163)
            ("\\(~@\\)"                    #Xe164)
            ("\\(~-\\)"                    #Xe165)
            ("\\(~=\\)"                    #Xe166)
            ("\\(~>\\)"                    #Xe167)
            ("[^<]\\(~~\\)"                #Xe168)
            ("\\(~~>\\)"                   #Xe169)
            ("\\(%%\\)"                    #Xe16a)
           ;; ("\\(x\\)"                   #Xe16b) This ended up being hard to do properly so i'm leaving it out.
            ("[^:=]\\(:\\)[^:=]"           #Xe16c)
            ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
            ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  "Add fira code symbols."
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

(add-hook 'prog-mode-hook
          #'add-fira-code-symbol-keywords)

; Set ghostscript path for doc-view
(setq doc-view-ghostscript-program "/usr/local/bin/gs")
