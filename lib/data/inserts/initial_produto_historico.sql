CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    foto VARCHAR(255) NOT NULL,
    percentual_desconto DECIMAL(5,2) NOT NULL
);

CREATE TABLE resgate_cashback (
    id SERIAL PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    data_resgate TIMESTAMP NOT NULL,
    valor_resgate DECIMAL(10,2) NOT NULL
);

INSERT INTO produtos (id, nome, preco, foto, percentual_desconto) VALUES
    (1, 'Água', 3.50, 'agua.png', 0.5),
    (2, 'Biscoito', 8.90, 'biscoito.png', 1.5),
    (3, 'Café', 14.75, 'cafe.png', 2.0),
    (4, 'Carne', 999.99, 'carne.png', 5.0),
    (5, 'Coca Cola', 7.50, 'coca_cola.png', 1.0),
    (6, 'Frango', 24.90, 'frango.png', 3.5),
    (7, 'Iogurte', 34.90, 'iogurte.png', 1.2),
    (8, 'Lula', 45.99, 'lula.png', 6.0),
    (9, 'Mamão', 5.30, 'mamao.png', 1.0),
    (10, 'Ovo', 134.89, 'ovo.png', 2.5),
    (11, 'Pão Integral', 9.80, 'pao_integral.png', 1.8),
    (12, 'Salgadinho', 4.99, 'salgadinho.png', 1.0);

INSERT INTO resgate_cashback (categoria, data_resgate, valor_resgate) VALUES
    ('compra', NOW(), 75),
    ('compra', NOW(), 75);
