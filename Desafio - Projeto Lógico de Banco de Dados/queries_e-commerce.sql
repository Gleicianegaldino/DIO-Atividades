-- Seleciona o banco de dados para iniciar a inserção dos dados
use ecommerce;



-- Cadastra novos clientes com dados fictícios variados
insert into clients(Fname, Minit, Lname, CPF, Address) 

    values ('Carlos','A','Oliveira', 11122233344, 'Rua das Flores 123, Curitiba - PR'),

           ('Ana','L','Macedo', 55566677788, 'Av. Paulista 1500, São Paulo - SP'),

           ('Bruno','R','Souza', 99988877766, 'Rua da Bahia 45, Belo Horizonte - MG'),

           ('Fernanda','K','Lima', 44433322211, 'Rua dos Coqueiros 78, Salvador - BA'),

           ('Tiago','P','Santos', 22233344455, 'Av. Beira Mar 900, Fortaleza - CE'),

           ('Mariana','C','Rocha', 88877766655, 'Rua General Osório 12, Porto Alegre - RS');



-- Cadastra produtos respeitando os nomes curtos e as categorias do ENUM
insert into product(Pname, Classification_kids, Category, Feedback, Size) 

    values ('Teclado RGB', false, 'Eletrônico', '5', null),

           ('Lego SW', true, 'Brinquedos', '5', null),

           ('Camiseta G', false, 'Vestimenta', '4', 'G'),

           ('Monitor 24', false, 'Eletrônico', '4', null),

           ('Urso Pelucia', true, 'Brinquedos', '3', '30x20'),

           ('Cafe 500g', false, 'Alimentos', '5', null),

           ('Fone BT', false, 'Eletrônico', '4', null);

        
           
-- Registra pedidos vinculados aos IDs de clientes existentes
-- O status 'default' aplicará o valor definido na criação da tabela
insert into orders (idOrderClient, OrderStatus, OrderDescription, ShippingCost)

    values (1, default, 'compra confirmada via app', 15.50),

           (2, default, 'pedido em separacao', 25.00),

           (3, 'Confirmado', 'entrega agendada', null),

           (5, 'Confirmado', 'compra site desktop', 10.00);



-- Relaciona produtos aos pedidos realizados
-- IDs 8, 11 e 13 referem-se aos produtos recém-criados; IDs 5, 6 e 7 aos novos pedidos
insert into productOrder(idPOproduct, idPOorder, poQuantity, poStatus) 

    values (8, 5, 1, null),

           (11, 6, 2, null),

           (13, 7, 5, null);



-- Define as unidades de armazenamento (estoques) em diferentes cidades
insert into productStorage (StorageLocation, Quantity) 

    values ('Curitiba', 200),

           ('São Paulo', 1500),

           ('Belo Horizonte', 300),

           ('Fortaleza', 450),

           ('Salvador', 120),

           ('Recife', 90);



-- Associa produtos específicos a um local de estoque físico
-- idLproduct 8 = Teclado; idLstorage 2 = São Paulo
insert into storeagelocation (idLproduct, idLstorage, location) 

    values (8, 2, 'SP'),

           (10, 1, 'PR');



-- Cadastra fornecedores com CNPJs únicos para evitar erro de duplicidade
insert into supplier (SocialName, CNPJ, contact) 

    values ('Logistica Express', 99888777000166, '11911112222'),

           ('Importadora Global', 55444333000122, '21933334444'),

           ('Distribuidora Sul', 22333444000155, '51955556666');



-- Cadastra vendedores do marketplace com documentos (CPF/CNPJ) dentro do limite de caracteres
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) 

    values ('Global Store', 'Global', 102030400, null, 'São Paulo', 119554433),

           ('Moda Express', 'Moda', null, 55544433, 'Rio de Janeiro', 219443322),

           ('Cantinho Kids', 'Kids', 90807060, null, 'Curitiba', 419332211);

           

-- Relaciona os vendedores aos produtos que eles disponibilizam
-- IDs 7, 8 e 9 referem-se aos vendedores cadastrados   
insert into productSeller (idPseller, idPproduct, prodQuantity) 

    values (7, 11, 50),

           (9, 9, 100),

           (8, 10, 30);