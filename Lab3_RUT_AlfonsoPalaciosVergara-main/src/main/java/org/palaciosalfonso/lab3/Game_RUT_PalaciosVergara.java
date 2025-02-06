package org.palaciosalfonso.lab3;

import java.util.ArrayList;
import java.util.List;

public class Game_RUT_PalaciosVergara extends TDAGame_RUT_PalaciosVergara {

    /**
     * Método constructor del juego
     * @param plyr1 jugador 1
     * @param plyr2 jugador 2
     */
    public Game_RUT_PalaciosVergara(Player_RUT_PalaciosVergara plyr1, Player_RUT_PalaciosVergara plyr2){
        super(plyr1, plyr2);
    }

    /**
     * Método que obtiene los movimientos realizados en el juego
     * @return
     */
    public List<ArrayList<Integer>> getHistory(){
        return history;
    }

    /**
     * Método que verifica si existe un empate
     * @return true (si hay un empate) | false (si no hay un empate)
     */
    public boolean isDraw(){
        return (plyr1.getRpcs() == 0 && plyr2.getRpcs() == 0 && brd.getWinner() == 0) || !brd.canPlay();
    }

    /**
     * Método que obtiene el jugador cuyo turno es el actual
     * @return jugador del turno actual
     */
    public Player_RUT_PalaciosVergara getCurrentPlayer(){
        if (currentTurn == 1){
            return plyr1;
        }
        return plyr2;
    }

    /**
     * Método que muestra el estado actual del tablero
     */
    public void boardGetState(){
        brd.print();
    }

    /**
     * Método que finaliza el juego actual
     */
    public void endGame(){
        if (brd.getWinner() != 0){
            if (brd.getWinner() == 1){
                plyr1.updatePlyrStats(2);
                plyr2.updatePlyrStats(1);
            }else{
                plyr1.updatePlyrStats(1);
                plyr2.updatePlyrStats(2);
            }
        }else{
            plyr1.updatePlyrStats(0);
            plyr2.updatePlyrStats(0);
        }
    }

    /**
     * Método que cambia el turno actual
     */
    private void changeCurrentTurn(){
        if (getCurrentPlayer() == plyr1){
            this.currentTurn = 2;
        }else{
            this.currentTurn = 1;
        }
    }

    /**
     * Método que añade un movimiento al historial
     * @param pce pieza jugada
     * @param col columna jugada
     */
    private void addMove(int pce, int col){
        ArrayList<Integer> move = new ArrayList<>();
        move.add(pce);
        move.add(col);
        history.add(move);
    }

    /**
     * Método que permite jugar un juego de Connect 4
     * @param plyr jugador que realiza el movimiento
     * @param col columna en la que desea jugar
     */
    public void play(Player_RUT_PalaciosVergara plyr, int col){
        if (plyr.getClr() != currentTurn){
            System.out.println("No es el turno de " + plyr.getName() + "!");
        }else{
            brd.play(col, plyr.getClr());
            if ((brd.getWinner() != 0) || isDraw()){
                endGame();
                plyr.decrementRpcs();
            }else{
                plyr.decrementRpcs();
            }
            changeCurrentTurn();
            addMove(plyr.getClr(), col);
        }
    }

    public void printHistory(){
        for (int i = 0; i < history.size(); i++){
            System.out.println(history.get(i));
        }
    }
}
