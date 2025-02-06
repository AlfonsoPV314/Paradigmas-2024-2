#lang racket
(require "main.rkt")
(require "TDAboard.rkt")

(display "Pruebas de RF02:\n")
(define p1 (player 1 "Mendez" "red" 0 0 0 21))
(define p2 (player 2 "Pancho" "yellow" 0 0 0 21))
(define p3
  (player 2 "Seba" "green" 0 0 0 21))
p1
p2
p3

(display "\nPruebas de RF03:\n")
(define red-piece (piece "red"))
(define yellow-piece (piece "yellow"))
(define green-piece (piece "green"))
red-piece
yellow-piece
green-piece

(display "\nPruebas de RF04:\n")
(define empty-board (board))
(define empty-board-again (board))
(define empty-board-again-again (board))
empty-board
empty-board-again
empty-board-again-again

(display "\nPruebas de RF11:\n")
(define g-a (game p1 p2 empty-board 1))
(define g-b (game p1 p3 empty-board-again 1))
(define g-c (game p2 p3 empty-board-again-again 1))
g-a
g-b
g-c

(display "\nPruebas de RF18:\n")
(define g-a1 (game-player-set-move g-a p1 0))
(define g-a2 (game-player-set-move g-a1 p2 1))
(define g-a3 (game-player-set-move g-a2 p1 0))
g-a1
g-a2
g-a3

(display "\nPruebas de R16:\n")
(define brd-a1 (game-get-board g-a1))
(define brd-a2 (game-get-board g-a2))
(define brd-a3 (game-get-board g-a3))
brd-a1
brd-a2
brd-a3

(display "\nPruebas de R05:\n")
(define can-play-a1? (board-can-play? brd-a1))
(define can-play-a2? (board-can-play? brd-a2))
(define can-play-a3? (board-can-play? brd-a3))
can-play-a1?
can-play-a2?
can-play-a3?

(display "\nPruebas de R06:\n")
(define brd-a3-1 (board-set-play-piece brd-a3 0 red-piece))
(define brd-a3-2 (board-set-play-piece brd-a3-1 2 green-piece))
(define brd-a3-3 (board-set-play-piece brd-a3-2 0 red-piece))
brd-a3-1
brd-a3-2
brd-a3-3

(display "\nPruebas de R07:\n")
(define vcheck-a3-1 (board-check-vertical-win brd-a3-1))
(define vcheck-a3-2 (board-check-vertical-win brd-a3-2))
(define vcheck-a3-3 (board-check-vertical-win brd-a3-3))
vcheck-a3-1
vcheck-a3-2
vcheck-a3-3

(display "\nPruebas de R08:\n")
(define hcheck-a3-1 (board-check-horizontal-win brd-a3-1))
(define hcheck-a3-2 (board-check-horizontal-win brd-a3-2))
(define hcheck-a3-3 (board-check-horizontal-win brd-a3-3))
hcheck-a3-1
hcheck-a3-2
hcheck-a3-3

(display "\nPruebas de R09:\n")
(define dcheck-a3-1 (board-check-diagonal-win brd-a3-1))
(define dcheck-a3-2 (board-check-diagonal-win brd-a3-2))
(define dcheck-a3-3 (board-check-diagonal-win brd-a3-3))
dcheck-a3-1
dcheck-a3-2
dcheck-a3-3

(display "\nPruebas de R10:\n")
(define wcheck-a3-1 (board-who-is-winner brd-a3-1))
(define wcheck-a3-2 (board-who-is-winner brd-a3-2))
(define wcheck-a3-3 (board-who-is-winner brd-a3-3))
wcheck-a3-1
wcheck-a3-2
wcheck-a3-3

(display "\nPruebas de R12:\n")
(define history-a1 (game-history g-a1))
(define history-a2 (game-history g-a2))
(define history-a3 (game-history g-a3))
history-a1
history-a2
history-a3

(display "\nPruebas de R13:\n")
(define draw-a1 (game-is-draw? g-a1))
(define draw-a2 (game-is-draw? g-a2))
(define draw-a3 (game-is-draw? g-a3))
draw-a1
draw-a2
draw-a3

(display "\nPruebas de R14:\n")
(define updated-p1 (player-update-stats p1 "win"))
(define updated-p2 (player-update-stats p2 "lose"))
(define updated-p3 (player-update-stats p3 "draw"))
updated-p1
updated-p2
updated-p3

(display "\nPruebas de R15:\n")
(define current-plyr-a1 (game-get-current-player g-a1))
(define current-plyr-a2 (game-get-current-player g-a2))
(define current-plyr-a3 (game-get-current-player g-a3))
current-plyr-a1
current-plyr-a2
current-plyr-a3

(display "\nPruebas de R17:\n")
(define finished-g-a1 (game-set-end g-a1))
(define finished-g-a2 (game-set-end g-a2))
(define finished-g-a3 (game-set-end g-a3))
finished-g-a1
finished-g-a2
finished-g-a3