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
    '("5a611788d47c1deec31494eb2bb864fde402b32b139fe461312589a9f28835db" default))
 '(package-selected-packages '(modus-themes use-package smart-tab)))
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
