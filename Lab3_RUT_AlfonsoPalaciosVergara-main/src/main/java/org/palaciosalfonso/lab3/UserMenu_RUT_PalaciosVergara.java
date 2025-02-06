package org.palaciosalfonso.lab3;

import java.util.Scanner;

public class UserMenu_RUT_PalaciosVergara {

    /**
     * Método que crea la interfaz grafica del jugador y la muestra por terminal, reacionando a los input del usuario
     * @param args
     */
    public static void Menu(String[] args) {
        Game_RUT_PalaciosVergara lastGame = null;
        Player_RUT_PalaciosVergara plyr1Stats = null;
        Player_RUT_PalaciosVergara plyr2Stats = null;
        int opcion;
        String nombre = null;
        String nombre2 = null;
        do {
            System.out.println("\n=============== CONNECT 4 ===============\n");
            System.out.println("OPCIONES:\n" +
                    "1.- Crear nuevo juego\n" +
                    "2.- Visualizar estadisticas\n" +
                    "3.- Visualizar tablero del juego anterior\n" +
                    "4.- Visualizar movimientos del juego anterior\n" +
                    "5.- Eliminar historial\n" +
                    "6.- Salir\n");
            Scanner sc = new Scanner(System.in);
            opcion = sc.nextInt();
            if (opcion == 1) {
                if (nombre == null && nombre2 == null) {
                    System.out.println("Ingrese el nombre del jugador 1: ");
                    nombre = sc.next();
                    System.out.println("Ingrese el nombre del jugador 2: ");
                    nombre2 = sc.next();
                }
                Player_RUT_PalaciosVergara plyr1 = new Player_RUT_PalaciosVergara(0, nombre, "red");
                Player_RUT_PalaciosVergara plyr2 = new Player_RUT_PalaciosVergara(1, nombre2, "yellow");
                Game_RUT_PalaciosVergara game = new Game_RUT_PalaciosVergara(plyr1, plyr2);
                boolean keepPlaying = true;
                while (keepPlaying) {
                    System.out.println("(TO EXIT: press 9)");
                    if (exitInput(sc, plyr1, game)) break;
                    if (game.brd.getWinner() != 0) {
                        System.out.println("\n[VICTORY]: " + plyr1.getName() + " GANA!!\n");
                        break;
                    }else if (game.isDraw()){
                        System.out.println("\n[DRAW]: ES UN EMPATE!\n");
                        break;
                    }
                    if (exitInput(sc, plyr2, game)) break;
                    if (game.brd.getWinner() != 0) {
                        System.out.println("\n[VICTORY]: " + plyr2.getName() + " GANA!!\n");
                        keepPlaying = false;
                    }else if (game.isDraw()){
                        System.out.println("\n[DRAW]: ES UN EMPATE!\n");
                        keepPlaying = false;
                    }
                }
                lastGame = game;
                plyr1Stats = updatePlyrStats(plyr1Stats, plyr1);
                plyr2Stats = updatePlyrStats(plyr2Stats, plyr2);
            }
            else if (opcion == 2) {
                if (plyr1Stats == null) {
                    System.out.println("No history");
                } else {
                    Game_RUT_PalaciosVergara aux = new Game_RUT_PalaciosVergara(plyr1Stats, plyr2Stats);
                    aux.printPlayers();
                    System.out.println("\n");
                }
            }
            else if (opcion == 3) {
                if (lastGame == null) {
                    System.out.println("No history");
                }else{
                    lastGame.boardGetState();
                }
            }
            else if (opcion == 4) {
                if (plyr1Stats == null) {
                    System.out.println("No history");
                }else{
                    lastGame.printHistory();
                }
            }
            else if (opcion == 5) {
                System.out.println("Historial eliminado!\n");
                lastGame = null;
                plyr1Stats = null;
                plyr2Stats = null;
                nombre = null;
                nombre2 = null;
            }else if (opcion >= 6 || opcion < 0){
                System.out.println("Exiting...");
            }
        } while (opcion < 6 && opcion > 0);
    }

    /**
     * Método que decide si el usuario desea volver al menú principal, toma los input de las columnas a jugar de los usuarios, realiza las jugadas y muestra el tablero por pantalla
     * @param sc variable scanner para obtener el input del usuario por terminal
     * @param plyr jugador que realiza la jugada
     * @param game juego actual
     * @return
     */
    private static boolean exitInput(Scanner sc, Player_RUT_PalaciosVergara plyr, Game_RUT_PalaciosVergara game) {
        int columna;
        System.out.println(plyr.getName() + ", ingrese la columna en la que desea jugar: ");
        columna = sc.nextInt();
        if (columna > 6 || columna < 0){
            return true;
        }
        if (game.brd.getFirstRowPos(columna) != 0){
            while (game.brd.getFirstRowPos(columna) != 0) {
                System.out.println("No se ha podido realizar el movimiento! Por favor, ingrese una columna valida: ");
                columna = sc.nextInt();
                if (columna > 6 || columna < 0){
                    return true;
                }
            }
        }
        game.play(plyr, columna);
        game.boardGetState();
        return false;
    }

    /**
     * Método que actualiza las estadísticas de los jugadores
     * @param plyrToUpdate jugador cuyas estadísticas deben ser actualizadas
     * @param plyrUpdating jugador en base al cual se actualizaran las estadísticas del jugador acorde
     * @return jugador con las estadísticas actualizadas
     */
    private static Player_RUT_PalaciosVergara updatePlyrStats(Player_RUT_PalaciosVergara plyrToUpdate, Player_RUT_PalaciosVergara plyrUpdating) {
        if (plyrToUpdate == null) {
            plyrToUpdate = plyrUpdating;
            plyrToUpdate.resetRpcs();
        }else{
            if (plyrUpdating.getWs() != 0) {
                plyrToUpdate.ws++;
            }
            if (plyrUpdating.getLs() != 0) {
                plyrToUpdate.ls++;
            }
            if (plyrUpdating.getDrws() != 0){
                plyrToUpdate.drws++;
            }
        }
        return plyrToUpdate;
    }
}
