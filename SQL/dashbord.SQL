CREATE DATABASE db_dashboard COLLATE UTF8_UNICODE_CI;

USE db_dashboard;

CREATE TABLE tb_vendas (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
	total FLOAT(10,2) NOT NULL
);

CREATE TABLE tb_clientes(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	cliente_ativo BOOLEAN default true
);

CREATE TABLE tb_contatos(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	tipo_contato int NOT NULL
);

CREATE TABLE tb_despesas(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	data_despesa DATETIME DEFAULT CURRENT_TIMESTAMP,
	total FLOAT(10,2) NOT NULL
);

INSERT INTO tb_vendas(data_venda, total) VALUES('2018-08-15', 150.20);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-08-16', 255.36);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-08-18', 70.95);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-09-01', 35.00);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-09-11', 2047.12);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-09-19', 122.85);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-09-23', 957.14);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-10-01', 333.55);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-10-02', 100.33);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-10-03', 1853.12);
INSERT INTO tb_vendas(data_venda, total) VALUES('2018-10-04', 47.47);

INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(false);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(false);
INSERT INTO tb_clientes(cliente_ativo) VALUES(false);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);
INSERT INTO tb_clientes(cliente_ativo) VALUES(false);
INSERT INTO tb_clientes(cliente_ativo) VALUES(true);

INSERT INTO tb_contatos(tipo_contato) VALUES(1);
INSERT INTO tb_contatos(tipo_contato) VALUES(1);
INSERT INTO tb_contatos(tipo_contato) VALUES(2);
INSERT INTO tb_contatos(tipo_contato) VALUES(1);
INSERT INTO tb_contatos(tipo_contato) VALUES(3);
INSERT INTO tb_contatos(tipo_contato) VALUES(2);
INSERT INTO tb_contatos(tipo_contato) VALUES(1);
INSERT INTO tb_contatos(tipo_contato) VALUES(1);
INSERT INTO tb_contatos(tipo_contato) VALUES(3);
INSERT INTO tb_contatos(tipo_contato) VALUES(3);
INSERT INTO tb_contatos(tipo_contato) VALUES(3);
INSERT INTO tb_contatos(tipo_contato) VALUES(1);
INSERT INTO tb_contatos(tipo_contato) VALUES(2);
INSERT INTO tb_contatos(tipo_contato) VALUES(2);
INSERT INTO tb_contatos(tipo_contato) VALUES(1);

INSERT INTO tb_despesas(data_despesa, total) VALUES('2018-08-20', 93.47);
INSERT INTO tb_despesas(data_despesa, total) VALUES('2018-09-01', 350.27);
INSERT INTO tb_despesas(data_despesa, total) VALUES('2018-09-04', 108.12);
INSERT INTO tb_despesas(data_despesa, total) VALUES('2018-09-20', 15.66);
INSERT INTO tb_despesas(data_despesa, total) VALUES('2018-10-03', 83.55);

CREATE USER 'usr_dashboard'@'localhost' IDENTIFIED BY 'zAk0@.;99lQ';
GRANT ALL PRIVILEGES ON db_dashboard.* TO 'usr_dashboard'@'localhost';