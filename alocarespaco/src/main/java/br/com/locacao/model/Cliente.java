package br.com.locacao.model;

public class Cliente {
    private int id;
    private int sindicoId;
    private String nome;
    private String cpf;
    private String telefone;
    private String email;
    private String endereco;
    private String senha;

    public Cliente() {}

    public int getId() { return id; }
    public int getSindicoId() { return sindicoId; }
    public String getNome() { return nome; }
    public String getCpf() { return cpf; }
    public String getTelefone() { return telefone; }
    public String getEmail() { return email; }
    public String getEndereco() { return endereco; }
    public String getSenha() { return senha; }

    public void setId(int id) { this.id = id; }
    public void setSindicoId(int sindicoId) { this.sindicoId = sindicoId; }
    public void setNome(String nome) { this.nome = nome; }
    public void setCpf(String cpf) { this.cpf = cpf; }
    public void setTelefone(String telefone) { this.telefone = telefone; }
    public void setEmail(String email) { this.email = email; }
    public void setEndereco(String endereco) { this.endereco = endereco; }
    public void setSenha(String senha) { this.senha = senha; }
}