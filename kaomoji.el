;;; kaomoji.el --- (ﾉ´ з `)ノ

;; Copyright (C) 2017 james sangho nah <sangho.nah@gmail.com>
;;
;; Author: james sangho nah <sangho.nah@gmail.com>
;; Version: 0.0.1
;; Keywords: kaomoji emoticon emoji
;; Homepage: https://github.com/microamp/kaomoji.el

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation, either version 3 of the License, or (at your option) any later
;; version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;; details.

;; You should have received a copy of the GNU General Public License along with
;; this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; (ﾉ´ з `)ノ

;;; Code:

(require 'helm)

(defcustom kaomoji-kill-ring-save t
  "If not nil, it inserts the selected kaomoji into kill ring."
  :type 'boolean
  :group 'kaomoji)

(defcustom kaomoji-insert t
  "If not nil, it inserts the selected kaomoji at point."
  :type 'boolean
  :group 'kaomoji)

(defvar kaomoji-joy
  '("(* ^ ω ^)"
    "(´ ∀ ` *)"
    "٩(◕‿◕｡)۶"
    "ヽ(・∀・)ﾉ"
    "(´｡• ω •｡`)"
    "ヽ(*・ω・)ﾉ"
    "(^人^)"
    "(o´▽`o)"
    "(*´▽`*)"
    "｡ﾟ( ﾟ^∀^ﾟ)ﾟ｡"
    "(o´∀`o)"
    "(⌒ω⌒)"
    "ヽ(o^ ^o)ﾉ"
    "(◕‿◕)"
    "(*≧ω≦*)"
    "＼(≧▽≦)／"
    "ヽ(o＾▽＾o)ノ"
    "☆ ～('▽^人)"
    "(*°▽°*)"
    "٩(｡•́‿•̀｡)۶"
    "(✧ω✧)"
    "ヽ(*⌒▽⌒*)ﾉ"
    "(´｡• ᵕ •｡`)"
    "( ´ ▽ ` )"
    "╰(*´︶`*)╯"
    "o(≧▽≦)o"
    "(☆ω☆)"
    "(っ˘ω˘ς )"
    "＼(￣▽￣)／"
    "(*¯︶¯*)"
    "٩(◕‿◕)۶"
    "(o˘◡˘o)"
    "\(★ω★)/"
    "(〃＾▽＾〃)"
    "(╯✧▽✧)╯"
    "o(>ω<)o"
    "o( ❛ᴗ❛ )o"
    "(๑˃ᴗ˂)ﻭ"))

(defvar kaomoji-love
  '("(ﾉ´ з `)ノ"
    "(￣ε￣＠)"
    "( ´ ∀ `)ノ～ ♡"
    "(´｡• ᵕ •｡`) ♡"
    "(｡・//ε//・｡)"
    "(´ ω `♡)"
    "(◕‿◕)♡"
    "(ღ˘⌣˘ღ)"
    "(♡°▽°♡)"
    "♡ ～('▽^人)"
    "(´ ε ` )♡"
    "(´｡• ω •｡`) ♡"
    "( ´ ▽ ` ).｡ｏ♡"
    "(≧◡≦) ♡"
    "(*¯ ³¯*)♡"
    "(っ˘з(˘⌣˘ ) ♡"
    "٩(♡ε♡)۶"
    "σ(≧ε≦σ) ♡"
    "♡ (￣З￣)"
    "(❤ω❤)"))

(defvar kaomoji-embarrassment
  '("(⌒_⌒;)"
    "(o^ ^o)"
    "(*/ω＼)"
    "(*/。＼)"
    "(*/_＼)"
    "(*ﾉωﾉ)"
    "(o-_-o)"
    "(*μ_μ)"
    "( ◡‿◡ *)"
    "(ᵔ.ᵔ)"))

(defvar kaomoji-sympathy
  '("(ノ_<。)ヾ(´ ▽ ` )"
    "｡･ﾟ･(ﾉД`)ヽ(￣ω￣ )"
    "ρ(- ω -、)ヾ(￣ω￣; )"
    "ヽ(￣ω￣(。。 )ゝ"
    "(*´ I `)ﾉﾟ(ﾉД｀ﾟ)ﾟ｡"
    "ヽ(~_~(・_・ )ゝ"
    "(ﾉ_；)ヾ(´ ∀ ` )"
    "(; ω ; )ヾ(´∀`* )"
    "(*´ー)ﾉ(ノд`)"
    "(´-ω-`( _ _ )"))

(defvar kaomoji-dissatisfaction
  '("(＃＞＜)"
    "(；⌣̀_⌣́)"
    "☆ｏ(＞＜；)○"
    "(￣ ￣|||)"
    "(；￣Д￣)"
    "(￣□￣」)"
    "(＃￣0￣)"
    "(＃￣ω￣)"
    "(￢_￢;)"
    "(＞ｍ＜)"))

(defvar kaomoji-anger
  '("(＃`Д´)"
    "(`皿´＃)"
    "( ` ω ´ )"
    "ヽ( `д´*)ノ"
    "(・`ω´・)"
    "(`ー´)"
    "ヽ(`⌒´メ)ノ"
    "凸(`△´＃)"
    "( `ε´ )"
    "ψ( ` ∇ ´ )ψ"))

(defvar kaomoji-sadness
  '("(ノ_<。)"
    "(-_-)"
    "(´-ω-`)"
    ".･ﾟﾟ･(／ω＼)･ﾟﾟ･."
    "(μ_μ)"
    "(ﾉД`)"
    "(-ω-、)"
    "。゜゜(´Ｏ`) ゜゜。"
    "o(TヘTo)"
    "( ; ω ; )"))

(defvar kaomoji-pain
  '("~(>_<~)"
    "☆⌒(> _ <)"
    "☆⌒(>。<)"
    "(☆_@)"
    "(×_×)"
    "(x_x)"
    "(×_×)⌒☆"
    "(x_x)⌒☆"
    "(×﹏×)"
    "☆(＃××)"))

(defvar kaomoji-fear
  '("(ノωヽ)"
    "(／。＼)"
    "(ﾉ_ヽ)"
    "..・ヾ(。＞＜)シ"
    "(″ロ゛)"
    "(;;;*_*)"
    "(・人・)"
    "＼(〇_ｏ)／"
    "(/ω＼)"
    "(/_＼)"))

(defvar kaomoji-indifference
  '("ヽ(ー_ー )ノ"
    "ヽ(´ー` )┌"
    "┐(‘～` )┌"
    "ヽ(　￣д￣)ノ"
    "┐(￣ヘ￣)┌"
    "ヽ(￣～￣　)ノ"
    "╮(￣_￣)╭"
    "ヽ(ˇヘˇ)ノ"
    "┐(￣～￣)┌"
    "┐(︶▽︶)┌"))

(defvar kaomoji-confusion
  '("(￣ω￣;)"
    "σ(￣、￣〃)"
    "(￣～￣;)"
    "(-_-;)・・・"
    "┐('～`;)┌"
    "(・_・ヾ"
    "(〃￣ω￣〃ゞ"
    "┐(￣ヘ￣;)┌"
    "(・_・;)"
    "(￣_￣)・・・"))

(defvar kaomoji-sleeping
  '("[(－－)]..zzZ"
    "(－_－) zzZ"
    "(∪｡∪)｡｡｡zzZ"
    "(－ω－) zzZ"
    "(￣o￣) zzZZzzZZ"
    "(( _ _ ))..zzzZZ"
    "(￣ρ￣)..zzZZ"
    "(－.－)...zzz"
    "(＿ ＿*) Z z z"
    "(x . x) ~~zzZ"))

(defvar kaomoji-categories '(("Joy" . kaomoji-joy)
                             ("Love" . kaomoji-love)
                             ("Embarrassment" . kaomoji-embarrassment)
                             ("Sympathy" . kaomoji-sympathy)
                             ("Dissatisfaction" . kaomoji-dissatisfaction)
                             ("Anger" . kaomoji-anger)
                             ("Sadness" . kaomoji-sadness)
                             ("Pain" . kaomoji-pain)
                             ("Fear" . kaomoji-fear)
                             ("Indifference" . kaomoji-indifference)
                             ("Confusion" . kaomoji-confusion)
                             ("Sleeping" . kaomoji-sleeping)))

(defun helm-kaomoji-item-selected (item)
  (progn
    (when kaomoji-kill-ring-save
      (kill-new item)
      (message "Saved in kill ring: %s" item))
    (when kaomoji-insert
      (insert item))))

(defun helm-kaomoji-category-selected (category)
  (let ((helm-source `((name . ,(format "HELM Kaomoji: %s" category))
                       (candidates . ,(cdr (assoc category kaomoji-categories)))
                       (action . helm-kaomoji-item-selected))))
    (helm :sources '(helm-source))))

(defun helm-kaomoji-random-category-selected (category)
  (let* ((items (eval (cdr (assoc category kaomoji-categories))))
         (random-item (nth (random (length items)) items)))
    (helm-kaomoji-item-selected random-item)))

;;;###autoload
(defun helm-kaomoji ()
  (interactive)
  (let ((helm-source `((name . "HELM Kaomoji")
                       (candidates . ,(mapcar 'car kaomoji-categories))
                       (action . helm-kaomoji-category-selected))))
    (helm :sources '(helm-source))))

;;;###autload
(defun helm-kaomoji-random ()
  (interactive)
  (let ((helm-source `((name . "HELM Kaomoji (random)")
                       (candidates . ,(mapcar 'car kaomoji-categories))
                       (action . helm-kaomoji-random-category-selected))))
    (helm :sources '(helm-source))))

(provide 'kaomoji)
;;; kaomoji.el ends here
