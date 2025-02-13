:-use_module('main_RUT_PalaciosVergara').


player(1, "Juan", "red", 0, 0, 0, 10, P1),
player(2, "Mauricio", "yellow", 0, 0, 0, 10, P2),

piece("red", RedPiece),
piece("yellow", YellowPiece),

board(EmptyBoard),

game(P1, P2, EmptyBoard, 1, G0),

player_play(G0, P1, 0, G1),
player_play(G1, P2, 1, G2),
player_play(G2, P1, 1, G3),
player_play(G3, P2, 2, G4),
player_play(G4, P1, 2, G5),
player_play(G5, P2, 3, G6),
player_play(G6, P1, 2, G7),
player_play(G7, P2, 3, G8),
player_play(G8, P1, 3, G9),
player_play(G9, P2, 0, G10),
player_play(G10, P1, 3, G11),

write('�Se puede jugar en el tablero vac�o? '),
can_play(EmptyBoard),
nl,
game_get_board(G11, CurrentBoard),
write('�Se puede jugar despu�s de 11 movimientos? '),
can_play(CurrentBoard),
nl,
 write('Jugador actual despu�s de 11 movimientos: '),
   get_current_player(G11, CurrentPlayer),
   write(CurrentPlayer),
   nl,


   write('Verificaci�n de victoria vertical: '),
   check_vertical_win(CurrentBoard, VerticalWinner),
   write(VerticalWinner),
   nl,

   write('Verificaci�n de victoria horizontal: '),
   check_horizontal_win(CurrentBoard, HorizontalWinner),
   write(HorizontalWinner),
   nl,

   write('Verificaci�n de victoria diagonal: '),
   check_diagonal_win(CurrentBoard, DiagonalWinner),
   write(DiagonalWinner),
   nl,

   write('Verificaci�n de ganador: '),
   who_is_winner(CurrentBoard, Winner),
   write(Winner),
   nl,


   write('�Es empate? '),
   is_draw(G11),
   nl,


   end_game(G11, EndedGame),


   write('Historial de movimientos: '),
   game_history(EndedGame, History),
   write(History),
   nl,


   write('Estado final del tablero: '),
   game_get_board(EndedGame, FinalBoard),
   write(FinalBoard).
