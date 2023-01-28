;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; my private config
;;
;;key-banding form 21 days learning emacs
;; bind app key to super
;(setq w32-apps-modifier 'super)
;;
;(global-set-key (kbd "s-a") 'mark-whole-buffer) ;;对应Windows上面的Ctrl-a 全选
;(global-set-key (kbd "s-c") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
;(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
;(global-set-key (kbd "s-v") 'yank) ;对应Windows上面的Ctrl-v 粘贴
;(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销-;;
;(global-set-key (kbd "s-x") 'kill-region) ;对应Windows上面的Ctrol-x 剪切
;
;; 中英文切换绑定shift
;; pyim-toggle-input-ascii  shift
;?(setq pyim-toggle-input-ascii )

;(map! :leader
;      (:prefix ("a" . "applications")
;       :desc "Export Org to HTML"
;       "e" #'org-html-export-to-html))
;;
;;rime
;;(use-package! rime
;;  :custom
;;  (default-input-method "rime")
;;  (rime-show-candidate 'posframe))
;;(use-package ox-hugo
;;  :ensure t   ;Auto-install the package from Melpa
;;  :pin melpa  ;`package-archives' should already have ("melpa" . "https://melpa.org/packages/")
;;  :after ox)
;;
(require 'pyim)
(require 'liberime nil t)
;;
;; 让选词框跟随光标
(require 'popup) ;使用 popup 包，（emacs overlay 机制）
(setq pyim-page-tooltip 'popup)
;;
;;使用 posframe 来绘制选词框
;;(require 'posframe)
;;(setq pyim-page-tooltip 'posframe)
;;
;;按照优先顺序自动选择一个可用的 tooltip
;;(setq pyim-page-tooltip '(posframe popup minibuffer))
;;总是 minibuffer ?
;;
;;调整 tooltip 选词框的显示样式
(setq pyim-page-style 'one-line)
;;
;;设置模糊音
;;(defcustom  pyim-pinyin-fuzzy-alist
;;       '(("en" "eng")
;;         ("in" "ing")
;;         ("un" "ong"))
;;       :type 'sexp)   ;doc string missing？
;;
;;使用魔术转换器
;;用户可以将待选词 “特殊处理” 后再 “上屏”，比如 “简体转繁体” 或者 “输入中文，上屏 英文” 之类的。
;; (defun my-converter (string)
  ;; (if (equal string "二呆")
      ;; "“一个超级帅的小伙子”"
    ;; string))
;; (setq pyim-outcome-magic-converter #'my-converter) ;未见魔术转换变量
;;切换全角标点与半角标点
;;第一种方法：使用命令 `pyim-punctuation-toggle’，全局切换。
;;这个命令主要用来设置变量： `pyim-punctuation-translate-p’,
;;用户也可以手动设置这个变量， 比如：
;;(setq-default pyim-punctuation-translate-p '(yes))    ;使用全角标点。
;;(setq-default pyim-punctuation-translate-p '(no))     ;使用半角标点。
(setq-default pyim-punctuation-translate-p '(auto))   ;中文使用全角标点，英文使用半角标点。
;;第二种方法：使用命令 `pyim-punctuation-translate-at-point’ 只切换光标处标点的样式。
;;第三种方法：设置变量 `pyim-outcome-trigger’ ，输入变量设定的字符会切换光标处标点的样式。
;;
;;手动加词和删词
;;`pyim-convert-string-at-point’ 金手指命令，可以比较方便的添加和删除词条，比如：
;;      在 “你好” 后面输入 2, 然后运行金手指命令，可以将 “你好” 加入个人词库。
;;      在 “你好” 后面输入 2-, 然后运行金手指命令，可以将 “你好” 从个人词库删除。
;;      如果用户选择了一个词条，则运行金手指命令可以将选择的词条加入个人词库。
;;`pyim-create-Ncchar-word-at-point’ 这是一组命令，从光标前提取 N 个汉字字符组成字 符串，并将其加入个人词库。
;;`pyim-outcome-trigger’ 以默认设置为例：在 “我爱吃红烧肉” 后输入 “5v”，可以将 “爱吃红烧肉” 这个词条保存到用户个人词库。
;;`pyim-create-word-from-selection’, 选择一个词条，运行这个命令后，就可以将这个 词条添加到个人词库。
;;`pyim-delete-word’ 从个人词库中删除当前高亮选择的词条。
;;
(setq pyim-indicator-list (list #'my-pyim-indicator-with-cursor-color #'pyim-indicator-with-modeline))

(defun my-pyim-indicator-with-cursor-color (input-method chinese-input-p)
  (if (not (equal input-method "pyim"))
      (progn
        ;; 用户在这里定义 pyim 未激活时的光标颜色设置语句
        (set-cursor-color "red"))
    (if chinese-input-p
        (progn
          ;; 用户在这里定义 pyim 输入中文时的光标颜色设置语句
          (set-cursor-color "green"))
      ;; 用户在这里定义 pyim 输入英文时的光标颜色设置语句
      (set-cursor-color "blue"))))
;;
;;
;;(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
;;(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
;;(setq default-input-method "pyim")
(setq default-input-method "pyim")
(with-eval-after-load "liberime"
  (liberime-try-select-schema "luna_pinyin_simp")
  (setq pyim-default-scheme 'rime-quanpin))
;;
;; pyim
;;(use-package! liberime-config)
;;(use-package! pyim
  ;; :quelpa (pyim :fetcher github :repo "merrickluo/pyim")
;;  :init
;;  (setq pyim-title "R")
;;  :config
;;   (use-package pyim-basedict
;;     :config
;;     (pyim-basedict-enable))
;;  (global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
;;  (setq pyim-dcache-auto-update nil)
;;  (setq default-input-method "pyim")
  ;; 我使用全拼
;;  (setq pyim-default-scheme 'rime)
;;  (setq pyim-page-tooltip 'child-frame)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;;  (setq-default pyim-english-input-switch-functions
;;		        '(pyim-probe-dynamic-english
;;		          pyim-probe-isearch-mode
;;		          pyim-probe-program-mode
;;                  pyim-probe-evil-normal-mode
;;		          pyim-probe-org-structure-template))

;;  (setq-default pyim-punctuation-half-width-functions
;;		        '(pyim-probe-punctuation-line-beginning
;;		          pyim-probe-punctuation-after-punctuation)))


;;使用 org capture
(with-eval-after-load 'org-capture
      (defun org-hugo-new-subtree-post-capture-template ()
	"Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
	(let*   ((date (format-time-string (org-time-stamp-format :long :inactive) (org-current-time)))
                 (title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
                 (fname (org-hugo-slug title)))
	  (mapconcat #'identity
                     `(,(concat "* TODO " title)
		     ":PROPERTIES:"
		     ,(concat ":EXPORT_FILE_NAME: " fname)
                     ,(concat ":EXPORT_DATE: " date)
		     ":END:"
		     "%?\n")          ;Place the cursor here finally
		     "\n")))
;;每一个 org subtree 是一篇博客
      (add-to-list 'org-capture-templates
		   '("h"                ;`org-capture' binding + h
		     "Hugo post"
		     entry
		     ;; It is assumed that below file is present in `org-directory'
		     ;; and that it has a "Blog Ideas" heading. It can even be a
		     ;; symlink pointing to the actual location of all-posts.org!
		     (file+headline "/home/echozcz/blog/all-blog.org" "Blog Ideas")
		     (function org-hugo-new-subtree-post-capture-template))))

;; doom help about how to config
;;
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Zhang ChaoZhong"
      user-mail-address "echozcz@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;
