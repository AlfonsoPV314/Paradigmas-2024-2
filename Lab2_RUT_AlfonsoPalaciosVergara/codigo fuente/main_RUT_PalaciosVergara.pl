%% main -  Lab 2 2024-2, USACH Ing Civ Inf, Paradigmas de Programaci�n
:-module(main_RUT_palaciosvergara, [player/8, piece/2, board/1, can_play/1, play_piece/4, check_vertical_win/2, check_horizontal_win/2, check_diagonal_win/2, who_is_winner/2, game/5, game_history/2, is_draw/1, update_stats/3, get_current_player/2, game_get_board/2, end_game/2, player_play/4]).
:-use_module('TDAboard_RUT_PalaciosVergara').
:-use_module('TDAgame_RUT_PalaciosVergara').
:-use_module('TDAplayer_RUT_PalaciosVergara').

% Pred: player
% MP: player/8
% MS: piece(Clr, ClrIndex).
% Desc: Predicado que permite crear un jugador
% Dom: Id (int) X Name (string) X Clr (string) X Ws (int) X Ls (int) X Ds (int) X RPcs (int) X Plyr (player)
% Strat: No aplica
player(Id, Name, Clr, Ws, Ls, Ds, RPcs, [Id, Name, ClrIndex, Ws, Ls, Ds, RPcs]):-
    piece(Clr, ClrIndex).

% Pred: piece
% MP: piece/2
% MS: !.
% Desc: Predicado que crea una ficha de Conecta4.
% Dom: Color (string) X piece
% Strat: No aplica
piece("red", 1):-!.
piece("yellow", 2):-!.
piece(_, 3).

% Pred: board
% MP: board/1
% MS: F1 = [0,0,0,0,0,0,0], F2 = [0,0,0,0,0,0,0], F3 = [0,0,0,0,0,0,0], F4 = [0,0,0,0,0,0,0], F5 = [0,0,0,0,0,0,0], F6 = [0,0,0,0,0,0,0].
% Desc: Predicado que permite crear un tablero de Conecta4.
% Dom: board
board([F1, F2, F3, F4, F5, F6]):-
    F1 = [0,0,0,0,0,0,0],
    F2 = [0,0,0,0,0,0,0],
    F3 = [0,0,0,0,0,0,0],
    F4 = [0,0,0,0,0,0,0],
    F5 = [0,0,0,0,0,0,0],
    F6 = [0,0,0,0,0,0,0].

% Pred: can_play
% MP: can_play/1
% MS: getFirstRow(Board, F1), myMember(0, F1).
% Desc: Predicado que permite verificar si se puede realizar m�s jugadas en el tablero.
% Dom: Board
can_play(Board) :-
    getFirstRow(Board, F1),
    myMember(0, F1).

% Pred: play_piece
% MP: play_piece/4
% MS: getLastPlayableRow(Brd, Col, 0, 1, Row, RowIndex), putPiece(Row, Pce, Col, 1, UpdatedRow), insertRow(Brd, UpdatedRow, RowIndex, 1, BrdOut).
% Desc: Predicado que permite jugar una ficha en el tablero
% Dom: Brd (board) X Col (int) X Pce (piece) X BrdOut (board)
play_piece(Brd, Col, Pce, BrdOut):-
    ActualCol is Col + 1,
    getLastPlayableRow(Brd, ActualCol, 0, 1, Row, RowIndex),
    putPiece(Row, Pce, ActualCol, 1, UpdatedRow),
    insertRow(Brd, UpdatedRow, RowIndex, 1, BrdOut).

% Pred: check_vertical_win
% MP: check_vertical_win/2
% MS: checkAllColumns(Brd, 1, Res).
% Desc: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma vertical.
% Dom: Brd (board) X Res (int)
check_vertical_win(Brd, Res):-
    checkAllColumns(Brd, 1, Res).

% Pred: check_horizontal_win
% MP: check_horizontal_win/2
% MS: getFirstElement(Row, First), getRest(Row, Rest), winCheckInRow(First, 0, 1, Res), Res =\= 0, !; check_horizontal_win(Rest, Res), !.
% Desc: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma horizontal.
% Dom: Brd (board) X Res (int)
check_horizontal_win([], 0):-!.
check_horizontal_win(Brd, Res):-
    getFirstRow(Brd, First),
    winCheckInRow(First, 0, 1, Res),
    Res =\= 0,
    !
    ;
    getRest(Brd, Rest),
    check_horizontal_win(Rest, Res),
    !.

% Pred: check_diagonal_win
% MP: check_diagonal_win/2
% MS: getFirstElement(Brd, Row), getRest(Brd, Rest), checkDiagsInRow([Row|Rest], 1, Res), Res =\= 0, ! ; check_diagonal_win(Rest, Res), !.
% Desc: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma diagonal.
% Dom: Brd (board) X Res (int)
check_diagonal_win([], 0):-!.
check_diagonal_win(Brd, Res):-
    getFirstElement(Brd, Row),
    getRest(Brd, Rest),
    checkDiagsInRow([Row|Rest], 1, Res),
    Res =\= 0,
    !
    ;
    getRest(Brd, Rest),
    check_diagonal_win(Rest, Res),
    !.

% Pred: who_is_winner
% MP: who_is_winner/2
% MS: check_vertical_win(Brd, Res), Res =\= 0, ! ; check_horizontal_win(Brd, Res), Res =\= 0, ! ; check_diagonal_win(Brd, Res), !.
% Desc: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma diagonal.
% Dom: Brd (board) X Res (int)
who_is_winner(Brd, Res):-
    check_vertical_win(Brd, Res),
    Res =\= 0,
    !
    ;
    check_horizontal_win(Brd, Res),
    Res =\= 0,
    !
    ;
    check_diagonal_win(Brd, Res),
    !.

% Pred: game
% MP: game/5
% MS: No posee
% Desc: Predicado que permite crear una nueva partida.
% Dom: Plyr1 (player) X Plyr2 (player) X Brd (board) X CTrn (int) X game
game(Plyr1, Plyr2, Brd, CTrn, [Plyr1, Plyr2, Brd, CTrn, []]).

% Pred: game_history
% MP: game_history/2
% MS: getHistory(Game, History).
% Desc: Predicado que genera un historial de movimientos de la partida.
% Dom: Game (game) X History (list)
game_history(Game, History):-
    getHistory(Game, History).

% Pred: is_draw
% MP: is_draw/1
% MS: getPlyr1(Game, Plyr1), getPlyr2(Game, Plyr2), getBrd(Game, Brd), getRPcs(Plyr1, RPcs1), getRPcs(Plyr2, RPcs2), getFirstRow(Brd, FirstRow), isEmpty(FirstRow, EmptyCheck), (EmptyCheck is 0; RPcs1 is 0; RPcs2 is 0), !.
% Desc: Predicado que verifica si el estado actual del juego es empate.
% Dom: Game (game)
is_draw(Game):-
    getPlyr1(Game, Plyr1),
    getPlyr2(Game, Plyr2),
    getBrd(Game, Brd),
    getRPcs(Plyr1, RPcs1),
    getRPcs(Plyr2, RPcs2),
    getFirstRow(Brd, FirstRow),
    isEmpty(FirstRow, EmptyCheck),
   (EmptyCheck is 0;
    RPcs1 is 0;
    RPcs2 is 0),
    !.

% Pred: update_stats
% MP: update_stats/3
% MS: getBrd(Game, Brd), who_is_winner(Brd, Winner), inner is 1, statsUpdater(OldStats, 1, NewStats) ; getBrd(Game, Brd), who_is_winner(Brd, Winner), Winner is 2, statsUpdater(OldStats, 2, NewStats) ;statsUpdater(OldStats, 0, NewStats).
% Desc: Predicado que actualiza las estad�sticas del jugador, ya sea victoria, derrotas o empates.
% Dom: Game (game) X OldStats (list) X NewStats (list)
update_stats(Game, OldStats, NewStats):-
   getBrd(Game, Brd),
   who_is_winner(Brd, Winner),
   Winner is 1,
   statsUpdater(OldStats, 1, NewStats)
   ;
   getBrd(Game, Brd),
   who_is_winner(Brd, Winner),
   Winner is 2,
   statsUpdater(OldStats, 2, NewStats)
   ;
   statsUpdater(OldStats, 0, NewStats).

% Pred: get_current_player
% MP: get_current_player/2
% MS: !.
% Desc: Predicado que obtiene el jugador cuyo turno est� en curso.
% Dom: Game (game) X Plyr (player)
get_current_player([Plyr1, _, _, 1, _], Plyr1):-!.
get_current_player([_, Plyr2, _, 2, _], Plyr2):-!.

% Pred: game_get_board
% MP: game_get_board/2
% MS: getBrd(Game, Brd), !.
% Desc: Predicado que entrega por pantalla el estado actual del tablero en el juego.
% Dom: Game (game) X Brd (board)
game_get_board(Game, Brd):-
    getBrd(Game, Brd),
    !.

% Pred: end_game
% MP: end_game/2
% MS: getBrd(Game, Brd), who_is_winner(Brd, Winner), Winner is 1, updateWLs1(Game, FinishedGame), ! ; getBrd(Game, Brd), who_is_winner(Brd, Winner), Winner is 2, updateWLs2(Game, FinishedGame), ! ;    updateDs(Game, FinishedGame), !.
% Desc: Predicado finaliza el juego actualizando las estad�sticas de los jugadores seg�n el resultado.
% Dom: Game (game) X FinishedGame (game)
end_game(Game, FinishedGame):-
    getBrd(Game, Brd),
    who_is_winner(Brd, Winner),
    Winner is 1,
    updateWLs1(Game, FinishedGame),
    !
    ;
    getBrd(Game, Brd),
    who_is_winner(Brd, Winner),
    Winner is 2,
    updateWLs2(Game, FinishedGame),
    !
    ;
    updateDs(Game, FinishedGame),
    !.

% Pred: player_play
% MP: player_play/4
% MS: getClr(Plyr, Clr), getPlyr1(Game, Plyr1), getId(Plyr1, Id1), getName(Plyr1, Name1), getClr(Plyr1, Clr1), getWs(Plyr1, Ws1), getLs(Plyr1, Ls1), getDs(Plyr1, Ds1), getRPcs(Plyr1, RPcs1), getPlyr2(Game, Plyr2), getId(Plyr2, Id2), getName(Plyr2, Name2), getClr(Plyr2, Clr2), getWs(Plyr2, Ws2), getLs(Plyr2, Ls2), getDs(Plyr2, Ds2), getRPcs(Plyr2, RPcs2), getBrd(Game, Brd), getCTrn(Game, CTrn), getHistory(Game, History), ActualCol is Col + 1, whoIsPlaying(Clr, CTrn, Clr1, Clr2, Brd, Col, RPcs1, RPcs2, UpdatedBrd, UpdatedRPcs1, UpdatedRPcs2, UpdatedCTrn), append(History, [Clr, ActualCol], UpdatedHistory), doIEndGame(UpdatedBrd, Id1, Name1, Clr1, Ws1, Ls1, Ds1, UpdatedRPcs1, Id2, Name2, Clr2, Ws2, Ls2, Ds2, UpdatedRPcs2, UpdatedBrd, UpdatedCTrn, UpdatedHistory, UpdatedGame), !.
% Desc: Predicado que realiza un movimiento.
% Dom: Game (game) X Plyr (player) X Col (int) X UpdatedGame (game)
player_play(Game, Plyr, Col, UpdatedGame):-
    getClr(Plyr, Clr),
    getPlyr1(Game, Plyr1),
    getId(Plyr1, Id1),
    getName(Plyr1, Name1),
    getClr(Plyr1, Clr1),
    getWs(Plyr1, Ws1),
    getLs(Plyr1, Ls1),
    getDs(Plyr1, Ds1),
    getRPcs(Plyr1, RPcs1),
    getPlyr2(Game, Plyr2),
    getId(Plyr2, Id2),
    getName(Plyr2, Name2),
    getClr(Plyr2, Clr2),
    getWs(Plyr2, Ws2),
    getLs(Plyr2, Ls2),
    getDs(Plyr2, Ds2),
    getRPcs(Plyr2, RPcs2),
    getBrd(Game, Brd),
    getCTrn(Game, CTrn),
    getHistory(Game, History),
    whoIsPlaying(Clr, CTrn, Clr1, Clr2, Brd, Col, RPcs1, RPcs2, UpdatedBrd, UpdatedRPcs1, UpdatedRPcs2, UpdatedCTrn),
    append(History, [[Clr, Col]], UpdatedHistory),
    doIEndGame(UpdatedBrd, Id1, Name1, Clr1, Ws1, Ls1, Ds1, UpdatedRPcs1, Id2, Name2, Clr2, Ws2, Ls2, Ds2, UpdatedRPcs2, UpdatedBrd, UpdatedCTrn, UpdatedHistory, UpdatedGame),
    !.
