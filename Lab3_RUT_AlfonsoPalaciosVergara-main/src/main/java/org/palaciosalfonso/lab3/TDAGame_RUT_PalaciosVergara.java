package org.palaciosalfonso.lab3;

import java.util.ArrayList;
import java.util.List;

public abstract class TDAGame_RUT_PalaciosVergara implements Printable_RUT_PalaciosVergara {
    protected Player_RUT_PalaciosVergara plyr1;
    protected Player_RUT_PalaciosVergara plyr2;
    protected Board_RUT_PalaciosVergara brd;
    protected int currentTurn;
    protected List<ArrayList<Integer>> history;

    public TDAGame_RUT_PalaciosVergara(Player_RUT_PalaciosVergara plyr1, Player_RUT_PalaciosVergara plyr2){
        this.brd = new Board_RUT_PalaciosVergara();
        this.plyr1 = plyr1;
        this.plyr2 = plyr2;
        this.currentTurn = 1;
        this.history = new ArrayList<>();
    }

    protected abstract List<ArrayList<Integer>> getHistory();

    protected abstract boolean isDraw();

    protected abstract Player_RUT_PalaciosVergara getCurrentPlayer();

    protected abstract void boardGetState();

    protected abstract void endGame();

    protected abstract void play(Player_RUT_PalaciosVergara plyr, int col);

    protected void printPlayers(){
        System.out.printf("[PLAYER 1]: " + plyr1.getName() +  ", ID: " + plyr1.getID() + ". Color: " + plyr1.getClrStr() + " (pieza " + plyr1.getClr() + "). Wins: " + plyr1.getWs() + ". Losses: " + plyr1.getLs() + ". Draws: " + plyr1.getDrws() + ". Pieces left: " + plyr1.getRpcs() + "\n");
        System.out.printf("[PLAYER 2]: " + plyr2.getName() +  ", ID: " + plyr2.getID() + ". Color: " + plyr2.getClrStr() + " (pieza " + plyr2.getClr() + "). Wins: " + plyr2.getWs() + ". Losses: " + plyr2.getLs() + ". Draws: " + plyr2.getDrws() + ". Pieces left: " + plyr2.getRpcs());
    }

    @Override
    public void print(){
        brd.print();
        printPlayers();
    }
}
