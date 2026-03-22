SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS sistema_locacao;
CREATE DATABASE sistema_locacao CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sistema_locacao;

CREATE TABLE sindico (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  nome  VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cliente (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  sindico_id INT          NOT NULL,
  nome       VARCHAR(100) NOT NULL,
  cpf        VARCHAR(14)  NOT NULL UNIQUE,
  telefone   VARCHAR(20),
  email      VARCHAR(100) NOT NULL UNIQUE,
  endereco   VARCHAR(255),
  senha      VARCHAR(100) NOT NULL,
  FOREIGN KEY (sindico_id) REFERENCES sindico(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE espaco (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  sindico_id        INT          NOT NULL,
  nome              VARCHAR(100) NOT NULL,
  descricao         VARCHAR(255),
  capacidade_maxima INT,
  valor_hora        DECIMAL(10,2),
  status            VARCHAR(20)  DEFAULT 'disponivel',
  FOREIGN KEY (sindico_id) REFERENCES sindico(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE servico (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  sindico_id        INT          NOT NULL,
  nome              VARCHAR(100) NOT NULL,
  descricao         VARCHAR(255),
  limite_quantidade INT,
  valor_unitario    DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (sindico_id) REFERENCES sindico(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE reserva (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  sindico_id     INT          NOT NULL,
  cliente_id     INT          NOT NULL,
  espaco_id      INT          NOT NULL,
  data_evento    DATE         NOT NULL,
  horario_inicio TIME         NOT NULL,
  horario_fim    TIME         NOT NULL,
  num_convidados INT,
  decoracao      TINYINT(1)   DEFAULT 0,
  valor_total    DECIMAL(10,2),
  status         VARCHAR(20)  DEFAULT 'pendente',
  FOREIGN KEY (sindico_id) REFERENCES sindico(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE,
  FOREIGN KEY (espaco_id)  REFERENCES espaco(id)  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE itens_reserva (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  sindico_id     INT          NOT NULL,
  reserva_id     INT          NOT NULL,
  servico_id     INT          NOT NULL,
  quantidade     INT          DEFAULT 1,
  valor_unitario DECIMAL(10,2),
  FOREIGN KEY (sindico_id) REFERENCES sindico(id),
  FOREIGN KEY (reserva_id) REFERENCES reserva(id)  ON DELETE CASCADE,
  FOREIGN KEY (servico_id) REFERENCES servico(id)  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO sindico (nome, email, senha) VALUES
('Admin Síndico', 'sindico@email.com', '123456');

INSERT INTO cliente (sindico_id, nome, cpf, telefone, email, endereco, senha) VALUES
(1, 'João Silva',   '123.456.789-00', '(71) 98765-4321', 'joao@email.com',  'Rua A, 123 - Camaçari', '123456'),
(1, 'Maria Santos', '987.654.321-00', '(71) 99876-5432', 'maria@email.com', 'Av. B, 456 - Camaçari',  '123456');

INSERT INTO espaco (sindico_id, nome, descricao, capacidade_maxima, valor_hora, status) VALUES
(1, 'Salão de Festas',      'Salão principal para eventos',      100, 100.00, 'disponivel'),
(1, 'Churrasqueira',        'Área de churrasqueira com mesas',    30,  50.00, 'disponivel'),
(1, 'Piscina',              'Área de lazer com piscina',          50,  80.00, 'disponivel'),
(1, 'Quadra Poliesportiva', 'Quadra para esportes',               20,  40.00, 'disponivel');

INSERT INTO servico (sindico_id, nome, descricao, limite_quantidade, valor_unitario) VALUES
(1, 'Buffet Completo',   'Variedade de pratos quentes e frios', 100,  50.00),
(1, 'Bebidas',           'Refrigerantes e sucos',               200,  10.00),
(1, 'Decoração Simples', 'Decoração básica do ambiente',          1, 150.00),
(1, 'Som e Iluminação',  'Equipamento de som profissional',       1, 300.00);

SET FOREIGN_KEY_CHECKS = 1;