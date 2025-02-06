#lang racket
(require "main.rkt")
(define p1 (player 1 "Nico" "red" 0 0 0 21))
(define p2 (player 2 "Jose" "yellow" 0 0 0 21))
(define p3 (player 2 "Sofi" "yellow" 0 0 0 1))


(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))
(define yellow-piece-2 (piece "yellow"))

(define empty-board (board))
(define empty-board-again (board))
(define empty-board-again-again (board))

(define g0 (game p1 p2 empty-board 1))
(define g1 (game p1 p3 empty-board-again 1))
(define g2 (game p2 p3 empty-board-again-again 1))

(display "====¿Que pasa cuando se aplican muchas fichas a una columna?====")
(define g01 (game-player-set-move g0 p1 0))
(define g02(game-player-set-move g01 p2 0))
(define g03 (game-player-set-move g02 p1 0))
(define g04 (game-player-set-move g03 p2 0))
(define g05 (game-player-set-move g04 p1 0))
(define g06 (game-player-set-move g05 p2 0))
(define g07 (game-player-set-move g06 p1 0))
(display "\nTablero: ")
(game-get-board g07)

(display "¿Se puede jugar? ")
(board-can-play? (game-get-board g07))

(display "Jugador actual: ")
(game-history g07)
(game-get-current-player g07)

(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g07))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g07))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g07))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g07))

(display "¿Es empate? ")
(game-is-draw? g07)

(define ended-g0 (game-set-end g07))

(define updated-p01 (player-update-stats p1 "draw"))
(define updated-p02 (player-update-stats p2 "draw"))

(display "Historial de movimientos: ")
(game-history ended-g0) 

(display "Estado final del tablero: ")
(game-get-board ended-g0)


(display "\n====¿Que pasa cuando un jugador se queda sin piezas?====")
(define g11 (game-player-set-move g1 p1 0))
(define g12 (game-player-set-move g11 p2 0))
(define g13 (game-player-set-move g12 p1 0))
(display "\nTablero: ")
(game-get-board g13)
(display "¿Se puede jugar? ")
(board-can-play? (game-get-board g13))

(display "Jugador actual: ")
(game-get-current-player g13)

(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g13))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g13))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g13))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g13))

(display "¿Es empate? ")
(game-is-draw? g13)

(define ended-g1 (game-set-end g13))

(define updated-p11 (player-update-stats p1 "draw"))
(define updated-p12 (player-update-stats p2 "draw"))

(display "Historial de movimientos: ")
(game-history ended-g1) 

(display "Estado final del tablero: ")
(game-get-board ended-g1)

(display "\n====¿Que pasa cuando juega un jugador al que no le toca?====")
(define g21 (game-player-set-move g1 p2 0))
(define g22 (game-player-set-move g21 p2 0))
(display "\nTablero: ")
(game-get-board g22)
(display "¿Se puede jugar? ")
(board-can-play? (game-get-board g22))

(display "Jugador actual: ")
(game-get-current-player g22)

(display "Verificación de victoria vertical: ")
(board-check-vertical-win (game-get-board g22))

(display "Verificación de victoria horizontal: ")
(board-check-horizontal-win (game-get-board g22))

(display "Verificación de victoria diagonal: ")
(board-check-diagonal-win (game-get-board g22))

(display "Verificación de ganador: ")
(board-who-is-winner (game-get-board g22))

(display "¿Es empate? ")
(game-is-draw? g22)

(define ended-g2 (game-set-end g22))

(display "Historial de movimientos: ")
(game-history ended-g2) 

(display "Estado final del tablero: ")
(game-get-board ended-g2)