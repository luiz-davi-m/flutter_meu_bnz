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

CREATE TABLE produto_promocao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    preco_promocao DECIMAL(10,2) NOT NULL,
    foto VARCHAR(255) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
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

INSERT INTO produto_promocao (id, nome, preco, preco_promocao, foto, categoria) VALUES
(1, 'Arroz Integral', 12.5, 10.9, 'arroz_integral.png', 'Alimento'),
(2, 'Leite Desnatado', 4.2, 3.75, 'leite_desnatado.png', 'Laticinios'),
(3, 'Maca Fuji', 3.75, 2.99, 'maca_fuji.png', 'Frutas'),
(4, 'Pao', 8.9, 7.2, 'pao.png', 'Padaria'),
(5, 'Patinho', 15.8, 13.9, 'patinho.png', 'Carnes'),
(6, 'Chocolate 70', 9.99, 7.8, 'chocolate_70.png', 'Alimento'),
(7, 'Shampoo Anticaspa', 18.5, 15.99, 'shampoo_anticaspa.png', 'Higiene'),
(8, 'Sabao em Barra', 12.3, 9.9, 'sabao_em_barra.png', 'Limpeza'),
(9, 'Cafe em Graos', 14.9, 12, 'cafe_graos.png', 'Bebidas'),
(10, 'Queijo Mussarela', 21.75, 18.5, 'queijo_mussarela.png', 'Laticinios'),
(11, 'Coca Cola Zero 2L', 8.99, 6.99, 'coca_cola_zero.png', 'Bebidas'),
(12, 'Pepsi 2L', 7.5, 5.99, 'pepsi.png', 'Bebidas'),
(13, 'Azeite de Oliva', 28.9, 24.9, 'azeite_oliva.png', 'Alimento'),
(14, 'Biscoito Recheado Chocolate', 3.99, 2.99, 'biscoito_recheado_chocolate.png', 'Alimento'),
(15, 'Sabonete Liquido', 6.8, 5.25, 'sabonete_liquido.png', 'Higiene'),
(16, 'Ovos Brancos', 10.5, 8.9, 'ovos_brancos.png', 'Mercearia'),
(17, 'Iogurte Natural', 5.25, 4.3, 'iogurte_natural.png', 'Laticinios'),
(18, 'Agua Mineral 500ml', 2.1, 1.69, 'agua_mineral.png', 'Bebidas'),
(19, 'Detergente Liquido', 2.99, 1.99, 'detergente_liquido.png', 'Limpeza'),
(20, 'Banana Prata', 4.3, 3.5, 'banana_prata.png', 'Frutas'),
(21, 'Margarina 500g', 7.8, 6.2, 'margarina.png', 'Laticinios'),
(22, 'Macarrao Espaguete', 3.5, 2.8, 'macarrao_espaguete.png', 'Alimento'),
(23, 'Papel Higienico 16rolos', 15.9, 12.9, 'papel_higienico.png', 'Higiene'),
(24, 'Molho de Tomate', 2.99, 1.99, 'molho_tomate.png', 'Alimento'),
(25, 'Desinfetante', 8.4, 6.99, 'desinfetante.png', 'Limpeza'),
(26, 'Sardinha em Lata', 5.6, 4.3, 'sardinha_lata.png', 'Alimento'),
(27, 'Barrinha de Cereal', 1.99, 1.49, 'barrinha_cereal.png', 'Alimento'),
(28, 'Creme Dental', 4.75, 3.9, 'creme_dental.png', 'Higiene'),
(29, 'Refrigerante Guarana 2L', 7.8, 5.99, 'guarana.png', 'Bebidas'),
(30, 'Fralda Descartavel', 45.9, 39.9, 'fralda_descartavel.png', 'Higiene');