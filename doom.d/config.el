(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

(setq doom-theme 'doom-solarized-light)

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook #'lsp-deferred)

(setq max-lisp-eval-depth 100000)
(add-hook! prog-mode #'flymake-mode)
(setq lsp-prefer-flymake nil)
(setq typescript-indent-level 2)
(setq display-line-numbers-type 'relative)
(setq projectile-enable-caching nil)

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(add-hook 'after-init-hook (lambda ()
  (when (fboundp 'auto-dim-other-buffers-mode)
    (auto-dim-other-buffers-mode t))))
(setq lsp-file-watch-threshold 2000)
(setq lsp-clients-typescript-max-ts-server-memory 6144)
