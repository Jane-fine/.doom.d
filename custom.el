(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(ox-hugo rime)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'pyim)
;(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
;(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(require 'liberime nil t)
(setq default-input-method "pyim")
(with-eval-after-load "liberime"
  (liberime-try-select-schema "luna_pinyin_simp")
  (setq pyim-default-scheme 'rime-quanpin))
;(require 'popup)

;(let ((liberime-auto-build t))
;  (require 'liberime nil t))
