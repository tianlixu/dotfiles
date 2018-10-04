;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                                Alex Xu                                     ;;
;;                       Jun 1, 2005 - Mar 02, 2018                           ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dos to unix
(defun dos-unix () (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

 (setq mac-option-modifier 'super)
 (setq mac-command-modifier 'meta)

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
       '(try-expand-dabbrev
         try-expand-dabbrev-visible
         try-expand-dabbrev-all-buffers
         try-expand-dabbrev-from-kill
         try-complete-file-name-partially
         try-complete-file-name
         try-expand-all-abbrevs
         try-expand-list
         try-expand-line
         try-complete-lisp-symbol-partially
         try-complete-lisp-symbol))

;; use ansi color in shell-mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq ansi-color-for-comint-mode t)


;; C-v M-v C-l can't interrupt isearch
(setq isearch-allow-scroll t)
(setq isearch-allow-scroll t)
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; wdired
 (require 'wdired)
 (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; use c++ mode for .h and .cpp
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

;;
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing y-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
                          char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c a") 'wy-go-to-char)

;; syntax highlighting
(cond ((fboundp 'global-font-lock-mode)
       ;; turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; maximu colors
       (setq font-lock-maximum-decoration t)))

;; display line and column number
(setq column-number-mode t)
(setq line-number-mode t)
(menu-bar-mode -1)

;; highlight current line
(global-hl-line-mode)

;; highlight marked block
(setq transient-mark-mode t)

;; use 4 blackspaces instead of TAB to indent, when you edit makefile the
;; makefile-mode will convert the TABs to TRUE TABs and highligh it.
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
;;(setq tab-stop-list())
;;(loop for x downfrom 40 to 1 do
;;   (setq tab-stop-list (cons(* x 4) tab-stop-list)))

;; dbx mode
(defun my-dbx-mode-hook()
  (define-key gud-mode-map [f5] 'gud-next)
  (define-key gud-mode-map [f9] 'gud-step)
)
(add-hook 'gud-mode-hook 'my-dbx-mode-hook)

(defun my-c++-mode-hook()
  (c-set-style "stroustrup")
  (setq c-basic-offset 4)
  (setq tab-width 4)
;;  (setq indent-tabs-mode t)
;;  (c-toggle-auto-hungry-state 1)
)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook
    '(lambda ()
       (c-set-style "Stroustrup")))


;; scroll only one line
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000)

;; set default directory "~"
;;(setq default-directory "~")

;; bakup policies
(setq make-backup-files t)
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
;; autobackup file to directory ~/.emacs.d/.backups
(setq backup-directory-alist '(("" . "~/.emacs.d/.backups")))
;; do not backup files
 (setq make-backup-files nil)

;; set cursor type bar not block
;(setq-default cursor-type 'bar)

;; set major mode as text-mode other than fundermental-mode that does nothing
(setq default-major-mode 'text-mode)

(require 'ido)
(ido-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my own key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; function key
(global-set-key [f9] 'view-mode)

;; go to line
(global-set-key [(meta g)] 'goto-line)
;; M-SPC : set mark
(global-set-key (kbd "M-<SPC>") 'set-mark-command)
;;(global-set-key "\C-x\C-b" 'bs-show)    ;; or another key
(global-set-key "\M-1" 'delete-other-windows)
(global-set-key "\M-2" 'split-window-vertically)
(global-set-key "\M-3" 'split-window-horizontally)
(global-set-key "\M-4" 'kill-this-buffer)

(global-set-key "\M-p"  'bs-cycle-previous)
(global-set-key "\M-n"  'bs-cycle-next)
(global-set-key "\M-h"  'backward-kill-word)
(global-set-key "\M-o" 'other-window)

;; original key binding C-x C-b is not friendly, change it to electric-buffer-list
;; the cursor will jump to the Buffer List buffer
;; n, p move crusor upword and downword
;; save buffer
;; D delete buffer
;; Also ibuffer is another choice, try it with M-x ibuffer
(global-set-key "\C-x\C-b" 'electric-buffer-list)

;; kill-this-buffer other than kill-buffer
(global-set-key "\C-xk" 'kill-this-buffer)

;;******************************************************************************
;;    C-c prefix
;;******************************************************************************
;; view mode
(global-set-key "\C-c\C-v" 'view-mode)
;; key stroke like vi
(defun my-view-mode-hook()
  (define-key view-mode-map (kbd "h") 'backward-char)
  (define-key view-mode-map (kbd "k") 'previous-line)
  (define-key view-mode-map (kbd "j") 'next-line)
  (define-key view-mode-map (kbd "l") 'forward-char)
  (define-key view-mode-map (kbd "$") 'end-of-line)
  (define-key view-mode-map (kbd "^") 'beginning-of-line)
  (define-key view-mode-map (kbd "-") 'split-window-vertically)
  (define-key view-mode-map (kbd "|") 'split-window-horizontally)
  (define-key view-mode-map (kbd "o") 'other-window) )
(add-hook 'view-mode-hook 'my-view-mode-hook)

(global-set-key "\C-c\C-f" 'grep-find)
(global-set-key "\C-c\C-o" 'occur)

;; clear whole buffer and save.
(global-set-key "\C-c\C-s" (function (lambda()
                                    (interactive)
                                    (mark-whole-buffer)
                                    (kill-region (point-min)(point-max) )
                                    (save-buffer)
                                    )))


;; C-w and M-w improved
(defun my-kill-ring-save (&optional line)
  "This function is a enhancement of `kill-ring-save', which is normal used
to copy a region.  This function will do exactly as `kill-ring-save' if
there is a region selected when it is called. If there is no region, then do
copy lines as `yy' in vim."
  (interactive "P")
  (unless (or line (and mark-active (not (equal (mark) (point)))))
    (setq line 1))
  (if line
      (let ((beg (line-beginning-position))
            (end (line-end-position)))
        (when (>= line 2)
          (setq end (line-end-position line)))
        (when (<= line -2)
          (setq beg (line-beginning-position (+ line 2))))
        (if (and my-kill-ring-save-include-last-newline
                 (not (= end (point-max))))
            (setq end (1+ end)))
        (kill-ring-save beg end))
    (call-interactively 'kill-ring-save)))
;; set the following var to t if you like a newline to the end of copied text.
(setq my-kill-ring-save-include-last-newline nil)
;; bind it
(global-set-key [?\M-w] 'my-kill-ring-save)

(defun my-kill-region (&optional line)
  "This function is a enhancement of `kill-region', which is normal used to
kill a region to kill-ring.  This function will do exactly as `kill-region'
if there is a region selected when it is called. If there is no region, then
do kill lines as `dd' in vim."
  (interactive "P")
  (unless (or line (and mark-active (not (equal (mark) (point)))))
    (setq line 1))
  (if line
      (let ((beg (line-beginning-position))
            (end (line-end-position)))
        (when (>= line 2)
          (setq end (line-end-position line)))
        (when (<= line -2)
          (setq beg (line-beginning-position (+ line 2))))
        (if (and my-kill-region-include-last-newline
                 (not (= end (point-max))))
            (setq end (1+ end)))
        (kill-region beg end))
    (call-interactively 'kill-region)))
;; set the following var to t if you like a newline in the end of killed text.
(setq my-kill-region-include-last-newline t)
;; bind it
(global-set-key [?\C-w] 'my-kill-region)

;; C-w and M-w improved end here

;; gdb is installed into /usr/local/bin by Homebrew
(setq exec-path (append exec-path '("/usr/local/bin")))


(setq package-enable-at-startup nil)
(package-initialize)

;; publishing org-mode files to HTML
(require 'ox-publish)
;; or #+OPTIONS: ^:nil   in your .org file
;; (setq org-export-with-sub-superscripts nil)
(setq org-use-sub-superscripts '{})
(setq org-export-with-sub-superscripts '{})

(setq org-publish-project-alist
      '(

        ;; ... add all the components here (see below)...
        ("org-notes"
         :base-directory "~/dev/github/tianlixu.github.io/more/org/"
         :base-extension "org"
         :publishing-directory "~/dev/github/tianlixu.github.io/more/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :html-head "<link rel=\"stylesheet\"
             href=\"./css/fb.css\" type=\"text/css\"/>"
         :auto-preamble t
         :author "Alex"
         :email "tianli.xu@gmail.com"
         )

        ("org-static"
         :base-directory "~/dev/github/tianlixu.github.io/more/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|html"
         :publishing-directory "~/dev/github/tianlixu.github.io/more/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org" :components ("org-notes" "org-static"))


        ))
;; save the mouse position after publish instead of moving to the beginning of the buffer
(define-key org-mode-map (kbd "C-c C-p") (function (lambda()
                                                     (interactive)
                                                     (point-to-register 1)
                                                     (org-publish-all)
                                                     (jump-to-register 1))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

; sort directories first, sort by time(newest on the top)
(setq dired-listing-switches "-aBhlt  --group-directories-first")
;; use GNU ls for osx
;; install gls with: brew install coreutils
(when (eq system-type 'darwin)
  (setq insert-directory-program "gls" dired-use-ls-dired t))

; display all long lines with word-wrap enabled
(setq-default word-wrap t)
(setq-default truncate-lines nil)
(setq org-startup-truncated nil)

;; ==================== DICT ==================================
(defun bing-dict ()
  "Search current word in bing dictionary."
  (interactive)
  (save-restriction
    (let (start end)
      (skip-chars-backward "A-Za-z0–9") (setq start (point))
      (skip-chars-forward "A-Za-z0–9") (setq end (point))
      (setq current-word (buffer-substring start end))
;      (eww (concat "http://cn.bing.com/dict/search?q=" current-word))
      (eww (concat "http://www.oxfordlearnersdictionaries.com/us/definition/english/" current-word))
      (if (not (string= (buffer-name) "*eww*"))
          (switch-to-buffer-other-window "*eww*"))
      (hl-line-mode "*eww*")
                                        ;wait for 2 second, because the buffer will refresh soon and it go back to top line.
      (sit-for 2)
      (search-forward current-word nil t 2)
                                        ;mark the word for 1 second
      (end-of-line)
      (set-mark (line-beginning-position))
      (sit-for 1)
      (deactivate-mark)
      ))
  )
(global-set-key (kbd "C-c q") 'bing-dict)

;; elpy for python3
;(package-initialize)
(elpy-enable)
(setq elpy-rpc-python-command "/usr/local/bin/python3")
;; For interactive shell
(setq python-shell-interpreter "/usr/local/bin/python3")
(add-to-list 'python-shell-completion-native-disabled-interpreters "python3")
(setq python-shell-completion-native-enable nil)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))

;; https://github.com/nsf/gocode/tree/master/emacs-company
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-edna exec-path-from-shell flycheck flylisp elpy))))

(set-face-attribute 'default nil :height 165)

;; C-c C-c to save buffer first, so that I don't have to save and then run it
(defun elpy-save-and-run()
  (interactive)
  (save-buffer)
  (elpy-shell-send-region-or-buffer))
(eval-after-load "elpy"
     '(define-key elpy-mode-map (kbd "C-c C-c") 'elpy-save-and-run))

;; end of elpy configuration
