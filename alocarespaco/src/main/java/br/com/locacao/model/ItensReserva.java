package br.com.locacao.model;

public class ItensReserva {
    private int id;
    private int sindicoId;
    private int reservaId;
    private int servicoId;
    private String servicoNome;
    private int quantidade;
    private double valorUnitario;

    public ItensReserva() {}

    public int getId() { return id; }
    public int getSindicoId() { return sindicoId; }
    public int getReservaId() { return reservaId; }
    public int getServicoId() { return servicoId; }
    public String getServicoNome() { return servicoNome; }
    public int getQuantidade() { return quantidade; }
    public double getValorUnitario() { return valorUnitario; }
    public double getSubtotal() { return quantidade * valorUnitario; }

    public void setId(int id) { this.id = id; }
    public void setSindicoId(int sindicoId) { this.sindicoId = sindicoId; }
    public void setReservaId(int reservaId) { this.reservaId = reservaId; }
    public void setServicoId(int servicoId) { this.servicoId = servicoId; }
    public void setServicoNome(String servicoNome) { this.servicoNome = servicoNome; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
    public void setValorUnitario(double valorUnitario) { this.valorUnitario = valorUnitario; }
}