(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-name-width 40)
 '(column-number-mode t)
 '(nxml-child-indent 4)
 '(nxml-slash-auto-complete-flag t)
 '(py-load-pymacs-p nil)
 '(pymacs-python-command "c:/Python27/python.exe")
 '(python-shell-interpreter "c:/Python27/Scripts/ipython.exe")
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(slime-backend "/usr/share/common-lisp/source/swank/swank-loader.lisp")
 '(tool-bar-mode nil)
 '(w32-get-true-file-attributes nil t))

;; markdown mode
(add-to-list 'load-path "~/.emacs.d/els")
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; wml mode
;(add-to-list 'load-path "~/.emacs.d/wesnoth-mode")
;(autoload 'wesnoth-mode "wesnoth-mode" "WML Major Mode" t)
;(add-to-list 'auto-mode-alist '("\\.cfg\\'" . wesnoth-mode))

;; lua mode
(add-to-list 'load-path "~/.emacs.d/els")
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; cmake mode
(autoload 'cmake-mode "cmake-mode" "cmake editing mode." t)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))

;; use c-mode for mel
(add-to-list 'auto-mode-alist '("\\.mel$" . c-mode))

;; use tcl-mode for nuke gizmos
(add-to-list 'auto-mode-alist '("\\.gizmo$" . tcl-mode))

;; use python-mode for pyw
(add-to-list 'auto-mode-alist '("\\.pyw$" . python-mode))

;; K&R are _right_ :)
(setq c-default-style "k&r"
          c-basic-offset 8)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; turn on awesomeization
(ido-mode t)
(setq ido-auto-merge-work-directories-length -1)
(semantic-mode t)
(global-semantic-stickyfunc-mode t)

;; package-archives
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; color theme
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-20080305.34")
(require 'color-theme)
(color-theme-initialize)
(load "~/.emacs.d/els/color-theme-molokai.el")
(color-theme-hober)

;; autocomplete
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; folding
(load "~/.emacs.d/els/jfold-mode-1.0.0.el")
(require 'jfold-mode)

;; tune some stuff
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq-default inhibit-startup-message t)
(defvar backup-dir (concat (user-login-name) "/tmp/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; tune the mouse wheel
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;;
(setq mouse-autoselect-window nil)

;; as opposed to M-g M-g
(global-set-key (kbd "M-g") 'goto-line)

;; so the title is vivisble even with many windows in a windowbar
(setq frame-title-format
  '("" "%b"))

;; no tool bar
(tool-bar-mode -1)

;; start with one window in a frame
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)

;; uniquify buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; remember minibuffer history
(savehist-mode 1)

;; slime
;(setq inferior-lisp-program "/usr/bin/clisp")
;(add-to-list 'load-path "~/code/lisp/slime")
;(require 'slime)
;(slime-setup '(slime-fancy))

(put 'upcase-region 'disabled nil)

(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; ropemacs
(defun load-ropemacs()
  (interactive)
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  (setq ropemacs-confirm-saving 'nil)
  )

(global-set-key (kbd "C-x p l") 'load-ropemacs)

;; smex
;;(global-set-key (kbd "M-x") 'smex)
;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;(add-to-list 'load-path
;		"~/.emacs.d/plugins/pde/lisp")
;	(load "pde-load")

; comment/uncomment region
(global-set-key [?\C-c ?\C-c] 'comment-region)
(global-set-key [?\C-c ?\C-u] 'uncomment-region)

(defun pylint-current-buffer ()
  "runs pylint on the current buffer file"
  (interactive)
  (let* (
	 (current-file-name (buffer-file-name))
	 (cmdStr (concat "C:/Python27/Scripts/pylint.bat" " " "--rcfile=C:/Users/Sebastian/.pylintrc" " " "\"" current-file-name "\""))
	 )

    (shell-command cmdStr "*pylint output*")
    ))
(global-set-key '[f5] 'pylint-current-buffer)

(add-to-list 'load-path "~/.emacs.d/elpa")
(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)

;;(add-to-list 'load-path "~/.emacs.d/elpa/anything-20130605.1746")
;;(require 'anything) (require 'anything-ipython)
;;(when (require 'anything-show-completion nil t)
;;  (use-anything-show-completion 'anything-ipython-complete
;;				'(length initial-pattern)))


(defun quote-region (rStart rEnd quote-chars )
  "quotes current region with quote-char"
  (interactive
   (let ((string (read-string "Quote with: " nil 'quote-region-history)))
     (list (region-beginning) (region-end) string)))
  (if (eq quote-chars nil) (setq quote-chars "\"\""))
  (setq quote-chars (mapcar 'char-to-string (string-to-list quote-chars)))
  (save-restriction
    (narrow-to-region rStart rEnd)
    (goto-char rStart)     (insert (nth 0 quote-chars))
    (goto-char (+ rEnd 1)) (insert (nth 1 quote-chars))
    (set-mark rStart)
    (move-to-column rEnd)
    (setq deactivate-mark nil)
    )
  )

;; like C-j in vim
(defun kill-whitespace ()
  "Kill the whitespace between two non-whitespace characters"
  (interactive "*")
  (save-excursion
    (save-restriction
      (save-match-data
	(progn
	  (re-search-backward "[^ \t\r\n]" nil t)
	  (re-search-forward "[ \t\r\n]+" nil t)
	  (replace-match "" nil nil))))))

(global-set-key [?\M-\\] 'kill-whitespace)


(cond
 ((string= system-type "windows-nt")
  (setq default-directory (substitute-in-file-name "$USERPROFILE/workspace")))
)

(add-hook 'python-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;;(add-hook 'python-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-sematic)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))
