
;;; init-packagg.el --- 代码补全与代码块

;;; Commentary 注解:
;;  { 加载插件->benchmark-init, 启动耗时测量工具 }
;;  { 加载插件->drag-stuff 选中代码块，然后整块的上下移动 }
;;  { 加载插件->ivy,cousel,swiper三个一起 }
;;  { 对C++补全提供了LSP补全支持 }
;;  { 加载插件->centaur-tabs  窗口(buffer)管理}



(use-package restart-emacs)

(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate));;启动耗时测量工具


(use-package drag-stuff
  :bind (("<M-up>" . drag-stuff-up)
	 ("<M-down>" . drag-stuff-down)));;选中代码块，然后整块的上下移动
;;窗口(buffer)管理
(use-package centaur-tabs
  :demand
  :config
  (setq centaur-tabs-style "bar"
	  centaur-tabs-height 32
	  centaur-tabs-set-icons t
	  centaur-tabs-set-modified-marker t
	  centaur-tabs-show-navigation-buttons t
	  centaur-tabs-set-bar 'under
	  x-underline-at-descent-line t)
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t)
  :hook
   (dashboard-mode . centaur-tabs-local-mode)
   (term-mode . centaur-tabs-local-mode)
   (calendar-mode . centaur-tabs-local-mode)
   (org-agenda-mode . centaur-tabs-local-mode)
   (helpful-mode . centaur-tabs-local-mode)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))




;;ivy,cousel,swiper三个一起
(use-package ivy
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
	ivy-initial-inputs-alist nil
	ivy-count-format "%d%d "
	enable-recursive-minibuffers t
	ivy-re-builders-alist '((t . ivy--regex-ignore-order))))


(use-package counsel
  :after (ivy)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))
(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
       		swiper-include-line-number-in-search t))

(provide 'init-package)

