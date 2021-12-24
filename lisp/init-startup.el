
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))     
(prefer-coding-system        'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(setq-default buffer-file-coding-system 'utf-8);;设置系统的编码，避免各处的乱码

(setq gc-cons-threshold most-positive-fixnum);;设置垃圾回收阈值，加速启动速度



(tool-bar-mode -1);;关闭toolbar
(scroll-bar-mode -1);;关闭scrollbar
(menu-bar-mode -1);;关闭菜单栏

;;禁止启动文件
(setq inhibit-startup-screen t)

(setq make-backup-files nil);;关闭备份的文件（带~的文件）


(provide 'init-startup);;暴露接口名称给外部调用这个文件
