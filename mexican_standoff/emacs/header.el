; Set the shortcut
(global-set-key (kbd "C-c h") 'insert_header)

; Update instead of insert if header is already there.
(setq write-file-hooks (cons 'update_header write-file-hooks))

; Set the user's login and mail.
(set 'login (let ((login (getenv "USER")))
			  (if (string= login nil)
				"marvin"
				login)
			  )
	 )

(set 'mail (let ((mail (getenv "MAIL")))
			 (if (string= mail nil)
			   "marvin@42.fr"
			   mail)
			 )
	 )

(defun header_chop_str (str n)
  (if (> (length str) n)
	(let* ((max (- n 3))
		   (new (substring str 0 max)))
	  (concat new "..."))
	str)
  )


(defun insert_filename_line ()
  (insert "/*   ")
  (setq filename (header_chop_str (file-name-nondirectory (buffer-file-name)) 41))
  (insert filename)
  (setq c (length filename))
  (while (< c 42)
		 (insert " ")
		 (setq c (1+ c))
		 )
  (insert "         :+:      :+:    :+:   */")
  )

(defun insert_username ()
  (insert "/*   ")
  (setq by (concat "By: " (header_chop_str login 8) " <" (header_chop_str mail 22) "> "))
  (insert by)
  (setq c (length by))
  (while (< c 42)
		 (insert " ")
		 (setq c (1+ c))
		 )
  (insert "     +#+  +:+       +#+        */")
  )

(defun insert_created ()
  (insert "/*   ")
  (setq cre (concat "Created: " (format-time-string "%Y/%m/%d %T") " by " (header_chop_str login 8)))
  (insert cre)
  (setq c (length cre))
  (while (< c 42)
	(insert " ")
	(setq c (1+ c))
	         )
  (insert "        #+#    #+#             */") 
  )

(defun insert_updated ()
  (insert "/*   ")
  (setq cla (concat "Updated: " (format-time-string "%Y/%m/%d %T") " by " (header_chop_str login 8)))
  (insert cla)
  (setq c (length cla))
  (while (< c 42)
	(insert " ")
	(setq c (1+ c))
	             )
  (insert "       ###   ########.fr       */") 
  )

(defun insert_header ()
  (interactive)
  (save-excursion
	(goto-char (point-min))
	(insert "/* ************************************************************************** */") (newline)
	(insert "/*                                                                            */") (newline)
	(insert "/*                                                        :::      ::::::::   */") (newline)
	(insert_filename_line) (newline)
	(insert "/*                                                    +:+ +:+         +:+     */") (newline)
	(insert_username) (newline)
	(insert "/*                                                +#+#+#+#+#+   +#+           */") (newline)
	(insert_created) (newline)
	(insert_updated) (newline)
	(insert "/*                                                                            */") (newline)
	(insert "/* ************************************************************************** */") (newline)
(newline)
	)
  )

(defun update_header ()
  (interactive)
  (save-excursion
	(if (buffer-modified-p)
	  (progn
		(goto-char (point-min))
		(if (search-forward "Updated" nil t)
		  (progn
			(delete-region
			  (progn (beginning-of-line) (point))
			  (progn (end-of-line) (point)))
			(insert_updated)
			(message "Header up to date."))))))
  nil)