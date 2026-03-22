package br.com.locacao.model;

public class Servico {
    private int id;
    private int sindicoId;
    private String nome;
    private String descricao;
    private int limiteQuantidade;
    private double valorUnitario;

    public Servico() {}

    public int getId() { return id; }
    public int getSindicoId() { return sindicoId; }
    public String getNome() { return nome; }
    public String getDescricao() { return descricao; }
    public int getLimiteQuantidade() { return limiteQuantidade; }
    public double getValorUnitario() { return valorUnitario; }

    public void setId(int id) { this.id = id; }
    public void setSindicoId(int sindicoId) { this.sindicoId = sindicoId; }
    public void setNome(String nome) { this.nome = nome; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public void setLimiteQuantidade(int limiteQuantidade) { this.limiteQuantidade = limiteQuantidade; }
    public void setValorUnitario(double valorUnitario) { this.valorUnitario = valorUnitario; }
}