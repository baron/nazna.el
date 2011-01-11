;;; nazna.el ---
;;
;; Filename: nazna.el
;; Description:
;; Author: baron
;; Maintainer:
;; Created: Tue Jan 11 08:11:38 2011 (+0900)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 0
;; URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; mental arithmetic for emacs
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(defcustom nazna-operators '("*" "/" "+" "-")
  "the operators for use in generating problems")

(defcustom nazna-difficulty 1
  "difficulty level of problems, corresponds to the number of maximum digits in random number generator")

(defun nazna-random-number ()
  "generates random number for problems"
  (random (* 10 nazna-difficulty)))

(defun nazna-operator ()
  "selects random operator"
  (nth (- (length nazna-operators) 1) nazna-operators))

(defun nazna-make-problem ()
  "creates arithmetic problem"
  (interactive)
  (let  ((x (nazna-random-number))
         (y (nazna-random-number))
         (op (nazna-operator))
         )
    (message (format "%s %s %s =" x op y))
    )
  )

(provide 'nazna)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; nazna.el ends here
