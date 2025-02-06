%% TDAboard -  Lab 2 2024-2, USACH Ing Civ Inf, Paradigmas de Programaci�n
:-module(tdaboard_RUT_palaciosvergara, [myMember/2, getFirstElement/2, getRest/2, getFirstRow/2, len/2, isWantedColEmpty/3, getElement/4, getLastPlayableRow/6, putPiece/5, insertRow/5, getColumn/4, winCheckInRow/4, checkColumn/3, checkAllColumns/3, getRightDiag/4, getLeftDiag/4, checkDiag/3, checkDiagsInRow/3]).

% ========== SELECTORES ==========


% Pred: getFirstElement
% MP: getFirstElement/2
% MS: No posee
% Desc: Predicado que permite obtener el primer elemento de una lista
% Dom: Element X Lista (list)
getFirstElement([First|_], First).

% Pred: getRest
% MP: getRest/2
% MS: No posee
% Desc: Predicado que permite obtener el resto de una lista
% Dom: Element X Lista (list)
getRest([_|Rest], Rest).

% Pred: getFirstRow
% MP: getFirstRow/2
% MS: No posee
% Desc: Predicado que permite obtener la primera fila de un tablero
% Dom: board X F1 (list)
getFirstRow([F1|_],F1).

% Pred: getElement
% MP: getElement/4
% MS: getElement(Rest, Indx, Acc, _), Acc2 is Acc + 1, etElement(Rest, Indx, Acc2, Out),!.
% Desc: Predicado que obtiene el elemento indicado de una lista
% Dom: list X Indx (int) X Acc (int) X Out (element)
getElement([], _, _, []):-!.
getElement([First|_], Indx, Indx, First):-!.
getElement([_|Rest], Indx, Acc, Out):-
    getElement(Rest, Indx, Acc, _),
    Acc2 is Acc + 1,
    getElement(Rest, Indx, Acc2, Out),
    !.

% Pred: getLastPlayableRow
% MP: getLastPlayableRow/6
% MS: getRest(Brd, Rest), getLastPlayableRow(Rest, Col, 0, Acc, _, _), Acc2 is Acc + 1, getLastPlayableRow(Rest, Col, 0, Acc2, RowOut, IndexOut), isWantedColEmpty(RowOut, Col, 1), !.
% Desc: Predicado que obtiene la �ltima fila de un tablero en la cual se puede jugar, dada una columna
% Dom: Brd (board) X Col (int) X Index (int) X Acc (int) X Out (element) X IndexOut (int)
getLastPlayableRow([], _, _, _, [], _):-!.
getLastPlayableRow(Brd, _, Index, Index, First, Index):-
    getFirstRow(Brd, First),
    !.
getLastPlayableRow(Brd, Col, _, Acc, RowOut, IndexOut):-
    getRest(Brd, Rest),
    getLastPlayableRow(Rest, Col, 0, Acc, _, _),
    Acc2 is Acc + 1,
    getLastPlayableRow(Rest, Col, 0, Acc2, RowOut, IndexOut),
    isWantedColEmpty(RowOut, Col, 1),
    !.
getLastPlayableRow([First|_], Col, _, Index, First, Index):-
    isWantedColEmpty(First, Col, 1),
    !.
getLastPlayableRow([First|_], Col, Index, Acc, Out, IndexOut):-
    getLastPlayableRow(First, Col, Index, Acc, Out, IndexOut),
    !.

% Pred: getColumn
% MP: getColumn/4
% MS: getColumn(Brd, First), getRest(Brd, Rest), getElement(First, Col, 1, Elmnt), append(NewRow, [Elmnt], NewRow2), getColumn(Rest, Col, NewRow2, RowOut), !.
% Desc: Predicado que crea una lista con los elementos de una columna en un tablero
% Dom: Brd (board) X Col (int) X NewRow (list) X RowOut (list)
getColumn([], _, RowOut, RowOut):-!.
getColumn(Brd, Col, NewRow, RowOut):-
    getFirstRow(Brd, First),
    getRest(Brd, Rest),
    getElement(First, Col, 1, Elmnt),
    append(NewRow, [Elmnt], NewRow2),
    getColumn(Rest, Col, NewRow2, RowOut),
    !.

% Pred: getRightDiag
% MP: getRightDiag/4
% MS: getFirstRow(Brd, Row), getRest(Brd, Rest), getElement(Row, Col, 1, Pce), append(NewRow, [Pce], UpdatedNewRow), NextCol is Col + 1, getRightDiag(Rest, NextCol, UpdatedNewRow, RowOut), !.
% Desc: Predicado que obtiene la diagonal de abajo a la derecha desde la posici�n indicada de un tablero, almacenando sus elementos en una lista
% Dom: Brd (board) X Col (int) X NewRow (list) X RowOut (list)
getRightDiag(_, 8, RowOut, RowOut):-!.
getRightDiag([], _, RowOut, RowOut):-!.
getRightDiag(Brd, Col, NewRow, RowOut):-
    getFirstRow(Brd, Row),
    getRest(Brd, Rest),
    getElement(Row, Col, 1, Pce),
    append(NewRow, [Pce], UpdatedNewRow),
    NextCol is Col + 1,
    getRightDiag(Rest, NextCol, UpdatedNewRow, RowOut),
    !.
% Pred: getLeftDiag
% MP: getLeftDiag/4
% MS: getFirstRow(Brd, Row), getRest(Brd, Rest), getElement(Row, Col, 1, Pce), append(NewRow, [Pce], UpdatedNewRow), NextCol is Col - 1, getRightDiag(Rest, NextCol, UpdatedNewRow, RowOut), !.
% Desc: Predicado que obtiene la diagonal de abajo a la izquierda desde la posici�n indicada de un tablero, almacenando sus elementos en una lista
% Dom: Brd (board) X Col (int) X NewRow (list) X RowOut (list)
getLeftDiag(_, 0, RowOut, RowOut):-!.
getLeftDiag([], _, RowOut, RowOut):-!.
getLeftDiag(Brd, Col, NewRow, RowOut):-
    getFirstRow(Brd, Row),
    getRest(Brd, Rest),
    getElement(Row, Col, 1, Pce),
    append(NewRow, [Pce], UpdatedNewRow),
    NextCol is Col - 1,
    getLeftDiag(Rest, NextCol, UpdatedNewRow, RowOut),
    !.


% ========== MODIFICADORES ==========


% Pred: putPiece
% MP: putPiece/5
% MS:  getFirstRow(Brd, First), getRest(Brd, Rest), Acc2 is Acc + 1, putPiece(Rest, Pce, Col, Acc2, Output), RowOut = [First|Output] !.
% Desc: Predicado que pone una pieza en la columna indicada para la primera fila de un tablero, retornando la fila modificada
% Dom: Brd (board) X Pce (piece) X Col (int) X Acc (int) X RowOut (list)
putPiece([], Pce, _, _, [Pce]):-!.
putPiece([0|Rest], Pce, Col, Col, [Pce|Rest]):-!.
putPiece(Brd, Pce, Col, Acc, RowOut):-
    getFirstRow(Brd, First),
    getRest(Brd, Rest),
    Acc2 is Acc + 1,
    putPiece(Rest, Pce, Col, Acc2, Output),
    RowOut = [First|Output],
    !.

% Pred: insertRow
% MP: insertRow/5
% MS: getFirstRow(Brd, First), getRest(Brd, Rest), ActualIndex2 is ActualIndex + 1, insertRow(Rest, Row, Index, ActualIndex2, Output BrdOut = [First|Output], !.
% Desc: Predicado que inserta una fila a un tablero en el lugar indicado
% Dom: Brd (board) X Row (list) X Index (int) X ActualIndex (int) X BrdOut (board)
insertRow([], Row, _, _, [Row]):-!.
insertRow(Brd, Row, Index, Index, [Row|Rest]):-
    getRest(Brd, Rest),
    !.
insertRow(Brd, Row, Index, ActualIndex, BrdOut):-
    getFirstRow(Brd, First),
    getRest(Brd, Rest),
    ActualIndex2 is ActualIndex + 1,
    insertRow(Rest, Row, Index, ActualIndex2, Output),
    BrdOut = [First|Output],
    !.


% ========== OTROS ==========


% Pred: len
% MP: len/2
% MS: len(Rest, Acc), Out is Acc + 1.
% Desc: Predicado que obtiene el largo de una lista
% Dom: list, Out (int)
len([], 0).
len([_|Rest], Out):-
    len(Rest, Acc),
    Out is Acc + 1.

% Pred: isWantedColEmpty
% MP: isWantedColEmpty/3
% MS: AccNew is Acc + 1, isWantedColEmpty(Rest, Col, AccNew), !.
% Desc: Predicado que verifica si la columna deseada est� vac�a
% Dom: Row (list) X Col (int) X Acc (int)
isWantedColEmpty([0|_], Col, Col).
isWantedColEmpty([_|Rest], Col, Acc):-
    AccNew is Acc + 1,
    isWantedColEmpty(Rest, Col, AccNew),
    !.

% Pred: winCheckInRow
% MP: winCheckInRow/4
% MS: getFirstElement(Brd, NewPce), getRest(Brd, Rest), Acc is 1, winCheckInRow(Rest, NewPce, Acc, Res), !.
% Desc: Predicado que verifica si existe un ganador en una fila
% Dom: Row (list) X LastPce (piece) X Acc (int) X Res (int)
winCheckInRow(_, Winner, 4, Winner):-!.
winCheckInRow([], _, _, 0):-!.
winCheckInRow([LastPce|Rest], LastPce, Acc, Res):-
    Acc2 is Acc + 1,
    winCheckInRow(Rest, LastPce, Acc2, Res),
    !.
winCheckInRow(Row, _, _, Res):-
    getFirstElement(Row, NewPce),
    getRest(Row, Rest),
    Acc is 1,
    winCheckInRow(Rest, NewPce, Acc, Res),
    !.

% Pred: checkColumn
% MP: checkColumn/3
% MS: turnColIntoRow(Brd, Col, [], ColToCheck), winCheckInRow(ColToCheck, 0, 1, Res), !.
% Desc: Predicado que verifica si hay un ganador en una columna
% Dom: Brd (board) X Col (int) X Res (int)
checkColumn(Brd, Col, Res):-
    getColumn(Brd, Col, [], ColToCheck),
    winCheckInRow(ColToCheck, 0, 1, Res),
    !.

% Pred: checkAllColumns
% MP: checkAllColumns/3
% MS: checkColumn(Brd, Col, Res), Res =\= 0, !; NextCol is Col + 1  checkAllColumns(Brd, NextCol, Res), !.
% Desc: Predicado que realiza el chequeo de ganador vertical para todas las columnas de un tablero
% Dom: Brd (board) X Col (int) X Res (int)
checkAllColumns(_, 8, 0):-!.
checkAllColumns(Brd, Col, Res):-
    checkColumn(Brd, Col, Res),
    Res =\= 0,
    !;
    NextCol is Col + 1,
    checkAllColumns(Brd, NextCol, Res),
    !.

% Pred: checkDiag
% MP: checkDiag/3
% MS: getRightDiag(Brd, Col, [], RightDiag), winCheckInRow(RightDiag, 0, 1, Res), Res =\= 0, !; getLeftDiag(Brd, Col, [], LeftDiag), winCheckInRow(LeftDiag, 0, 1, Res), !.
% Desc: Predicado que verifica si hay un ganador en alguna de las diagonales desde una posici�n de un tablero
% Dom: Brd (board) X Col (int) X Res (int)
checkDiag(Brd, Col, Res):-
    getRightDiag(Brd, Col, [], RightDiag),
    winCheckInRow(RightDiag, 0, 1, Res),
    Res =\= 0,
    !;
    getLeftDiag(Brd, Col, [], LeftDiag),
    winCheckInRow(LeftDiag, 0, 1, Res),
    !.

% Pred: checkDiagsInRow
% MP: checkDiagsInRow/3
% MS: checkDiag(Brd, Col, Res), Res=\= 0, !; NextCol is Col + 1, checkDiagsInRow(Brd, NextCol, Res), !.
% Desc: Predicado que verifica si hay un ganador diagonal en un tablero a partir de sus posiciones
% Dom: Brd (board) X Col (int) X Res (int)
checkDiagsInRow(_, 8, 0):-!.
checkDiagsInRow(Brd, Col, Res):-
    checkDiag(Brd, Col, Res),
    Res=\= 0,
    !;
    NextCol is Col + 1,
    checkDiagsInRow(Brd, NextCol, Res),
    !.

% Pred: myMember
% MP: myMember/2
% MS: myMember(Elem, Rest).
% Desc: Predicado que permite verificar si hay un elemento en una lista
% Dom: Element X Lista (list)
myMember(Elem, [Elem|_]):-!.
myMember(Elem, [_|Rest]):-
    myMember(Elem, Rest).
