;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Constantin Rohde"
      user-mail-address "rohdeconstantin@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-nord)
(setq doom-theme 'doom-wilmersdorf)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(tool-bar-mode -1)
;;(scroll-bar-mode -1)
(customize-set-variable 'scroll-bar-mode nil)
(menu-bar-mode -1)
;;(set-frame-font "Hack 12" nil t)
(setq default-frame-alist '((font . "Hack 12")))

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(beacon-mode 1)

(windmove-default-keybindings 'meta)

;;(require 'smex)
;;(global-set-key (kbd "M-x") 'smex)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq org-roam-directory (file-truename "~/org/org-roam"))
;;(org-roam-db-autosync-mode)

(setq haskell-stylish-on-save t)
(require 'go-complete)
(add-hook 'completion-at-point-functions 'go-complete-at-point)

;;(global-company-mode t)

(global-set-key (kbd "C-x M-z") 'writeroom-mode)

;; multiple cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;; academic tool stuff
(load "~/.config/doom/academic.el")

;; custom packages
(load "~/.config/doom/monde.el")
(global-set-key (kbd "M-o") 'monde-open-kill-ring-buffer)

(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

;;(global-set-key "\C-co" 'switch-to-minibuffer) ;; Bind to `C-c o'

;;(after! cider
;;  (set-popup-rules!
;;   '(("^\\*cider-repl"
;;      :side right
;;      :width 50
;;      :quit nil
;;      :ttl nil))))
;;(setq geiser-repl-skip-version-check-p 't)
;;(setq geiser-guile-binary "/usr/bin/guile")

;;(after! rustic
;;(setq rustic-lsp-server 'rls))
;;(after! lsp-rust
;;  (setq lsp-rust-server 'rust-analyzer))

(after! lsp-ui
  (setq lsp-ui-doc-enable t))


(use-package! zig-mode
  :hook ((zig-mode . lsp-deferred))
  :custom (zig-format-on-save nil)
  :config
  (after! lsp-mode
    (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
    (lsp-register-client
     (make-lsp-client
      :new-connection (lsp-stdio-connection "~/zig/zls/bin/zls")
      :major-modes '(zig-mode)
      :server-id 'zls))))

(use-package! ellama
  :init
  (setopt ellama-language "German")
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama
	   :chat-model "llama2")))
