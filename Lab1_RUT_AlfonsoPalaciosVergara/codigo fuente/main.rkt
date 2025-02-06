#lang racket
(provide (all-defined-out))
(require "TDAplayer.rkt")
(require "TDAboard.rkt")
(require "TDAgame.rkt")


;; SUPUESTOS:
; 1.- El jugador cuya ficha sea roja es el jugador 1 y mueve primero
; 2.- Los juegos empiezan con el turno 1 (el turno del jugador 1)

; __________RF02__________
; Desc: Funcion que representa a un jugador como una lista que contiene un id, su nombre, el color de sus piezas, la cantidad de victorias, derrotas y empates del jugador, y el numero de piezas que le quedan
; Dom: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining-pieces (int)
; Rec: player
; Recursion: No aplica
(define player
  (lambda (id name clr wns ls drws rpcs)
    (list id name (piece clr) wns ls drws rpcs)))

; __________RF03__________
; Desc: Función que crea una ficha de Conecta4.
; Dom: color (string)
; Rec: piece
; Recursion: No aplica
(define piece
  (lambda (clr)
    (list clr)))

; __________RF04__________
; Desc: Función que crea un tablero de Conecta4 como una matriz (lista de listas) de 7x6
; Dom: None
; Rec: board
; Recursion: No aplica
(define board
  (lambda ()
    (list 
     (list '() '() '() '() '() '() '())
     (list '() '() '() '() '() '() '())
     (list '() '() '() '() '() '() '())
     (list '() '() '() '() '() '() '())
     (list '() '() '() '() '() '() '())
     (list '() '() '() '() '() '() '())
     )))

; __________RF05__________
; Desc: Función que permite verificar si se puede realizar más jugadas en el tablero
; Dom: board
; Rec: boolean (#t si se puede jugar, #f si no)
; Recursion: No aplica
(define board-can-play?
  (lambda (brd)
    (if (or (null? brd) (empty? brd))
        #f
        (if (member (list) (car brd))
            #t
            #f))))



; __________RF06__________
; Desc: Función que permite jugar una pieza en el tablero
; Dom: board X column (int) X piece
; Rec: board
; Recursion: No aplica
(define board-set-play-piece
  (lambda (brd col pce)
    (define board-set-play-piece-wrap
      (lambda (brd col pce)
        (cond
          [(null? brd) brd]
          [(is-wanted-column-empty? brd col) (call-update-play-board brd col pce)]
          [else (cons (get-first-row brd) (board-set-play-piece-wrap (get-rest-of-brd brd) col pce))])))
    
    (reverse (board-set-play-piece-wrap (reverse brd) col pce))))

; __________RF07__________
; Desc: Función que verifica si existe un ganador de forma vertical, es decir, verifica si hay 4 fichas consecutivas del mismo color en cualquier columna
; Dom: board
; Rec: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical)
; Recursion: Natural
(define board-check-vertical-win
  (lambda (brd)
    (cond
      [(null? (get-first-transposed-row brd)) 7]
      [(non-win-condition-column brd) (- (board-check-vertical-win (advance-in-column brd)) 1)]
      [else (+ (win-check-in-row (get-first-transposed-row brd) '() 0) (- 7 (length (car brd))))])))

; __________RF08__________
; Desc: Función que permite verificar el estado actual del tablero y entregar posible ganador que cumple con la regla de conectar 4 fichas de forma horizontal
; Dom: board
; Rec: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal)
; Recursion: Natural
(define board-check-horizontal-win
  (lambda (brd)
    (cond
      [(null? (get-first-row brd)) 6]
      [(non-win-condition-row brd) (- (board-check-horizontal-win (advance-in-row brd)) 1)]
      [else (+ (win-check-in-row (get-first-row (reverse brd)) '() 0) (- 6 (length brd)))])))

; __________RF09__________
; Desc: Función que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma diagonal.
; Dom: board
; Rec: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal)
; Recursion: De cola

(define board-check-diagonal-win
  (lambda (brd)
    (cond
      [(null? brd) 0]
      [(not (eq? (diagonal-row-win-check brd 0) 0)) (diagonal-row-win-check brd 0)]
      [else (board-check-diagonal-win (cdr brd))])))

; __________RF10__________
; Desc: Función que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma diagonal.
; Dom: board
; Rec: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador)
; Recursion: No aplica
(define board-who-is-winner
  (lambda (brd)
    (cond
      [(or (null? brd) (empty? brd)) 0]
      [(not (zero? (board-check-vertical-win brd))) (board-check-vertical-win brd)]
      [(not (zero? (board-check-horizontal-win brd))) (board-check-horizontal-win brd)]
      [(not (zero? (board-check-diagonal-win brd))) (board-check-diagonal-win brd)]
      [else 0])))

; __________RF11__________
; Desc: Función que permite crear una nueva partida.
; Dom: player1 (player) X player2 (player) X board X current-turn (int)
; Rec: game
; Recursion: No aplica
(define game
  (lambda (plyr1 plyr2 brd ctrn)
    (list plyr1 plyr2 brd ctrn '())))

; __________RF16__________
; Desc: Función que entrega el estado actual del tablero en el juego
; Dom: game
; Rec: Board
; Recursion: No aplica
(define game-get-board
  (lambda (game)
    (if (or (null? game) (empty? game))
        game
        (third game))))

; __________RF12__________
; Desc: Función que genera un historial de movimientos de la partida.
; Dom: game (game)
; Rec: movimientos (lista)
; Recursion: No aplica
(define game-history
  (lambda (game)
    (if (or (null? game) (empty? game))
        '("")
        (map (lambda (crrnt-game game-n)
               (compare-boards crrnt-game game-n))
             (get-previous-games game) (create-lst-with-game (cons (game-get-board game) (get-previous-games game)) (length (get-previous-games game)) '())))))

; __________RF13__________
; Desc: Función que verifica si el estado actual del juego es empate.
; Dom: game (game)
; Rec:boolean (#t si es empate, #f si no)
; Recursion: No aplica
(define game-is-draw?
  (lambda (game)
    (or (not (board-can-play? (game-get-board game))) (zero? (get-remaining-pieces-player (get-plyr1 game))) (zero? (get-remaining-pieces-player (get-plyr2 game))))))

; __________RF14__________
; Desc: Funcion que actualiza las estadísticas del jugador (victorias, derrotas o empates) después de finalizar un juego, representadas como una lista en la cual el primer elemento es el nombre del jugador y el segundo es el estado de victoria del mismo. Retorna False si gana o pierde, y True si empata.
; Dom: player (player) X result (string: "win", "loss", o "draw")
; Rec: boolean
; Recursion: No aplica
(define player-update-stats
  (lambda (player res)
    (if (or (string=? "win" res) (string=? "lose" res))
        (if (string=? "win" res)
            (list (get-id-player player) (get-name-player player) (get-pce-player player) (+ (get-win-count-player player) 1) (get-lose-count-player player) (get-draw-count-player player) (get-remaining-pieces-player player))
            (list (get-id-player player) (get-name-player player) (get-pce-player player) (get-win-count-player player) (+ (get-lose-count-player player) 1) (get-draw-count-player player) (get-remaining-pieces-player player)))
        (list (get-id-player player) (get-name-player player) (get-pce-player player) (get-win-count-player player) (get-lose-count-player player) (+ 1 (get-draw-count-player player)) (get-remaining-pieces-player player)))))

; __________RF15__________
; Desc: Función que obtiene el jugador cuyo turno está en curso
; Dom: game (game)
; Rec: player
; Recursion: No aplica
(define game-get-current-player
  (lambda (game)
    (cond
      [(or (null? game) (empty? game)) game]
      [(empty? (last game)) (get-plyr1 game)]
      [(string=? (last (car (game-history game))) (get-color-player (get-plyr1 game))) (get-plyr2 game)]
      [else (get-plyr1 game)])))

; __________RF17__________
; Desc: Función finaliza el juego actualizando las estadísticas de los jugadores según el resultado
; Dom: game (game)
; Rec: game
; Recursion: No aplica
(define game-set-end
  (lambda (game)
    (cond
      [(or (null? game) (empty? game)) null]
      [(or (null? (game-get-board game)) (empty? (game-get-board game))) null]
      [(and (eq? (board-who-is-winner (game-get-board game)) 1) (is-same-pce? "red" (get-color-player (get-plyr1 game)))) (list (player-update-stats (lower-pieces (get-plyr1 game)) "win") (player-update-stats (get-plyr2 game) "lose") (game-get-board game) (get-next-turn game) (get-previous-games game))]
      [(and (eq? (board-who-is-winner (game-get-board game)) 1) (is-same-pce? "red" (get-color-player (get-plyr2 game)))) (list (player-update-stats (get-plyr1 game) "lose") (player-update-stats (lower-pieces (get-plyr2 game)) "win") (game-get-board game) (get-next-turn game) (get-previous-games game))]
      [(and (eq? (board-who-is-winner (game-get-board game)) 2) (is-same-pce? "yellow" (get-color-player (get-plyr1 game)))) (list (player-update-stats (lower-pieces (get-plyr1 game)) "win") (player-update-stats (get-plyr2 game) "lose") (game-get-board game) (get-next-turn game) (get-previous-games game))]
      [(and (eq? (board-who-is-winner (game-get-board game)) 2) (is-same-pce? "yellow" (get-color-player (get-plyr2 game)))) (list (player-update-stats (get-plyr1 game) "lose") (player-update-stats (lower-pieces (get-plyr2 game)) "win") (game-get-board game) (get-next-turn game) (get-previous-games game))]
      [else (if (< (get-remaining-pieces-player (lower-pieces (get-plyr2 game))) 0)
                (list (player-update-stats (lower-pieces (get-plyr1 game)) "draw") (player-update-stats (get-plyr2 game) "draw") (game-get-board game) (get-current-turn game) (get-previous-games game))
                (list (player-update-stats (get-plyr1 game) "draw") (player-update-stats (lower-pieces (get-plyr2 game)) "draw") (game-get-board game) (get-current-turn game) (get-previous-games game)))])))

; __________RF18__________
; Desc: Función que realiza un movimiento.
; Dom: game (game) X player (player) X column (int) 
; Rec: game
; Recursion: No aplica
(define game-player-set-move
  (lambda (game plyr col)
    (if (eq? (get-current-turn game) (get-index-player plyr))
        (if (and (board-can-play? (board-set-play-piece (game-get-board game) col (get-color-player plyr))) (zero? (board-who-is-winner (board-set-play-piece (game-get-board game) col (get-pce-player plyr)))) (and (not (<= (get-remaining-pieces-player (get-plyr1 game)) 0)) (not (<= (get-remaining-pieces-player (get-plyr2 game)) 0))))
            (if (eq? (get-current-turn game) 1)
                (list (lower-pieces (get-plyr1 game)) (get-plyr2 game) (board-set-play-piece (game-get-board game) col (get-pce-player plyr)) (get-next-turn game) (append (list (game-get-board game)) (get-previous-games game)))
                (list (get-plyr1 game) (lower-pieces (get-plyr2 game)) (board-set-play-piece (game-get-board game) col (get-pce-player plyr)) (get-next-turn game) (append (list (game-get-board game)) (get-previous-games game))))
            (game-set-end (list (get-plyr1 game) (get-plyr2 game) (board-set-play-piece (game-get-board game) col (get-pce-player plyr)) (get-next-turn game) (append (list (game-get-board game)) (get-previous-games game)))))
        null)))