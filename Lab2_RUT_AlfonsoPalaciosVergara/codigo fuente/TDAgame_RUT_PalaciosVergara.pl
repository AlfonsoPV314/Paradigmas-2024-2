%% TDAgame -  Lab 2 2024-2, USACH Ing Civ Inf, Paradigmas de Programaci�n
:-module(tdagame_RUT_palaciosvergara, [getPlyr1/2, getPlyr2/2, getBrd/2, getCTrn/2, getHistory/2, isEmpty/2, whoIsPlaying/12, updateWLs1/2, updateWLs2/2, updateDs/2, doIEndGame/19, statsUpdater/3]).

% ========== SELECTORES ==========


% Pred: getPlyr1
% MP: getPlyr1/2
% MS: No posee
% Desc: Predicado que obtiene el player 1 de un juego
% Dom: game X Plyr1 (player)
getPlyr1([Plyr1|_], Plyr1).

% Pred: getPlyr2
% MP: getPlyr2/2
% MS: No posee
% Desc: Predicado que obtiene el player 2 de un juego
% Dom: game X Plyr2 (player)
getPlyr2([_, Plyr2, _, _, _], Plyr2).

% Pred: getBrd
% MP: getBrd/2
% MS: No posee
% Desc: Predicado que obtiene el tablero de un juego
% Dom: game X Brd (board)
getBrd([_, _, Brd, _, _], Brd).

% Pred: getCTrn
% MP: getCTrn/2
% MS: No posee
% Desc: Predicado que obtiene el index del jugador cuyo turno es el actual
% Dom: game X CTrn (int)
getCTrn([_, _, _, CTrn, _], CTrn).

% Pred: getHistory
% MP: getHistory/2
% MS: No posee
% Desc: Predicado que obtiene el historial de movimientos de un juego
% Dom: game X History (list)
getHistory([_, _, _, _, History], History).


% ========== MODIFICADORES ==========


% Pred: statsUpdater
% MP: statsUpdater/3
% MS: Flag is 0, NewDs is Ds + 1, NewStats = [PlyrClrID, Ws, Ls, NewDs], ! ; Flag is 1,(PlyrClrID is 1, NewWs is Ws + 1, NewStats = [PlyrClrID, NewWs, Ls, Ds] ; PlyrClrID is 2, NewLs is Ls + 1, NewStats = [PlyrClrID, Ws, NewLs, Ds]), ! ; Flag is 2,(PlyrClrID is 1, NewWs is Ls + 1, NewStats = [PlyrClrID, Ws, NewLs, Ds] ; PlyrClrID is 2, NewWs is Ls + 1, NewStats = [PlyrClrID, NewWs, Ls, Ds]), !.
% Desc: Predicado que decide c�mo actualizar las estad�sticas y las actualiza de manera acorde. "Flag" indica qui�n gan�
% Dom: Stats (list) X Flag (int) X NewStats (list)
statsUpdater([PlyrClrID, Ws, Ls, Ds], Flag, NewStats):-
    Flag is 0,
    NewDs is Ds + 1,
    NewStats = [PlyrClrID, Ws, Ls, NewDs],
    !
    ;
    Flag is 1,
   (PlyrClrID is 1,
    NewWs is Ws + 1,
    NewStats = [PlyrClrID, NewWs, Ls, Ds]
    ;
    PlyrClrID is 2,
    NewLs is Ls + 1,
    NewStats = [PlyrClrID, Ws, NewLs, Ds]),
    !
    ;
    Flag is 2,
   (PlyrClrID is 1,
    NewLs is Ls + 1,
    NewStats = [PlyrClrID, Ws, NewLs, Ds]
    ;
    PlyrClrID is 2,
    NewWs is Ls + 1,
    NewStats = [PlyrClrID, NewWs, Ls, Ds]),
    !.

% Pred: updateWLs1
% MP: updateWLs1/2
% MS: UpdatedWs1 is Ws1 + 1,  UpdatedLs2 is Ls2 + 1, UpdatedGame = [[Id1, Name1, Clr1, UpdatedWs1, Ls1, Ds1, RPcs1], [Id2, Name2, Clr2, Ws2, UpdatedLs2, Ds2, RPcs2], Brd, CTrn, History].
% Desc: Predicado que actualiza las estad�sticas de los jugadores de un juego para el caso en el que el jugador 1 gan�
% Dom: game X UpodatedGame (game)
updateWLs1([[Id1, Name1, Clr1, Ws1, Ls1, Ds1, RPcs1], [Id2, Name2, Clr2, Ws2, Ls2, Ds2, RPcs2], Brd, CTrn, History], UpdatedGame):-
    UpdatedWs1 is Ws1 + 1,
    UpdatedLs2 is Ls2 + 1,
    UpdatedGame = [[Id1, Name1, Clr1, UpdatedWs1, Ls1, Ds1, RPcs1], [Id2, Name2, Clr2, Ws2, UpdatedLs2, Ds2, RPcs2], Brd, CTrn, History].

% Pred: updateWLs2
% MP: upadteWLs2/2
% MS: UpdatedLs1 is Ls1 + 1, UpdatedWs2 is Ws2 + 1, UpdatedGame = [[Id1, Name1, Clr1, Ws1, UpdatedLs1, Ds1, RPcs1], [Id2, Name2, Clr2, UpdatedWs2, Ls2, Ds2, RPcs2], Brd, CTrn, History].
% Desc: Predicado que actualiza las estad�sticas de los jugadores de un juego para el caso en el que el jugador 2 gan�
% Dom: game X UpdatedGame (game)
updateWLs2([[Id1, Name1, Clr1, Ws1, Ls1, Ds1, RPcs1], [Id2, Name2, Clr2, Ws2, Ls2, Ds2, RPcs2], Brd, CTrn, History], UpdatedGame):-
    UpdatedLs1 is Ls1 + 1,
    UpdatedWs2 is Ws2 + 1,
    UpdatedGame = [[Id1, Name1, Clr1, Ws1, UpdatedLs1, Ds1, RPcs1], [Id2, Name2, Clr2, UpdatedWs2, Ls2, Ds2, RPcs2], Brd, CTrn, History].

% Pred: updateDs
% MP: updateDs/2
% MS: UpdatedDs1 is Ds1 + 1, UpdatedDs2 is Ds2 + 1, UpdatedGame = [[Id1, Name1, Clr1, Ws1, Ls1, UpdatedDs1, RPcs1], [Id2, Name2, Clr2, Ws2, Ls2, UpdatedDs2, RPcs2], Brd, CTrn, History].
% Desc: Predicado que actualiza las estad�sticas de los jugadores de un juego para el caso en el que existe un empate
% Dom: game X UpdatedGame (game)
updateDs([[Id1, Name1, Clr1, Ws1, Ls1, Ds1, RPcs1], [Id2, Name2, Clr2, Ws2, Ls2, Ds2, RPcs2], Brd, CTrn, History], UpdatedGame):-
    UpdatedDs1 is Ds1 + 1,
    UpdatedDs2 is Ds2 + 1,
    UpdatedGame = [[Id1, Name1, Clr1, Ws1, Ls1, UpdatedDs1, RPcs1], [Id2, Name2, Clr2, Ws2, Ls2, UpdatedDs2, RPcs2], Brd, CTrn, History].


% ========== OTROS ==========


% Pred: doIEndGame
% MP: doIEndGame/19
% MS: who_is_winner(UpdatedBrd, Winner), (Winner is 1 ; Winner is 2 ; UpdatedRPcs1 is 0 ; UpdatedRPcs2 is 0), end_game([[Id1, Name1, Clr1, Ws1, Ls1, Ds1, UpdatedRPcs1], [Id2, Name2, Clr2, Ws2, Ls2, Ds2, UpdatedRPcs2], UpdatedBrd, UpdatedCTrn, UpdatedHistory], UpdatedGame), ! ; UpdatedGame = [[Id1, Name1, Clr1, Ws1, Ls1, Ds1, UpdatedRPcs1], [Id2, Name2, Clr2, Ws2, Ls2, Ds2, UpdatedRPcs2], UpdatedBrd, UpdatedCTrn, UpdatedHistory].
% Desc: Predicado que decide si se debe dar el juego por finalizado, actualiz�ndolo de manera acorde
% Dom: UpdatedBrd(board) X Id1 (int) X Name1 (string) X Clr1 (int) X Ws1 (int) X Ls1 (int) X Ds1(int) X UpdatedRPcs1 (int) X Id2 (int) X Name2 (string) X Clr2 (int) X Ws2 (int) X Ls2 (int) X Ds2(int) X UpdatedRPcs2 (int) X UpdatedBrd (board) X UpdatedCTrn (int) X UpdatedHistory (list) X UpdatedGame (game)
doIEndGame(UpdatedBrd, Id1, Name1, Clr1, Ws1, Ls1, Ds1, UpdatedRPcs1, Id2, Name2, Clr2, Ws2, Ls2, Ds2, UpdatedRPcs2, UpdatedBrd, UpdatedCTrn, UpdatedHistory, UpdatedGame):-
    who_is_winner(UpdatedBrd, Winner),
   (Winner is 1
    ;
    Winner is 2
    ;
    UpdatedRPcs1 is 0,
    UpdatedRPcs2 is 0),
    end_game([[Id1, Name1, Clr1, Ws1, Ls1, Ds1, UpdatedRPcs1], [Id2, Name2, Clr2, Ws2, Ls2, Ds2, UpdatedRPcs2], UpdatedBrd, UpdatedCTrn, UpdatedHistory], UpdatedGame),
    !
    ;
    UpdatedGame = [[Id1, Name1, Clr1, Ws1, Ls1, Ds1, UpdatedRPcs1], [Id2, Name2, Clr2, Ws2, Ls2, Ds2, UpdatedRPcs2], UpdatedBrd, UpdatedCTrn, UpdatedHistory].

% Pred: isEmpty
% MP: isEmpty/2
% MS: First =\= 0, ! ; isEmpty(Rest, Res), !.
% Desc: Predicado que verifica si una lista es vac�a
% Dom: list X Res (int)
isEmpty([], 1):-!.
isEmpty([First|_], 0):-
    First =\= 0,
    !.
isEmpty([0|Rest], Res):-
    isEmpty(Rest, Res),
    !.

% Pred: whoIsPlaying
% MP: whoIsPlaying/12
% MS: Clr is 1, CTrn is Clr1, play_piece(Brd, Col, Clr1, UpdatedBrd), UpdatedRPcs1 is RPcs1 - 1, UpdatedRPcs2 is RPcs2, UpdatedCTrn is 2, ! ; Clr is 2, CTrn is Clr2, play_piece(Brd, Col, Clr2, UpdatedBrd), UpdatedRPcs2 is RPcs2 - 1, UpdatedRPcs1 is RPcs1, UpdatedCTrn is 1, !.
% Desc: Predicado que verifica si el jugador que va a jugar corresponde con aquel que le toca jugar. De ser as�, juega la pieza en el tablero y actualiza las piezas restantes del mismo as� como el jugador actual del juego
% Dom: Clr (int) X CTrn (int) X Clr1 (int) X Clr2 (int) X Brd (board) X Col (int) X RPcs1 (int) X RPcs2 (int) X UpdatedBrd (board) X UpdatedRPCs1 (int) X UpdatedRPCs2 (int) X UpdatedCTrn (int)
whoIsPlaying(Clr, CTrn, Clr1, Clr2, Brd, Col, RPcs1, RPcs2, UpdatedBrd, UpdatedRPcs1, UpdatedRPcs2, UpdatedCTrn):-
    Clr is 1,
    CTrn is Clr1,
    play_piece(Brd, Col, Clr1, UpdatedBrd),
    UpdatedRPcs1 is RPcs1 - 1,
    UpdatedRPcs2 is RPcs2,
    UpdatedCTrn is 2,
    !
    ;
    Clr is 2,
    CTrn is Clr2,
    play_piece(Brd, Col, Clr2, UpdatedBrd),
    UpdatedRPcs2 is RPcs2 - 1,
    UpdatedRPcs1 is RPcs1,
    UpdatedCTrn is 1,
    !.
