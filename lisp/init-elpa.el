;;更换镜像
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			("org" . "http://mirrors.tuna.tsinghua.edu.cn/elap/org/")))
;;包管理器

(setq package-check-signature nil);;签名不用管

(require 'package)
;;初始化包管理器
(unless package-archive-contents
	(package-refresh-contents))

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

;;
(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-always-demand nil
      use-package-expand-minimally t
      use-package-verbose t)

(require 'use-package)

(provide 'init-elpa)
