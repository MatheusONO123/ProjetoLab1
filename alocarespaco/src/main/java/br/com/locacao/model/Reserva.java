package br.com.locacao.model;

public class Reserva {
    private int id;
    private int sindicoId;
    private int clienteId;
    private String clienteNome;
    private int espacoId;
    private String espacoNome;
    private String dataEvento;
    private String horarioInicio;
    private String horarioFim;
    private int numConvidados;
    private boolean decoracao;
    private double valorTotal;
    private String status;

    public Reserva() {}

    public int getId() { return id; }
    public int getSindicoId() { return sindicoId; }
    public int getClienteId() { return clienteId; }
    public String getClienteNome() { return clienteNome; }
    public int getEspacoId() { return espacoId; }
    public String getEspacoNome() { return espacoNome; }
    public String getDataEvento() { return dataEvento; }
    public String getHorarioInicio() { return horarioInicio; }
    public String getHorarioFim() { return horarioFim; }
    public int getNumConvidados() { return numConvidados; }
    public boolean isDecoracao() { return decoracao; }
    public double getValorTotal() { return valorTotal; }
    public String getStatus() { return status; }

    public void setId(int id) { this.id = id; }
    public void setSindicoId(int sindicoId) { this.sindicoId = sindicoId; }
    public void setClienteId(int clienteId) { this.clienteId = clienteId; }
    public void setClienteNome(String clienteNome) { this.clienteNome = clienteNome; }
    public void setEspacoId(int espacoId) { this.espacoId = espacoId; }
    public void setEspacoNome(String espacoNome) { this.espacoNome = espacoNome; }
    public void setDataEvento(String dataEvento) { this.dataEvento = dataEvento; }
    public void setHorarioInicio(String horarioInicio) { this.horarioInicio = horarioInicio; }
    public void setHorarioFim(String horarioFim) { this.horarioFim = horarioFim; }
    public void setNumConvidados(int numConvidados) { this.numConvidados = numConvidados; }
    public void setDecoracao(boolean decoracao) { this.decoracao = decoracao; }
    public void setValorTotal(double valorTotal) { this.valorTotal = valorTotal; }
    public void setStatus(String status) { this.status = status; }
}