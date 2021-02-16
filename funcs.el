(with-eval-after-load 'calibredb-utils
  (defun spacemacs/calibredb-find-file (&optional candidate)
    "Open file of the selected item.
Optional argument CANDIDATE is the selected item."
    (interactive)
    (unless candidate
      (setq candidate (car (calibredb-find-candidate-at-point))))
    (pop-to-buffer-same-window
     (find-file-noselect (calibredb-getattr candidate :file-path) t)))

  (fset 'calibredb-find-file 'spacemacs/calibredb-find-file))
