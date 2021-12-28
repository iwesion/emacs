;;; init-Programming.el --- 代码补全与代码块

;;; Commentary 注解:
;; { 加载插件->company-mode, 为Emacs添加了代码补全的功能 }
;; { 加载插件->yasnippet 并添加Emacs对代码片断的支持 }
;; { 加载插件->LSP, 为Emacs添加了对LSP(Language server protocol)代码模糊搜索的支持 }
;; { 对C++补全提供了LSP补全支持 }

;;; Code:
;; 配置company-mode代码补全插件的参数, 与绑定快捷键
;; Settings for company
(use-package company
  :ensure t
  :diminish (company-mode " Com.")
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :hook (after-init . global-company-mode)
  ;; 绑定快捷键并让Emacs支持`C-p` `C-n`快捷键来选择补全结果
  :bind
  (:map company-mode-map ("M-/" . 'company-complete))
  (:map company-active-map ("M-/" . 'company-other-backend))
  (:map company-active-map ("C-n" . 'company-select-next))
  (:map company-active-map ("C-p" . 'company-select-previous))
  :config (setq company-dabbrev-code-everywhere t
		        company-dabbrev-code-modes t
		        company-dabbrev-code-other-buffers 'all
		        company-dabbrev-downcase nil
		        company-dabbrev-ignore-case t
		        company-dabbrev-other-buffers 'all
		        company-require-match nil
		        company-minimum-prefix-length 1
		        company-show-numbers t
		        company-tooltip-limit 20
		        company-idle-delay 0
		        company-echo-delay 0
		        company-tooltip-offset-display 'scrollbar
		        company-begin-commands '(self-insert-command)))

(use-package company-quickhelp
  :ensure t
  :hook (prog-mode . company-quickhelp-mode)
  :init (setq company-quickhelp-delay 0.3))

;; Better sorting and filtering
(use-package company-prescient
  :ensure t
  :init (company-prescient-mode 1))



;;; 设置LSP(Language Server Protocol)
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((lsp-mode . lsp-enable-which-key-integration) ;; 添加需要支持的语言到LSP
	 (python-mode . lsp-deferred)                    ;; Add the programming language you use to LSP
         (c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         (java-mode . lsp-deferred)
         (js-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (vue-mode . lsp-deferred)
         (html-mode . lsp-deferred))
  :init (setq lsp-keep-workspace-alive nil ;; 自动关闭LSP服务器 [Auto kill LSP server]
              lsp-enable-indentation t
              lsp-enable-on-type-formatting t
              lsp-auto-guess-root nil
              lsp-enable-snippet t
              lsp-modeline-diagnostics-enable t
              lsp-idle-delay 0.500
              lsp-completion-provider :capf))

;;设置lsp-dart
(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp)
  :init (setq lsp-dart-sdk-dir "/Users/wesion/flutter/bin/cache/dart-sdk"
	      lsp-dart-flutter-sdk-dir "/Users/wesion/flutter"
	      ;;lsp-dart-flutter-executable flutter;;Flutter 可执行文件名称。
	      lsp-dart-enable-sdk-formatter t;;是否启用服务器格式化。
	      lsp-dart-complete-function-calls t;;完成具有所需参数的函数/方法。
	      lsp-dart-outline t;;在服务器 lsp 上启用大纲树视图功能
	      lsp-dart-outline-position-params "Left side";;大纲树位置参数。
	      lsp-dart-closing-labels t;;在服务器 lsp 上启用关闭标签功能
	      lsp-dart-flutter-outline t;;是否开启服务端 lsp 的 Flutter 大纲树视图功能
	      lsp-dart-flutter-fringe-colors t;;在边缘启用 Flutter 颜色。
	      lsp-dart-flutter-outline-position-params "Left side";;Flutter 轮廓树位置参数
	      lsp-dart-flutter-widget-guides t;;启用从父小部件到子小部件的 Flutter 小部件指南
	      lsp-dart-main-code-lens t;;Run\|Debug在主要方法上启用代码镜头。
	      lsp-dart-test-code-lens t;;Run\|Debug在测试中启用代码镜头。
	      lsp-dart-devtools-theme "dart";;通过打开时的 devtools 主题 lsp-dart-dap-open-devtools
	      lsp-dart-devtools-hide-options debugger;;通过以下方式打开 DevTools 时要隐藏的内容 lsp-dart-dap-open-devtools
	      ))


;; Assuming usage with dart-mode
(use-package dart-mode
  :hook
  (dart-mode . flutter-test-mode)
  :custom
  (dart-sdk-path (concat (getenv "HOME") "/flutter/bin/cache/dark-sdk/")
   dart-format-on-save t))
(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :custom
  (flutter-sdk-path "/Users/wesion/flutter/"))

;;添加swift支持
(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))
(use-package swift-mode
  :hook (swift-mode . (lambda () (lsp))));;在lsp每次访问.swift文件时自动启用

;; lsp补全显示数据的UI设置
(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :init (setq lsp-ui-doc-enable t;;启用 lsp-ui-doc
             ;; lsp-ui-doc-use-webkit nil
              lsp-ui-doc-delay .3;;显示文档前的秒数
              lsp-ui-doc-include-signature t
	      lsp-ui-doc-show-with-cursor t;;当非零时，将光标移动到符号上以显示文档
	      lsp-ui-doc-show-with-mouse t;;当非零时，将鼠标指针移动到符号上以显示文档
              lsp-ui-doc-position 'bottom ;;在哪里显示文档 top/bottom/at-point
              lsp-eldoc-enable-hover nil ;; 禁用迷你缓冲区中的eldoc显示器 Disable eldoc displays in minibuffer   
              lsp-ui-sideline-enable t
              lsp-ui-sideline-show-hover t;;在边线中显示悬停消息
              lsp-ui-sideline-show-code-actions t;; 在边线中显示代码操作
              lsp-ui-sideline-show-diagnostics t;;在边线中显示诊断消息
              lsp-ui-sideline-ignore-duplicate t
              lsp-headerline-breadcrumb-enable t)
  :config
  (setq lsp-ui-flycheck-enable nil)
  (treemacs-resize-icons 14))

;; 如果你使用的是helm插件 if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)

;; 如果你使用的是ivy插件 if you are ivy user
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

;;(use-package lsp-treemacs
 ;; :ensure t
 ;; :commands lsp-treemacs-errors-list
;; :init (treemacs-resize-icons 14))
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   t
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))
;;-----

;; 如果你想使用调试器, 可以选择
;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t
  :diminish
  :hook ((lsp-mode . dap-mode)
        (dap-mode . dap-ui-mode)
        (dap-mode . dap-tooltip-mode)
        (python-mode . (lambda() (require 'dap-python)))
        (go-mode . (lambda() (require 'dap-go)))
        (java-mode . (lambda() (require 'dap-java)))))

;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; 可选项: 如果你想哪个密钥集成
;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))


;; 配置yasnippet插件, 为Emacs提供代码片段支持
;; Configure the yasnippet plug-in to provide snippet support for Emacs
(use-package yasnippet
  :ensure t
  :defer t
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (yas-global-mode t))


(provide 'init-programming)
