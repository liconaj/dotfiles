;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Josué Licona Mármol"
      user-mail-address "liconaj215@gmail.com")

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
(setq doom-font (font-spec :family "Victor Mono" :size 15 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "Victor Mono" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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


(setq confirm-kill-emacs nil)
(setq fancy-splash-image "~/.doom.d/logo.png")
(setq frame-title-format "Doom Emacs")

(use-package! treemacs
  :config
  (setq treemacs-width 35)
  (treemacs-resize-icons 16)
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)
  :bind
  (:map global-map
   ("M-0"       . treemacs-select-window)))

;; Default TAB key behavior
(setq-default tab-always-indent t)

;; Default delete pairs behavior
(after! smartparens
  (dolist (brace '("(" "{" "["))
    (sp-pair brace nil :unless '(:rem sp-point-before-word-p sp-point-before-same-p))))

;; Font
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-variable-name-face :slant italic))

;; Buffers
(defun next-code-buffer ()
  (interactive)
  (let (( bread-crumb (buffer-name) ))
    (next-buffer)
    (while
        (and
         (string-match-p "^\*" (buffer-name))
         (not ( equal bread-crumb (buffer-name) )) )
      (next-buffer))))
(global-set-key (kbd "<C-tab>") 'next-code-buffer)


(setq auto-mode-alist (cons '("\\.pro$" . chordpro-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cho$" . chordpro-mode) auto-mode-alist))
(autoload 'chordpro-mode "chordpro-mode")


;;(after! doom-modeline
;;  (doom-modeline-def-modeline 'main
;;    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
;;    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "   ")))

(menu-bar-mode 1)

;; Indent guides
(use-package! highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'bitmap)
  (setq highlight-indent-guides-highlighter-function 'my-highlighter))
(defun my-highlighter (level responsive display)
  (if (> 1 level)
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))

;; Building system
(setq multi-compile-alist '(
                            (ruby-mode . (("DragonRuby run" . "dragonruby ..")))
                            (go-mode . (("Go run" . "go run .")))
                            (lua-mode . (("Love run" . "love .")))
                            (python-mode . (("Python run" . "python %file-name")))
                            (chordpro-mode . (("Compile" . "chordpro %file-name")
                                              ("Compile songbook" . "chordpro *.cho -o songbook.pdf")))
                            ))
(global-set-key [f5] 'multi-compile-run)
;; (defun compile-autoclose (buffer string)
;;   (cond ((string-match "finished" string)
;;          (message "Build maybe succesful: clossing window.")
;;          (run-with-timer 1 nil
;;                          'delete-window
;;                          (get-buffer-window buffer t)))
;;         (
;;          (message "Compilation exited abnormally: %s" string))))
;; (setq compilation-finish-functions 'compile-autoclose)
