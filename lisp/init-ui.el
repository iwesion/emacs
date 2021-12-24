;;; init-UI.el --- 初始化Emacs软件界面

;;; Commentary 注释:
;; { 关闭菜单栏, 工具栏, 滑动条 禁止开机启动界面, 设置默认光标类型 }
;; { 修改了Emacs主题UI }


;;添加主题
;; use variable-pitch fonts for some headings and titles
(setq zenburn-use-variable-pitch t)

;; scale headings in org-mode
(setq zenburn-scale-org-headlines t)

;; scale headings in outline-mode
(setq zenburn-scale-outline-headlines t)

(setq zenburn-override-colors-alist
      '(("zenburn-bg+05" . "#282828")
        ("zenburn-bg+1"  . "#2F2F2F")
        ("zenburn-bg+2"  . "#3F3F3F")
        ("zenburn-bg+3"  . "#4F4F4F")))

(load-theme 'zenburn t)


;;设置状态栏
(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
  (sml/setup))

(provide 'init-ui);;暴露接口名称给外面用
