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
;; URL: https://github.com/baron/nazna.el
;; Keywords: arithmetic, math
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; mental arithmetic for emacs
;; nazna is "anzan", that is
;; mental arithmetic in Japanese spelled backwards
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

(require 'cl)

(defcustom nazna-operators '("*" "/" "+" "-")
  "the operators for use in generating problems"
  :group 'nazna)

(defcustom nazna-difficulty 1
  "difficulty level of problems, corresponds to the number of maximum digits in random number generator"
  :group 'nazna)

(defcustom nazna-level-step 2
  "this variable sets how fast the difficulty is incremented"
  :group 'nazna)

(defvar nazna-wrong-answers 0)

(defvar nazna-correct-answers 0)

(defvar nazna-sleep 0.5)

(defun nazna-random-number ()
  "generates random number for problems"
  (random (* 10 nazna-difficulty)))

(defun nazna-operator ()
  "selects random operator"
  (nth (random (- (length nazna-operators) 1)) nazna-operators))

(defun nazna-solution  (x y op)
  (cond
   ((string= op "*") (* x y))
   ((string= op "-") (- x y))
   ((string= op "+") (+ x y))
   ((string= op "/")
    (if (= y 0)
        0
      (/ (float x) (float y))))))

(defun nazna-correct ()
  (progn
    (setq nazna-correct-answers (1+ nazna-correct-answers))
    (message "good job")))

(defun nazna-wrong (question answer)
  (progn
    (setq nazna-wrong-answers (1+ nazna-wrong-answers))
    (message (format "wrong: %s %s" question answer))))

(defun nazna-next-problem ()
  (sleep-for nazna-sleep)
  (nazna))

(defun nazna-skip (question answer)
  (progn
    (setq nazna-sleep (1+ nazna-sleep))
    (nazna-wrong question answer)
    (nazna-next-problem)))

(defun nazna-adjust ()
  (if (> nazna-wrong-answers nazna-level-step)
      (progn
        (unless (< nazna-difficulty 2)
          (setq nazna-difficulty (1- nazna-difficulty)))
        (setq nazna-wrong-answers 0)))
  (if (> nazna-correct-answers nazna-level-step)
      (progn
        (setq nazna-difficulty (1+ nazna-difficulty))
        (setq nazna-correct-answers 0))))

(defun nazna-answer-problem (question answer)
  (interactive)
  (setq nazna-sleep 0.5)
  (let ((i (read-from-minibuffer question)))
    (cond
     ((string= i "q") (message "bye"))
     ((string= i "s") (nazna-skip question answer))
     ((if (= (floor answer) (string-to-number i))
          (nazna-correct)
        (progn
          (nazna-wrong question answer)
          (setq nazna-sleep (1+ nazna-sleep))))
      (nazna-next-problem)))))

(defun nazna ()
  "main function creates arithmetic problem"
  (interactive)
  (nazna-adjust)
  (let  ((x (nazna-random-number))
         (y (nazna-random-number))
         (op (nazna-operator)))
    (let ((ques (format "[%s] %s %s %s = " nazna-difficulty x op y))
          (ans (nazna-solution x y op)))
      (nazna-answer-problem ques ans))))

(provide 'nazna)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; nazna.el ends here
