%% TDAplayer -  Lab 2 2024-2, USACH Ing Civ Inf, Paradigmas de Programaci�n
:-module(tdaplayer_RUT_palaciosvergara, [getId/2, getName/2, getClr/2, getWs/2, getLs/2, getDs/2, getRPcs/2]).

% ========== SELECTORES ==========


% Pred: getId
% MP: getId/2
% MS: No posee
% Desc: Predicado que obtiene el ID de un jugador
% Dom: player X Id (int)
getId([Id|_], Id).

% Pred: getName
% MP: getName/2
% MS: No posee
% Desc: Predicado que obtiene el nombre de un jugador
% Dom: player X Name (string)
getName([_, Name, _, _, _, _, _], Name).

% Pred: getClr
% MP: getClr/2
% MS: No posee
% Desc: Predicado que obtiene el color de un jugador
% Dom: player X Clr (int)
getClr([_, _, Clr, _, _, _, _], Clr).

% Pred: getWs
% MP: getWs/2
% MS: No posee
% Desc: Predicado que obtiene la cantidad de victorias de un jugador
% Dom: player X Ws (int)
getWs([_, _, _, Ws, _, _, _], Ws).

% Pred: getLs
% MP: getLs/2
% MS: No posee
% Desc: Predicado que obtiene la cantidad de derrotas de un jugador
% Dom: player X Ls (int)
getLs([_, _, _, _, Ls, _, _], Ls).

% Pred: getDs
% MP: getDs/2
% MS: No posee
% Desc: Predicado que obtiene la cantidad de empates de un jugador
% Dom: player X Ds (int)
getDs([_, _, _, _, _, Ds, _], Ds).

% Pred: getRPcs
% MP: getRPcs/2
% MS: No posee
% Desc: Predicado que obtiene la cantidad de piezas restantes de un jugador
% Dom: player X RPcs (int)
getRPcs([_, _, _, _, _, _, RPcs], RPcs).
