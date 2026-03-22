package br.com.locacao.model;

public class Espaco {
    private int id;
    private int sindicoId;
    private String nome;
    private String descricao;
    private int capacidadeMaxima;
    private double valorHora;
    private String status;

    public Espaco() {}

    public int getId() { return id; }
    public int getSindicoId() { return sindicoId; }
    public String getNome() { return nome; }
    public String getDescricao() { return descricao; }
    public int getCapacidadeMaxima() { return capacidadeMaxima; }
    public double getValorHora() { return valorHora; }
    public String getStatus() { return status; }

    public void setId(int id) { this.id = id; }
    public void setSindicoId(int sindicoId) { this.sindicoId = sindicoId; }
    public void setNome(String nome) { this.nome = nome; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public void setCapacidadeMaxima(int capacidadeMaxima) { this.capacidadeMaxima = capacidadeMaxima; }
    public void setValorHora(double valorHora) { this.valorHora = valorHora; }
    public void setStatus(String status) { this.status = status; }
}