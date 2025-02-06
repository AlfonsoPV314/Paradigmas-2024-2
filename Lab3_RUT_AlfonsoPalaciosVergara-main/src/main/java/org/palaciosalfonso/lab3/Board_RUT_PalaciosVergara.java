package org.palaciosalfonso.lab3;

import java.util.ArrayList;
import java.util.List;

public class Board_RUT_PalaciosVergara extends TDABoard_RUT_PalaciosVergara {

    /**
     * Método constructor del tablero
     */
    public Board_RUT_PalaciosVergara() {
        super();
    }

    /**
     * Método que verifica si se puede jugar en el tablero
     * @return true|false
     */
    public boolean canPlay(){
        for (int i = 0; i < cols; i++) {
            if (brd[0][i] == 0){
                return true;
            }
        }
        return false;
    }

    /**
     * Método que obtiene el index de la última fila del tablero en la que se puede jugar a partir de una columna
     * @param col la columna a jugar
     * @return index de la fila a jugar
     */
    private int getLastPlayableRow(int col){
        for (int i = rows - 1; i >= 0; i--) {
            if (brd[i][col] == 0){
                return i;
            }
        }
        return -1;
    }

    /**
     * Método que permite jugar una pieza en el tablero
     * @param col columna  ajugar
     * @param pce pieza a jugar
     */
    public void play(int col, int pce){
        int row = getLastPlayableRow(col);
        if (row == -1){
            System.out.println("No se ha podido jugar en la columna " + col);
            return;
        }
        this.brd[row][col] = pce;
    }

    /**
     * Método que obtiene una fila del tablero
     * @param row index de la fila a obtener
     * @return fila a obtener
     */
    public List<Integer> getRow(int row){
        List<Integer> newRow = new ArrayList<Integer>();
        for (int i = 0; i < cols; i++) {
            newRow.add(brd[row][i]);
        }
        return newRow;
    }

    /**
     * Método que obtiene una columna del tablero
     * @param col index de la columna a obtener
     * @return columna a obtener
     */
    public List<Integer> getCol(int col){
        List<Integer> newCol = new ArrayList<Integer>();
        for (int i = 0; i < rows; i++) {
            newCol.add(brd[i][col]);
        }
        return newCol;
    }

    /**
     * Método que busca el ganador en una fila (en una lista)
     * @param row fila (lista) en la que buscar ganador
     * @return id del color del ganador
     */
    private int singleRowCheck(List<Integer> row){
        int lastPce = 0;
        int counter = 0;
        for (Integer integer : row) {
            if (integer == lastPce && integer != 0) {
                counter++;
            } else if (integer != lastPce && integer != 0) {
                counter = 1;
                lastPce = integer;
            }
            if (counter >= 4) {
                return lastPce;
            }
        }
        return 0;
    }

    /**
     * Método que verifica si existe un ganador horizontal en el tablero
     * @return id del color del ganador horizontal | 0
     */
    public int horizontalCheck(){
        for (int i = 0; i < rows; i++) {
            List<Integer> row = getRow(i);
            if (singleRowCheck(row) != 0){
                return singleRowCheck(row);
            }
        }
        return 0;
    }

    /**
     * Método que verifica si existe un ganador vertical en el tablero
     * @return id del color del ganador vertical | 0
     */
    public int verticalCheck(){
        for (int i = 0; i < cols; i++) {
            List<Integer> col = getCol(i);
            if (singleRowCheck(col) != 0){
                return singleRowCheck(col);
            }
        }
        return 0;
    }

    /**
     * Método que obtiene la diagonal desde la fila y columna suministradas, hacia abajo y hacia la derecha
     * @param row index de la fila de inicio
     * @param col index de la columna de inicio
     * @return diagonal hacia abajo y hacia la derecha
     */
    private List<Integer> getRightDiag(int row, int col){
        List<Integer> newDiag = new ArrayList<Integer>();
        while (row < rows && col < cols){
            newDiag.add(brd[row][col]);
            row++;
            col++;
        }
        return newDiag;
    }

    /**
     * Método que obtiene la diagonal desde la fila y columna suministradas, hacia abajo y hacia la izquierda
     * @param row index de la fila de inicio
     * @param col index de la columna de inicio
     * @return diagonal hacia abajo y hacia la izquierda
     */
    private List<Integer> getLeftDiag(int row, int col){
        List<Integer> newDiag = new ArrayList<Integer>();
        int aux = row;
        while (row < rows && col >= 0){
            newDiag.add(brd[row][col]);
            row++;
            col--;
        }
        return newDiag;
    }

    /**
     * Método que verifica si existe un ganador diagonal en el tablero
     * @return id del color del ganador diagonal | 0
     */
    public int diagonalCheck(){
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                List<Integer> rightDiag = getRightDiag(i, j);
                if (singleRowCheck(rightDiag) != 0){
                    return singleRowCheck(rightDiag);
                }
                List<Integer> leftDiag = getLeftDiag(i, j);
                if (singleRowCheck(leftDiag) != 0){
                    return singleRowCheck(leftDiag);
                }
            }
        }
        return 0;
    }

    /**
     * Método que obtiene el ganador en el tablero
     * @return id del color del ganador | 0
     */
    public int getWinner(){
        if (horizontalCheck() != 0){
            return horizontalCheck();
        }
        if (verticalCheck() != 0){
            return verticalCheck();
        }
        return diagonalCheck();
    }

    /**
     * Método que obtiene obtiene el contenido de una columna de la primera fila
     * @param col index de la columna
     * @return contenido del tablero en la primera fila y la columna suministrada
     */
    public int getFirstRowPos(int col){
        return brd[0][col];
    }
}
