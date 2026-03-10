-- Cria o banco de dados para o cenário de E-commerce
create database ecommerce;

-- Seleciona o banco de dados recém-criado para uso
use ecommerce;

-- Cria a tabela de clientes com informações pessoais e restrição de CPF único
create table clients(
	idClient INT AUTO_INCREMENT,
	Fname VARCHAR(15),
	Minit VARCHAR(3),
	Lname VARCHAR(20),
	CPF CHAR(11) NOT NULL,
	Adress VARCHAR(30),
	CONSTRAINT unique_cpf_client UNIQUE (CPF),
	PRIMARY KEY(idClient)
);
                    
-- Altera o nome da coluna 'Adress' para 'Address' e aumenta o limite de caracteres
alter table clients change Adress Address VARCHAR(255);

-- Reinicia o contador de auto incremento da tabela de clientes
alter table clients auto_increment=1;

-- Exibe a estrutura atualizada da tabela de clientes
desc clients;

-- Cria a tabela de produtos com categorias pré-definidas (ENUM) e avaliação
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT,
	Pname VARCHAR(15) NOT NULL,
	Classification_kids BOOL DEFAULT FALSE,
	Category ENUM('Eletronico', 'Vestimenta', 'Brinquedos', 'Esportes', 'Alimentos','Veiculos') NOT NULL,
	Feedback FLOAT DEFAULT 0,
	Size VARCHAR(10),
	PRIMARY KEY(idProduct)
);

-- Reinicia o contador de auto incremento da tabela de produtos
alter table product auto_increment=1;
                    
-- Cria a tabela de pedidos vinculada a um cliente, com status e custo de frete
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT,
	idOrderClient INT,
	OrderStatus ENUM('Cancelado', 'Confirmado', 'Em Processamento') DEFAULT 'Em Processamento',
	OrderDescription VARCHAR(255),
	ShippingCost FLOAT DEFAULT 10,
	CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) references clients(idClient),
	PRIMARY KEY(idOrder)   
);
                    
-- Reinicia o contador de auto incremento da tabela de pedidos
alter table orders auto_increment=1;

-- Cria a tabela para gerenciar os locais de armazenamento (estoque) e quantidades
CREATE TABLE productStorage(
	idProdStorage INT AUTO_INCREMENT,
	StorageLocation VARCHAR(255),
	Quantity INT DEFAULT 0,
	PRIMARY KEY(idProdStorage)  
);

-- Reinicia o contador de auto incremento da tabela de estoque
alter table productStorage auto_increment=1;
                    
-- Cria a tabela de fornecedores com identificação por CNPJ único
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT,
	SocialName VARCHAR(255) NOT NULL,
	CNPJ CHAR(15) NOT NULL,
	Contact CHAR(11) not null,
	CONSTRAINT unique_supplier UNIQUE (CNPJ),
	PRIMARY KEY(idSupplier) 
);

-- Exibe a estrutura da tabela de fornecedores
desc supplier;

-- Reinicia o contador de auto incremento da tabela de fornecedores
alter table supplier auto_increment=1;
			
-- Cria a tabela de vendedores (terceiros/marketplace) com suporte a CNPJ ou CPF
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT,
	SocialName VARCHAR(255) NOT NULL,
	AbstName VARCHAR(255),
	CNPJ CHAR(15),
	CPF CHAR(9),
	Location VARCHAR(255),
	Contact CHAR(11) not null,
	CONSTRAINT unique_CNPJ_seller UNIQUE (CNPJ),
	CONSTRAINT unique_CPF_seller UNIQUE (CPF),
	PRIMARY KEY(idSeller) 
);
         
-- Reinicia o contador de auto incremento da tabela de vendedores
alter table seller auto_increment=1;

-- Tabela associativa entre Vendedor e Produto (Muitos-para-Muitos)
create table productSeller(
	idPseller INT,
	idPproduct INT,
	ProdQuantity INT DEFAULT 1,
	PRIMARY KEY (idPseller, idPproduct),
	CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
	CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES product(idProduct)
);
                            
-- Tabela associativa entre Produto e Pedido com controle de status de disponibilidade
create table productOrder(
	idPOproduct INT,
	idPOorder INT,
	PoQuantity INT DEFAULT 1,
	poStatus ENUM('Disponivel',  'Sem Estoque') DEFAULT 'Disponivel',
	PRIMARY KEY (idPOproduct, idPOorder),
	CONSTRAINT fk_productOrder_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
	CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

-- Tabela associativa para indicar em qual local de estoque cada produto se encontra
create table storeagelocation(
idLproduct INT,
idLstorage INT,
location VARCHAR(255) NOT NULL,
PRIMARY KEY (idLproduct, idLstorage),
CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);      
              
-- Tabela associativa entre Produto e Fornecedor			
create table ProductSupplier(
	idPsSupplier INT,
	idPsProduct INT,
	Quantity INT NOT NULL,
	PRIMARY KEY (idPsSupplier, idPsProduct),
	CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier),
	CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
);     

-- Lista todas as tabelas criadas no banco ecommerce
show tables;

-- Lista todos os bancos de dados disponíveis no servidor
show databases;

-- Acessa o banco de metadados do MySQL para consultar restrições
use information_schema;

-- Descreve a estrutura da tabela que armazena informações sobre chaves estrangeiras
desc referential_CONSTRAINTS;

-- Consulta todas as chaves estrangeiras criadas especificamente para o banco 'ecommerce'
select * from referential_constraints where CONSTRAINT_SCHEMA= 'ecommerce';
