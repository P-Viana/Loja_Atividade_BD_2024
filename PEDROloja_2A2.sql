create database loja_2A2;
use loja_2A2;

-- CRIE A TABELA PRODUTOS COM OS CAMPOS (id_prod, descricao, valor, categoria)
create table produtos (
	id_prod int primary key not null auto_increment,
    descricao varchar(100),
    valor float,
    categoria varchar(50)
);
desc produtos;
-- INSIRA 5 REGISTROS NA TABELA produtos
INSERT INTO produtos (descricao, valor, categoria)
VALUES 	('Iphone19', 15641.10, 'Tecnologia'),
		('Teclado', 150, 'Tecnologia'),
        ('Monitor', 641.05, 'Tecnologia'),
        ('Batata Chips', 41, 'Alimentação'),
        ('Coca-cola 2L', 9, 'Alimentação');
SELECT * FROM produtos;
-- CRIE A TABELA CLIENTES COM OS CAMPOS (id_cli, nome, cidade, estado, data_nascimento)
create table clientes (
	id_cli int primary key not null auto_increment,
    nome varchar(100),
    cidade varchar(100),
    estado char(2),
    data_nascimento date
);
desc clientes;
-- INSIRA 5 REGISTROS NA TABELA clientes
INSERT INTO clientes (nome, cidade, estado, data_nascimento)
VALUES 	('Ana','Belo Horizonte', 'MG', '2005-03-16'),
		('BErnardo','Ipatinga', 'MG', '2007-09-16'),
        ('Clara','Valadolares', 'MG', '2006-08-16'),
        ('Diego','Quixeramobim', 'CE', '2007-12-16'),
        ('Natalina','Contagem', 'MG', '2004-12-25');

SELECT * FROM clientes;
-- CRIE A TABELA VENDAS COM OS CAMPOS (id_vend, data_venda, id_prod, id_cli)
create table vendas (
	id_vend int primary key not null auto_increment,
    data_venda date,
    id_prod int,
    id_cli int,
    foreign key (id_prod) references produtos (id_prod),
    foreign key (id_cli) references clientes (id_cli)
);
desc vendas;
-- INSIRA 5 REGISTROS NA TABELA vendas
INSERT INTO vendas (data_venda, id_prod, id_cli)
VALUES 	('2024-09-01', 2, 2),
		('2024-09-01', 3, 1),
        ('2024-09-01', 2, 2),
        ('2024-09-02', 9, 10),
        ('2024-09-01', 4, 1);
SELECT * FROM vendas;        
-- ATUALIZAR A VENDA 4 PARA PRODUTO E CLIENTE EXISTENTES
UPDATE vendas SET id_prod = 2, id_cli = 3 WHERE id_vend = 4;
show tables;
SELECT * FROM clientes;
UPDATE clientes SET nome = 'Cairo' WHERE id_cli = 3;
UPDATE clientes SET nome = 'Diana' WHERE id_cli = 4;
UPDATE clientes SET nome = 'Ellen' WHERE id_cli = 5;
SELECT * FROM produtos;
UPDATE produtos SET descricao = 'Mouse', valor = 5 WHERE id_prod = 1;
UPDATE produtos SET valor = 100 WHERE id_prod = 2;
UPDATE produtos SET descricao = 'PC Game', valor = 7000 WHERE id_prod = 3;
UPDATE produtos SET descricao = 'Monitor', valor = 600 WHERE id_prod = 4;
UPDATE produtos SET descricao = 'Iphone', valor = 18000 WHERE id_prod = 5;
SELECT * FROM vendas;
truncate table vendas;
alter table vendas add quantidade_prod int after id_prod;
INSERT INTO vendas (data_venda, quantidade_prod, id_prod, id_cli)
VALUES 	('2024-09-01', 2, 1, 1),
		('2024-09-02', 1, 1, 3),
        ('2024-09-02', 3, 2, 5),
        ('2024-09-03', 5, 4, 4),
        ('2024-09-10', 2, 4, 4),
        ('2024-10-10', 1, 3, 1),
        ('2024-10-10', 3, 1, 4),
        ('2024-10-15', 5, 2, 5),
        ('2024-10-16', 5, 10, 1),
        ('2024-10-17', 5, 15, 5),
        ('2024-10-17', 1, 1, 3);
-- QUESTÃO 1: Liste o nome do Cliente e o total que ele comprou
select c.nome, SUM(p.valor * v.quantidade_prod) as total_compras from vendas v join clientes c on v.id_cli = c.id_cli join produtos p  on v.id_prod = p.id_prod group by c.nome;
-- QUESTÃO 2: Qual é o nome do produto mais vendido?
select p.descricao, sum(v.quantidade_prod) as total_vendido from vendas v join produtos p on v.id_prod = p.id_prod group by p.descricao order by total_vendido desc limit 1;
-- QUESTÃO 3: Qual foi o dia da maior venda? Quem realizou a compra e qual foi o produto?
select v.data_venda, c.nome , p.descricao, sum(v.quantidade_prod) as total_vendido from vendas v join clientes c on v.id_cli = c.id_cli join produtos p on v.id_prod = p.id_prod group by v.data_venda, c.nome, p.descricao order by total_vendido desc limit 1;