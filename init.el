
;;先设置加载的目标目录到load-path中
(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp")));;

;;把手动操作的操作写入单独的文件，对外部开源的时候，该文件不要被提交到git
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;调用自定义文件（provide ‘xx）
(require 'init-const);;添加常量
(require 'init-keyboard);;修改键盘的组合键

(require 'init-startup);;启动项修改，（关闭启动页）
(require 'init-elpa);;修改镜像
(require 'init-package);;添加package管理工具（各种package）
(require 'init-ui);;修改界面（主题）
(require 'init-projectile);;https://docs.projectile.mx/projectile/installation.html
(require 'init-programming);;添加编程语言
(require 'init-tools);;添加工具类（有道翻译）
(require 'init-documents);;添加加载模式扩展插件
(require 'init-treemacs);;添加文件树
(when (file-exists-p custom-file)
  (load-file custom-file))
