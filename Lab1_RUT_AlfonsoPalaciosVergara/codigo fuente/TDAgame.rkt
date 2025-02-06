#lang racket
(provide (all-defined-out))

;; ==========SELECTORS==========

; Desc: Funcion que obtiene el jugador 1 en un juego de Conecta 4
; Dom: game (game)
; Rec: plyr (player)
; Recursion: No aplica, pues no es necesario
(define get-plyr1
  (lambda (game)
    (if (or (null? game) (empty? game))
        game
        (car game))))

; Desc: Funcion que obtiene el jugador 2 en un juego de Conecta 4
; Dom: game (game)
; Rec: plyr (player)
; Recursion: No aplica, pues no es necesario
(define get-plyr2
  (lambda (game)
    (if (or (null? game) (empty? game))
        game
        (second game))))

; Desc: Funcion que obtiene el index del jugador cuyo turno es el actual
; Dom: game (game)
; Rec: int (1 si es el jugador 1, 2 si es el jugador 2)
; Recursion: No aplica, pues no es necesario
(define get-current-turn
  (lambda (game)
    (if (or (null? game) (empty? game))
        -1
        (fourth game))))

; Desc: Funcion que obtiene el index del jugador cuyo turno es el siguiente
; Dom: game (game)
; Rec: int (1 si es el jugador 1, 2 si es el jugador 2)
; Recursion: No aplica, pues no es necesario
(define get-next-turn
  (lambda (game)
    (if (eq? 1 (get-current-turn game))
        2
        1)))

; Desc: Funcion que obtiene los tableros previos de un juego
; Dom: game (game)
; Rec: lista
; Recursion: No aplica, pues no es necesario
(define get-previous-games
  (lambda (game)
    (if (or (null? game) (empty? game))
        game
        (last game))))


;; ==========OTHERS==========

; Desc: Funcion que crea una lista con el tablero actual y todos los tableros previos de un juego
; Dom: game (game)
; Rec: lista
; Recursion: De cola, pues se tiene el acumulador "lst" que será el output de la función
(define create-lst-with-game
  (lambda (brd length lst)
    (if (zero? length)
        (reverse lst)
        (create-lst-with-game (cdr brd) (- length 1) (cons (car brd) lst)))))