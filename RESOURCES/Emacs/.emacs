;; Melpa installation
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; (require 'freebasic-mode)

(fringe-mode 0)
(load-theme 'zenburn t)

;; (add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(internal-border-width . 0))
;; (add-to-list 'default-frame-alist '(width . 80))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a06658a45f043cd95549d6845454ad1c1d6e24a99271676ae56157619952394a" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" default))
 '(highlight-indent-guides-method 'bitmap)
 '(package-selected-packages
   '(pyenv-mode elpy highlight-indent-guides yasnippet-classic-snippets yasnippet-snippets yasnippet company-shell rainbow-mode color-identifiers-mode highlight-operators virtualenv zenburn-theme gruvbox-theme company-jedi company-anaconda company)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-face-attribute 'default nil :font "Victor Mono SemiBold" :height 110)
(set-face-attribute 'variable-pitch
		    nil
		    :family "Victor Mono")

;; Completion
(add-hook 'after-init-hook 'global-company-mode)

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)


;; Show parentesis
(show-paren-mode t)
(setq tab-width 4)                             ; length of tab is 4 SPC
(setq-default indent-tabs-mode nil)            ; use spaces instead of tabs
(setq python-indent 4)                         ; also specifically for python

;; make electric-pair-mode work on more brackets

(add-hook 'after-init-hook 'electric-pair-mode 1)
(setq electric-pair-pairs
      '((?\` . ?\`))
      )

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

;; Backups
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; Disable gui tools
;; (menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Wrap lines
(global-visual-line-mode)

;; line numbers
;; (global-display-line-numbers-mode)

(smart-mode-line-enable)

(setq sml/theme 'respect)
(setq sml/no-confirm-load-theme t)
;; (set-face-attribute 'mode-line nil
;;		    :box nil)

(setq-default left-margin-width 2 right-margin-width 2)

;; Snippets
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(defun my-highlighter (level responsive display)
  (if (> 1 level)
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))

(setq highlight-indent-guides-highlighter-function 'my-highlighter)

(defun execute-python ()
  "Run a terminal command in an external xterm window."
  (interactive)
  (shell-command (concat "xfce4-terminal -e \"bash -c `python -u '"  buffer-file-name  "';echo;read`\""))
  )

