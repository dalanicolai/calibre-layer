;;; packages.el --- calibre layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Daniel Laurens Nicolai <dalanicolai@gmail.com>
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
;; added to `calibre-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `calibre/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `calibre/pre-init-PACKAGE' and/or
;;   `calibre/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst calibre-packages
  '((calibredb :location (recipe
                             :fetcher github
                             :repo "dalanicolai/calibredb.el"))))

(defun calibre/init-calibredb ()
  (use-package calibredb
    :defer t
    :init
    (progn
      ;; (add-to-list 'evil-emacs-state-modes 'calibredb-search-mode)
      (setq calibredb-search-entries nil
            calibredb-full-entries nil
            calibredb-images-path nil)
      (setq sql-sqlite-program "/usr/bin/sqlite3"
            ;; calibredb-root-dir "/mnt/4EEDC07F44412A81/Calibrebibliotheek"
            calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)
            calibredb-program "/usr/bin/calibredb"
            calibredb-library-alist '(("/mnt/4EEDC07F44412A81/Calibrebibliotheek"))
            calibredb-id-width 5)
      ;; (spacemacs/declare-prefix "ac" "calibre")
      ;; (spacemacs/set-leader-keys "acc" 'calibredb-find-counsel)
      ;; (spacemacs/set-leader-keys "acs" 'calibredb)
      )
    :config
    (progn
      (evilified-state-evilify-map calibredb-search-mode-map
        :mode calibredb-search-mode
        :eval-after-load calibredb-search
        :bindings
        [mouse-3] #'calibredb-search-mouse
        (kbd "<RET>") #'calibredb-find-file
        "?" 'calibredb-dispatch
        "?" 'calibredb-dispatch
        "a" 'calibredb-add
        "A" 'calibredb-add-dir
        "c" 'calibredb-clone
        "d" 'calibredb-remove
        "J" 'evil-scroll-page-down
        "K" 'evil-scroll-page-up
        "\C-j" 'calibredb-show-next-entry
        "\C-k" 'calibredb-show-previous-entry
        "l" 'calibredb-library-list
        "n" 'calibredb-library-next
        "p" 'calibredb-library-previous
        "s" 'calibredb-set-metadata-dispatch
        "S" 'calibredb-switch-library
        "o" 'calibredb-find-file
        "O" 'calibredb-find-file-other-frame
        "v" 'calibredb-view
        "V" 'calibredb-open-file-with-default-tool
        "." 'calibredb-open-dired
        "b" 'calibredb-catalog-bib-dispatch
        "e" 'calibredb-export-dispatch
        "r" 'calibredb-search-refresh-and-clear-filter
        "R" #'calibredb-search-refresh-or-resume)
        "q" #'calibredb-search-quit
        "m" #'calibredb-mark-and-forward
        "f" #'calibredb-toggle-favorite-at-point
        "x" #'calibredb-toggle-archive-at-point
        "h" #'calibredb-toggle-highlight-at-point
        "u" #'calibredb-unmark-and-forward
        "i" #'calibredb-edit-annotation
        (kbd "<DEL>") #'calibredb-unmark-and-backward
        (kbd "<backtab>") #'calibredb-toggle-view
        (kbd "TAB") #'calibredb-toggle-view-at-point
        "\M-n" #'calibredb-show-next-entry
        "\M-p" #'calibredb-show-previous-entry
        "/" #'calibredb-search-live-filter
        "\M-t" #'calibredb-set-metadata--tags
        "\M-a" #'calibredb-set-metadata--author_sort
        "\M-T" #'calibredb-set-metadata--title
        "\M-c" #'calibredb-set-metadata--comments)))
