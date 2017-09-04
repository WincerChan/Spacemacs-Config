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
    nodejs-repl)
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
    (spacemacs/set-leader-keys "osl" 'nodejs-repl-send-line)))

;;; packages.el ends here
