#lang racket
(provide (all-defined-out))

;; ==========SELECTORS==========

; Desc: Funcion que obtiene el color de una pieza
; Dom: pce (piece)
; Rec: string
; Recursion: No aplica, pues no es necesario
(define get-pce
  (lambda (pce)
    (if (empty? pce)
        ""
        (car pce))))

; Desc: Funcion que obtiene la primera fila del tablero (o el primer elemento de una lista)
; Dom: board (board)
; Rec: row (lista)
; Recursion: No aplica, pues no es necesario
(define get-first-row
  (lambda (brd)
    (if (or (null? brd) (empty? brd))
        '()
        (car brd))))

; Desc: Funcion que obtiene todas las filas (o elementos) que NO son el primero en el tablero (o una lista)
; Dom: board (board)
; Rec: board (board)
; Recursion: No aplica, pues no es necesario
(define get-rest-of-brd
  (lambda (brd)
    (if (or (null? brd) (empty? brd))
        '()
        (cdr brd))))

; Desc: Funcion que permite obtener todas las filas (o elementos) que NO son el ultimo en el tablero (o una lista)
; Dom: board (board)
; Rec: board (board)
; Recursion: No aplica, pues no es necesario
(define advance-in-row
  (lambda (brd)
    (reverse (get-rest-of-brd (reverse brd)))))

; Desc: Funcion que permite obtener el elemento que se encuentra en la columna especificada, en una fila
; Dom: fila (lista) X columna (int)
; Rec: piece (piece)
; Recursion: No aplica, pues no es necesario
(define get-column
  (lambda (row col)
    (if (or (null? row) (empty? row))
        '()
        (list-ref row col))))

; Desc: Funcion que obtiene la primera fila del tablero (o el primer elemento de una lista) transpuesta
; Dom: board (board)
; Rec: row (lista)
; Recursion: No aplica, pues no es necesario
(define get-first-transposed-row
  (lambda (brd)
    (get-first-row (transpose-brd brd 0 '()))))


;; ==========MODIFIERS==========

; Desc: Funcion que permite actualizar una fila añadiendo una pieza en la columna deseada
; Dom: fila (lista) X columna (int) X piece (piece)
; Rec: fila (lista)
; Recursion: No aplica, pues no es necesario
(define update-play-board
  (lambda (row col pce)
    (map (lambda (pos index)
           (if (= index col)
               pce
               pos))
         row (range 7))))

; Desc: Funcion que llama a la función update-play-board
; Dom: brd (board) X col (int) X pce (piece)
; Rec: brd (board)
; Recursion: Natural, pues debe avanzar en el tablero pero a su vez retornar el tablero completo
(define call-update-play-board
  (lambda (brd col pce)
    (cons (update-play-board (get-first-row brd) col pce) (get-rest-of-brd brd))))

; Desc: Funcion que permite convertir una columna en una fila
; Dom: brd (board) X col (int) X row (lista)
; Rec: fila (lista)
; Recursion: De cola, pues la fila que retornará funciona como acumulador
(define turn-col-into-row
  (lambda (brd col row)
    (if (null? brd)
        (reverse row)
        (turn-col-into-row (cdr brd) col (append row (list (get-column (car brd) col)))))))

; Desc: Funcion que transpone un tablero
; Dom: brd (board) X columna (int) X new-brd (lista)
; Rec: new-brd (board)
; Recursion: De cola, pues el tablero que retornará funciona como acumulador
(define transpose-brd
  (lambda (brd col new-brd)
    (if (null? brd)
        brd
        (if (>= col (length (car brd)))
            new-brd
            (transpose-brd brd (+ 1 col) (append new-brd (list (turn-col-into-row brd col '()))))))))

; Desc: Funcion que revierte la transposicion de un tablero
; Dom: brd (board) X columna (int) X new-brd (lista)
; Rec: new-brd (board)
; Recursion: De cola, pues el tablero que retornará funciona como acumulador
(define reverse-transpose-brd
  (lambda (brd col new-brd)
    (if (null? brd)
        brd
        (if (>= col (length (car brd)))
            (reverse new-brd)
            (reverse-transpose-brd brd (+ 1 col) (append new-brd (list (turn-col-into-row (reverse brd) col '()))))))))

; Desc: Funcion que permite avanzar en una columna
; Dom: brd (board)
; Rec: brd (board)
; Recursion: No aplica, pues no es necesario
(define advance-in-column
  (lambda (brd)
    (reverse-transpose-brd (get-rest-of-brd (transpose-brd brd 0 '())) 0 '())))


;; ==========OTHERS==========

; Desc: Funcion que verifica si 2 piezas tienen el mismo color
; Dom: pce1 (piece) X pce2 (piece)
; Rec: boolean
; Recursion: No aplica, pues no es necesario
(define is-same-pce?
  (lambda (pce1 pce2)
    (if (and (string? pce1) (string? pce2))
        (string=? pce1 pce2)
        #f)))

; Desc: Funcion que verifica si la columna deseada en la primera fila del tablero está vacía
; Dom: board (board) X columna (int)
; Rec: piece (piece)
; Recursion: No aplica, pues no es necesario
(define is-wanted-column-empty?
  (lambda (brd col)
    (empty? (get-column (get-first-row brd) col)))) ; verificamos si la columna de la primera fila del tablero es vacía

; Desc: Funcion que verifica si la columna indicada es vacía en una fila
; Dom: row (lista) X columna (int)
; Rec: boolean
; Recursion: No aplica, pues no es necesario
(define is-wanted-column-empty-row?
  (lambda (row col)
    (empty? (get-column row col))))

; Desc: Funcion que verifica si NO hay un ganador en un tablero
; Dom: brd (board)
; Rec: boolean
; Recursion: No aplica, pues no es necesario
(define non-win-condition-column
  (lambda (brd)
    (zero? (win-check-in-row (get-first-transposed-row brd) '() 0))))

; Desc: Funcion que obtiene la diagonal hacia abajo a la derecha desde la posición indicada
; Dom: brd (board) X columna (int) X lst (lista)
; Rec: lst (lista)
; Recursion: De cola, pues se posee "lst" la lista que contiene la diagonal y funciona como acumulador
(define get-right-diagonal
  (lambda (brd col lst)
    (if (null? brd)
        lst
        (if (or (> (+ 1 col) 6) (null? (car brd)))
            lst
            (get-right-diagonal (cdr brd) (+ 1 col) (cons (get-column (car brd) col) lst))))))

; Desc: Funcion que obtiene la diagonal hacia abajo a la izquierda desde la posición indicada
; Dom: brd (board) X columna (int) X lst (lista)
; Rec: lst (lista)
; Recursion: De cola, pues se posee "lst" la lista que contiene la diagonal y funciona como acumulador
(define get-left-diagonal
  (lambda (brd col lst)
    (if (null? brd)
        lst
        (if (or (< col 0) (null? (car brd)))
            lst
            (get-left-diagonal (cdr brd) (- col 1) (cons (get-column (car brd) col) lst))))))

; Desc: Funcion que verifica si existe una victoria diagonal en la primera fila de un tablero
; Dom: brd (board) X columna (int)
; Rec: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal)
; Recursion: De cola, pues se posee la columna desde la que se desea verificar que sirve como un acumulador
(define diagonal-row-win-check
  (lambda (brd col)
    (cond
      [(null? brd) brd]
      [(>= col (length (car brd))) 0]
      [(not (zero? (win-check-in-row (get-right-diagonal brd col '()) '() 0))) (win-check-in-row (get-right-diagonal brd col '()) '() 0)]
      [(not (zero? (win-check-in-row (get-left-diagonal brd col '()) '() 0))) (win-check-in-row (get-left-diagonal brd col '()) '() 0)]
      [else (diagonal-row-win-check brd (+ 1 col))])))


; Desc: Funcion que encuentra las diferencias entre 2 filas, si es que las hay
; Dom: row1 (lista) X row2 (lista) X columna (int)
; Rec: lista (posee 2 elementos: primero la columna en la cual difieren y segundo la pieza que una posee y la otra no)
; Recursion: De cola, pues se posee la columna desde la que se desea verificar que sirve como un acumulador
(define compare-rows
  (lambda (row1 row2 col)
    (cond
      [(or (null? row1) (null? row2) (>= col (length row1))) #f]
      [(equal? (get-column row1 col) (get-column row2 col)) (compare-rows row1 row2 (+ 1 col))]
      [else (list col (get-pce (get-column row2 col)))])))

; Desc: Funcion que encuentra las diferencias entre 2 tableros, si es que las hay
; Dom: brd1 (board) X brd2 (board)
; Rec: lista (posee 2 elementos: primero la columna en la cual difieren y segundo la pieza que una posee y la otra no)
; Recursion: De cola, pues para avanzar se requiere meramente llamar a la función con el cdr del tablero
(define compare-boards
  (lambda (brd1 brd2)
    (cond
      [(or (null? brd1) (null? brd2) (empty? brd1) (empty? brd2)) (list "")]
      [(compare-rows (get-first-row brd1) (get-first-row brd2) 0) (compare-rows (get-first-row brd1) (get-first-row brd2) 0)]
      [else (compare-boards (get-rest-of-brd brd1) (get-rest-of-brd brd2))])))

; Desc: Funcion que verifica si existe un ganador en una fila
; Dom: row (lista) X pce (piece) X columna (int)
; Rec: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal)
; Recursion: De cola, pues para avanzar se requiere meramente llamar a la función con el cdr del tablero
(define win-check-in-row
  (lambda (row pce acc)
    (cond
      [(and (eq? acc 4) (string=? (get-pce pce) "red")) 1]
      [(and (eq? acc 4) (string=? (get-pce pce) "yellow")) 2]
      [(null? row) 0]
      [(string=? (get-pce (car row)) (get-pce pce)) (win-check-in-row (cdr row) pce (+ 1 acc))]
      [(empty? (car row)) (win-check-in-row (cdr row) '() 0)]
      [else (win-check-in-row (cdr row) (car row) 1)])))

; Desc: Funcion que verifica si NO existe un ganador horizontal en un tablero
; Dom: row (lista) X pce (piece) X columna (int)
; Rec: boolean
; Recursion: De cola, pues para avanzar se requiere meramente llamar a la función con el cdr del tablero
(define non-win-condition-row
  (lambda (brd)
    (zero? (win-check-in-row (get-first-row (reverse brd)) '() 0))))
