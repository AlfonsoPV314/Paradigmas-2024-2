package org.palaciosalfonso.lab3;

public abstract class TDABoard_RUT_PalaciosVergara implements Printable_RUT_PalaciosVergara {
    protected final static int rows = 6;
    protected final static int cols = 7;
    protected int[][] brd;

    public TDABoard_RUT_PalaciosVergara() {
        brd = new int[rows][cols];
    }

    protected abstract boolean canPlay();

    protected abstract void play(int col, int pce);

    protected abstract int verticalCheck();

    protected abstract int horizontalCheck();

    protected abstract int diagonalCheck();

    protected abstract int getWinner();

    @Override
    public void print(){
        for (int i = 0; i < rows; i++) {
            System.out.print("[");
            for (int j = 0; j < cols; j++) {
                System.out.print(brd[i][j] + " ");
            }
            System.out.print("]\n");
        }
    }
}
