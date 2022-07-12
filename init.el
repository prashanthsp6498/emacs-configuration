(setenv "BASH_ENV" "$HOME/.bashrc")

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))


(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(custom-safe-themes
   '("a0415d8fc6aeec455376f0cbcc1bee5f8c408295d1c2b9a1336db6947b89dd98" "5a611788d47c1deec31494eb2bb864fde402b32b139fe461312589a9f28835db" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(go-mode company which-key flycheck pyvenv python-mode lsp-mode modus-themes use-package smart-tab)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Custom Configurations (Append below)

(setq inhibit-startup-message t)

;; Menu and tool bar configuratin
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

;; Basic text editor configuration
(global-linum-mode 1)
(global-visual-line-mode t)

;; Org mode configuration
(setq org-startup-indented t)

;; modus theme configuration

(setq modus-themes-italic-constructs t
    modus-themes-bold-constructs t
    modus-themes-paren-match '(bold intense)
    modus-themes-mode-line '(accented borderless padded)
    modus-themes-syntax '(alt-syntax faint)
    modus-themes-region '(bg-only))
    
(load-theme 'modus-vivendi)

;; Evil mode configuration
(use-package evil
  :ensure t
  :init
  (setq evil-want-itegration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)

  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Use visual line motions even outside of visual-line-mode buffer
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))



(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; lsp-mode for python
(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
	      ("C-c l" . lsp-command-map)
              ("C-c d" . lsp-describe-thing-at-point)
	      ("C-c a" . lsp-execute-code-action))
  :config
  (lsp-enable-which-key-integration t))


;; company-mode configuration
(use-package company
  :ensure t
  :hook ((emacs-lisp-mode . (lambda ()
			      (setq-local company-backends '(company-elisp))))
	 (emacs-lisp-mode . company-mode))
  :config
  (company-keymap--unbind-quick-access company-active-map)
  (company-tng-configure-default)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))


;; Go-mode configuration

(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mode . company-mode))
  :bind (:map go-mode-map
	      ("<f6>" . gofmt)
	      ("C-c 6" . gofmt))
  :config
  (require 'lsp-go)
  (setq lsp-go-analyses
	'((fieldalignment . t)
	  (nilness        . t)
	  (unusedwrite    . t)
	  (unusedparams   . t)))
  (add-to-list 'exec-path "~/go/bin")
  (setq gofmt-command "goimports"))
