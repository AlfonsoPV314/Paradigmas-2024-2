#lang racket
(provide (all-defined-out))

;; ==========SELECTORS==========

; Desc: Funcion que obtiene el id de un jugador
; Dom: plyr (player)
; Rec: int
; Recursion: No aplica, pues no es necesario
(define get-id-player
  (lambda (plyr)
    (car plyr)))

; Desc: Funcion que obtiene el nombre de un jugador
; Dom: plyr (player)
; Rec: string
; Recursion: No aplica, pues no es necesario
(define get-name-player
  (lambda (plyr)
    (second plyr)))

; Desc: Funcion que obtiene el color de un jugador
; Dom: plyr (player)
; Rec: string
; Recursion: No aplica, pues no es necesario
(define get-color-player
  (lambda (plyr)
    (car (third plyr))))

; Desc: Funcion que obtiene la pieza de un jugador
; Dom: plyr (player)
; Rec: pce (piece)
; Recursion: No aplica, pues no es necesario
(define get-pce-player
  (lambda (player)
    (third player)))

; Desc: Funcion que obtiene el numero de victorias de un jugador
; Dom: plyr (player)
; Rec: int
; Recursion: No aplica, pues no es necesario
(define get-win-count-player
  (lambda (plyr)
    (fourth plyr)))

; Desc: Funcion que obtiene el numero de derrotas de un jugador
; Dom: plyr (player)
; Rec: int
; Recursion: No aplica, pues no es necesario
(define get-lose-count-player
  (lambda (plyr)
    (fifth plyr)))

; Desc: Funcion que obtiene el numero de empates de un jugador
; Dom: plyr (player)
; Rec: int
; Recursion: No aplica, pues no es necesario
(define get-draw-count-player
  (lambda (plyr)
    (sixth plyr)))

; Desc: Funcion que obtiene el numero de piezas restantes de un jugador
; Dom: plyr (player)
; Rec: int
; Recursion: No aplica, pues no es necesario
(define get-remaining-pieces-player
  (lambda (plyr)
    (last plyr)))

; Desc: Funcion que obtiene el index de un jugador (si es el jugador 1 o 2 según mi implementación. Ver supuesto 1 del archivo "main.rkt")
; Dom: plyr (player)
; Rec: int (1 si es el jugador 1, 2 si es el jugador 2)
; Recursion: No aplica, pues no es necesario
(define get-index-player
  (lambda (plyr)
    (if (string=? (get-color-player plyr) "red")
        1
        2)))


;; ==========MODIFIERS==========

; Desc: Funcion que resta la cantidad de piezas restantes de un jugador en 1
; Dom: plyr (player)
; Rec: plyr (player)
; Recursion: No aplica, pues no es necesario
(define lower-pieces
  (lambda (plyr)
    (list (get-id-player plyr) (get-name-player plyr) (get-pce-player plyr) (get-win-count-player plyr) (get-lose-count-player plyr) (get-draw-count-player plyr) (- (get-remaining-pieces-player plyr) 1))))