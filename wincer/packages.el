;;; packages.el --- wincer layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Wincer <wincer@wincer-pc>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `wincer-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `wincer/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `wincer/pre-init-PACKAGE' and/or
;;   `wincer/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst wincer-packages
  '(youdao-dictionary
    nodejs-repl
    company-irony
    company-irony-c-headers
    irony
    irony-eldoc
    flycheck-irony
    )
  )

(defun wincer/init-youdao-dictionary ()
  (use-package youdao-dictionary
    :init
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
    )
  )
(defun wincer/init-nodejs-repl ()
  (use-package nodejs-repl
    :init
    (spacemacs/set-leader-keys "osi" 'nodejs-repl)
    (spacemacs/set-leader-keys "osb" 'nodejs-repl-send-buffer)
    (spacemacs/set-leader-keys "osr" 'nodejs-repl-send-region)
    (spacemacs/set-leader-keys "osl" 'nodejs-repl-send-line)
    )
  )

(defun wincer/init-irony ()
  (use-package irony
    :defer t
    :commands (irony-mode irony-install-server)
    :init
    (progn
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'c++-mode-hook 'irony-mode))
    :config
    (progn
      (setq irony-user-dir (f-slash (f-join user-home-directory "bin" "irony")))
      (setq irony-server-install-prefix irony-user-dir)
      ;;(setq irony-cdb-search-directory-list "/home/dean/work/gitlab/gitlab.com/mystudy/mongodb/code/simple/")
      (add-hook 'c++-mode-hook (lambda () (setq irony-additional-clang-options '("-std=c++11"))))
      (defun irony/irony-mode-hook ()
        (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
        (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))

      (add-hook 'irony-mode-hook 'irony/irony-mode-hook)
      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))))
;;?
(when (configuration-layer/layer-usedp 'auto-completion)
  (defun wincer/init-company-irony ()
    (use-package company-irony
      :if (configuration-layer/package-usedp 'company)
      :defer t
      :commands company-irony
      :init
      (progn
        (push 'company-irony company-backends-c-mode-common)
        (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands))
      )))

(when (configuration-layer/layer-usedp 'auto-completion)
  (defun wincer/init-company-irony-c-headers ()
    (use-package company-irony-c-headers
      :if (configuration-layer/package-usedp 'company)
      :defer t
      :commands company-irony-c-headers
      :init
      (push 'company-irony-c-headers company-backends-c-mode-common)
      )))
(when (configuration-layer/layer-usedp 'syntax-checking)
  (defun wincer/init-flycheck-irony ()
    (use-package flycheck-irony
      :if (configuration-layer/package-usedp 'flycheck)
      :defer t
      :init (add-hook 'irony-mode-hook 'flycheck-irony-setup))))
(defun wincer/init-irony-eldoc ()
  (use-package irony-eldoc
    :commands (irony-eldoc)
    :init
    (add-hook 'irony-mode-hook 'irony-eldoc)))
;;; packages.el ends here
