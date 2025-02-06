package org.palaciosalfonso.lab3;

public class Player_RUT_PalaciosVergara extends TDAPlayer_RUT_PalaciosVergara {

    /**
     * Método constructor del jugador
     * @param id ID del jugador
     * @param name nombre del jugador
     * @param clr color del jugador
     */
    public Player_RUT_PalaciosVergara(int id, String name, String clr) {
        super(id, name, clr);
    }

    /**
     * Método que crea una pieza
     * @param clr color de la pieza
     * @return pieza
     */
    public int Piece(String clr){
        if (clr.equalsIgnoreCase("red")){
            return 1;
        }else {
            return 2;
        }
    }

    /**
     * Método que obtiene el ID del jugador
     * @return ID del jugador
     */
    public int getID() { return id; }

    /**
     * Método que obtiene el nombre del jugador
     * @return nombre del jugador
     */
    public String getName() {
        return name;
    }

    /**
     * Método que obtiene el id del color del jugador ("red" = 1; "yellow" = 2)
     * @return id del color del jugador
     */
    public int getClr() {
        return clr;
    }

    /**
     * Método que obtiene el color del jugador
     * @return (String) color del jugador
     */
    public String getClrStr(){
        if (this.clr == 1){
            return "red";
        }else{
            return "yellow";
        }
    }

    /**
     * Método que obtiene la cantidad de victorias del jugador
     * @return cantidad de victorias del jugador
     */
    public int getWs() { return ws; }

    /**
     * Método que obtiene la cantidad de derrotas del jugador
     * @return cantidad de derrotas del jugador
     */
    public int getLs() { return ls; }

    /**
     * Método que obtiene la cantidad de empates del jugador
     * @return cantidad de empates del jugador
     */
    public int getDrws() { return drws; }

    /**
     * Método que obtiene la cantidad de piezas que el jugador posee
     * @return cantidad de piezas del jugador
     */
    public int getRpcs() {
        return rpcs;
    }

    /**
     * Método que incrementa la cantidad de victorias del jugador
     */
    public void incrementWs() {
        this.ws++;
    }

    /**
     * Método que incrementa la cantidad de derrotas del jugador
     */
    public void incrementLs() {
        this.ls++;
    }

    /**
     * Método que incrementa la cantidad de empates del jugador
     */
    public void incrementDrws() {
        this.drws++;
    }

    /**
     * Método que disminuye la cantidad de piezas restantes del jugador
     */
    public void decrementRpcs() {
        this.rpcs--;
    }

    /**
     * Método que incrementa las estadísticas del jugador
     * @param WLD parámetro que indica qué estadística incrementar (0 = empates, 1 = derrotas, 2 = victorias)
     */
    public void updatePlyrStats(int WLD){
        if(WLD == 2){
            incrementWs();
        }
        if(WLD == 1){
            incrementLs();
        }
        if(WLD == 0){
            incrementDrws();
        }
    }

    /**
     * Método que restaura la cantidad de piezas del jugador a 21
     */
    public void resetRpcs(){
        this.rpcs = 21;
    }
}
