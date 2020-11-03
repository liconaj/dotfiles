;; Melpa
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize))

;; Python IDE
(elpy-enable)

;; Autocompletion
(global-company-mode)
(electric-pair-mode 1)

;; Line-numbers
(global-display-line-numbers-mode)

;; Parentesis
(show-paren-mode t)

;; Customize
(load-theme 'material t)
(set-face-attribute 'default nil :font "Victor Mono" :height 100)
(set-face-attribute 'default nil :font "Victor Mono" :height 100)

;; Backups
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; Shell completion
(add-hook 'shell-mode-hook #'company-mode)
(define-key shell-mode-map (kbd "TAB") #'company-manual-begin)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-syntax-check-command "flycheck")
 '(package-selected-packages
   '(dracula-theme afternoon-theme flatland-theme gruvbox-theme spacemacs-theme atom-one-dark-theme material-theme zenburn-theme ayu-theme python-environment flycheck one-themes yasnippet-snippets monokai-theme yasnippet-classic-snippets monokai-pro-theme ido-vertical-mode elpy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Clear Shell
(defun my-clear ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun my-shell-hook ()
  (local-set-key "\C-l" 'my-clear))
(add-hook 'shell-mode-hook 'my-shell-hook)

(defun my-eshell-hook ()
  (local-set-key "\C-l" 'my-clear))
(add-hook 'shell-mode-hook 'my-shell-hook)
