package org.palaciosalfonso.lab3;

public abstract class TDAPlayer_RUT_PalaciosVergara {
    protected final int id;
    protected final String name;
    protected final int clr;
    protected int ws;
    protected int ls;
    protected int drws;
    protected int rpcs;

    public TDAPlayer_RUT_PalaciosVergara(int id, String name, String clr) {
        this.id = id;
        this.name = name;
        this.clr = Piece(clr);
        this.ws = 0;
        this.ls = 0;
        this.drws = 0;
        this.rpcs = 21;
    }

    protected abstract int Piece(String clr);

    protected abstract void updatePlyrStats(int WLD);

}
