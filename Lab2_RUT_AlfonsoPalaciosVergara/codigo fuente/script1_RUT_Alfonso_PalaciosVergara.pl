:-use_module('main_RUT_PalaciosVergara').

player(1, "Nico", "red", 0, 0, 0, 21, P1),
player(2, "Jose", "yellow", 0, 0, 0, 21, P2),
player(3, "ParaAlcanzarElRequerimiento", "green", 0, 0, 0, 0, P3),

board(Brd),
board(Brd2),
board(Brd3),


game(P1, P2, Brd, 1, G0),
game(P1, P2, Brd2, 1, G1),
game(P2, P3, Brd3, 1, G2),

piece("red", Pce1),
piece("yellow", Pce2),
piece("green", Pce3),

play_piece(Brd, 0, Pce1, UpdatedBrd1),
play_piece(Brd2, 0, Pce2, UpdatedBrd2),
play_piece(Brd3, 0, Pce3, UpdatedBrd3),

update_stats(G0, [1, 2, 3, 4], Stats1),
update_stats(G1, [4, 3, 2, 1], Stats2),
update_stats(G2, [3, 4, 5, 6], Stats3),

write("===== JUEGO 5 ====="), nl,
player_play(G0, P1, 0, G01),
player_play(G01, P2, 2, G02),
player_play(G02, P1, 3, G03),
player_play(G03, P2, 5, G04),
player_play(G04, P1, 1, G05),

game_get_board(G05, BrdGame5),
write("Tablero: "), write(BrdGame5), nl,
can_play(BrdGame5),
get_current_player(G05, CurrentPlayer5),
write("Jugador actual: "), write(CurrentPlayer5), nl,
check_vertical_win(BrdGame5, ResV5),
write("Verificaci�n de victoria vertical: "), write(ResV5), nl,
check_horizontal_win(BrdGame5, ResH5),
write("Verificaci�n de victoria horizontal: "), write(ResH5), nl,
check_diagonal_win(BrdGame5, ResD5),
write("Verificaci�n de victoria diagonal: "), write(ResD5), nl,
who_is_winner(BrdGame5, Winner5),
write("Verificaci�n de ganador: "), write(Winner5), nl,
end_game(G05, EndedGame5),
game_history(EndedGame5, History5),
write("Historial de movimientos: "), write(History5), nl,
game_get_board(EndedGame5, BrdGameEnd5),
write("Estado final del tablero: "), write(BrdGameEnd5), nl,
write("Es empate?: "),
is_draw(EndedGame5),

nl, write("===== JUEGO 10 ====="), nl,
player_play(G05, P2, 1, G06),
player_play(G06, P1, 4, G07),
player_play(G07, P2, 2, G08),
player_play(G08, P1, 4, G09),
player_play(G09, P2, 5, G10),

game_get_board(G10, BrdGame10),
write("Tablero: "), write(BrdGame10), nl,
can_play(Brd),
get_current_player(G10, CurrentPlayer10),
write("Jugador actual: "), write(CurrentPlayer10), nl,
check_vertical_win(BrdGame10, ResV10),
write("Verificaci�n de victoria vertical: "), write(ResV10), nl,
check_horizontal_win(BrdGame10, ResH10),
write("Verificaci�n de victoria horizontal: "), write(ResH10), nl,
check_diagonal_win(BrdGame10, ResD10),
write("Verificaci�n de victoria diagonal: "), write(ResD10), nl,
who_is_winner(BrdGame10, Winner10),
write("Verificaci�n de ganador: "), write(Winner10), nl,
end_game(G10, EndedGame10),
game_history(EndedGame10, History10),
write("Historial de movimientos: "), write(History10), nl,
game_get_board(EndedGame10, BrdGameEnd10),
write("Estado final del tablero: "), write(BrdGameEnd10), nl,
write("Es empate?: "),
is_draw(EndedGame10),

nl, write("===== JUEGO 14 ====="), nl,
player_play(G10, P1, 3, G11),
player_play(G11, P2, 2, G12),
player_play(G12, P1, 3, G13),
player_play(G13, P2, 2, G14),

game_get_board(G14, BrdGame),
write("Tablero: "), write(BrdGame), nl,
can_play(Brd),
get_current_player(G14, CurrentPlayer),
write("Jugador actual: "), write(CurrentPlayer), nl,
check_vertical_win(BrdGame, ResV),
write("Verificaci�n de victoria vertical: "), write(ResV), nl,
check_horizontal_win(BrdGame, ResH),
write("Verificaci�n de victoria horizontal: "), write(ResH), nl,
check_diagonal_win(BrdGame, ResD),
write("Verificaci�n de victoria diagonal: "), write(ResD), nl,
who_is_winner(BrdGame, Winner),
write("Verificaci�n de ganador: "), write(Winner), nl,
end_game(G14, EndedGame),
game_history(EndedGame, History),
write("Historial de movimientos: "), write(History), nl,
game_get_board(EndedGame, BrdGameEnd),
write("Estado final del tablero: "), write(BrdGameEnd), nl,
write("Es empate?: "),
is_draw(EndedGame),
write("true").
