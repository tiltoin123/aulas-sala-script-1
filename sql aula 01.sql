create database ProgSCRIPT;
go
use ProgSCRIPT;

create table alunos(
	id int primary key ,
	nome varchar(255),
	idade int
)

SELECT *
FROM sys.tables;

EXEC sp_help 'dbo.alunos';  

insert into alunos (id,nome,idade) values(01,'mirosmar arioswaldo dragutino', 23)

insert into alunos (id,nome,idade) values(02,'vladislau pereira bananeira', 123),
(03,'jagutino lambari bananeira', 12)

select * from alunos;

select * from alunos where idade >= 20;

update alunos set idade = 20 where id =3;

create table Clientes(
ID_Cliente int primary key,
Nome_Cliente varchar(50),
Endereco_Cliente varchar(100));

create table Produtos(
ID_Produto int primary key,
Nome_Produto varchar(50),
Preco_Produto decimal(10,2)
);

create table Pedidos(
ID_Pedido int primary key,
ID_Cliente int,
Data_Pedido date,
foreign key(ID_Cliente) references Clientes(ID_Cliente)
);

create table ItensPedidos(
ID_Pedido int ,
ID_Produto int,
Quantidade int,
foreign key(ID_Pedido) references Pedidos(ID_Pedido),
foreign key(ID_Produto) references Produtos(ID_Produto),
);

INSERT INTO Clientes VALUES (1, 'Jo�o', 'Rua A, 123');
INSERT INTO Clientes VALUES (2, 'Maria', 'Rua B, 456');
INSERT INTO Clientes VALUES (3, 'Jos�', 'Rua C, 789');

INSERT INTO Produtos VALUES (1, 'Camiseta', 29.99);
INSERT INTO Produtos VALUES (2, 'Cal�a', 59.99);
INSERT INTO Produtos VALUES (3, 'T�nis', 99.99);

INSERT INTO Pedidos VALUES (1, 1, '2022-01-01');
INSERT INTO Pedidos VALUES (2, 2, '2022-01-02');
INSERT INTO Pedidos VALUES (3, 3, '2022-01-03');

INSERT INTO ItensPedidos VALUES (1, 1, 2);
INSERT INTO ItensPedidos VALUES (1, 2, 1);
INSERT INTO ItensPedidos VALUES (2, 2, 1);
INSERT INTO ItensPedidos VALUES (2, 3, 1);
INSERT INTO ItensPedidos VALUES (3, 1, 3);
INSERT INTO ItensPedidos VALUES (3, 3, 2);

-- Exemplos
-- Selecionar o nome e o endere�o de 
-- todos os clientes que j� fizeram um 
-- pedido na empresa
SELECT c.Nome_Cliente, c.Endereco_Cliente
FROM Clientes c
INNER JOIN Pedidos p ON c.ID_Cliente = p.ID_Cliente;

-- Selecione o nome do produto, o pre�o e a quantidade
-- de cada item de pedido feito em um pedido.
SELECT pr.Nome_Produto, pr.Preco_Produto, ip.Quantidade
FROM ItensPedidos ip
INNER JOIN Produtos pr ON pr.ID_Produto = ip.ID_Produto;

-- Listar todos os pedidos com seus respectivos 
-- clientes, mesmo que n�o tenham feito nenhum pedido.

SELECT * FROM Pedidos p
LEFT JOIN Clientes c ON p.ID_Cliente = c.ID_Cliente;

-- Listar todos os produtos com seus respectivos pedidos 
-- e quantidades, mesmo que n�o tenham sido pedidos.
SELECT * FROM Produtos p
LEFT JOIN ItensPedidos ip 
ON p.ID_Produto = ip.ID_Produto;

-- Listar todos os pedidos com seus respectivos 
-- clientes e produtos, mesmo que n�o tenham 
-- sido pedidos.

SELECT * FROM Pedidos p
LEFT JOIN Clientes c ON 
p.ID_Cliente = c.ID_Cliente
LEFT JOIN ItensPedidos ip ON 
p.ID_Pedido = ip.ID_Pedido
LEFT JOIN Produtos pr ON 
ip.ID_Produto = pr.ID_Produto;

-- Listar todos os clientes que n�o fizeram nenhum pedido.

SELECT *
FROM Clientes
LEFT JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
WHERE Pedidos.IdPedido IS NULL;

-- Listar todos os produtos que nunca foram pedidos.

SELECT *
FROM Produtos
LEFT JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto
WHERE ItensPedido.IdPedido IS NULL;

-- Retornar todos os pedidos, com seus respectivos clientes, mesmo que n�o haja um cliente correspondente:

SELECT *
FROM Pedidos
RIGHT JOIN Clientes ON Pedidos.IdCliente = Clientes.IdCliente;

-- Retornar todos os itens de pedido, com seus respectivos produtos, mesmo que n�o haja um produto correspondente:

SELECT *
FROM ItensPedido
RIGHT JOIN Produtos ON ItensPedido.IdProduto = Produtos.IdProduto;

-- Retornar todos os produtos, com seus respectivos itens de pedido, mesmo que n�o haja um item de pedido correspondente:

SELECT *
FROM Produtos
RIGHT JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto;

-- Retornar todos os clientes, com a soma total dos valores de seus pedidos:

SELECT Clientes.IdCliente, Clientes.NomeCliente, SUM(Produtos.PrecoProduto * ItensPedido.Quantidade) AS TotalGasto
FROM Clientes
RIGHT JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
RIGHT JOIN ItensPedido ON Pedidos.IdPedido = ItensPedido.IdPedido
RIGHT JOIN Produtos ON ItensPedido.IdProduto = Produtos.IdProduto
GROUP BY Clientes.IdCliente, Clientes.NomeCliente;

-- Retornar todos os pedidos, com seus respectivos itens de pedido e produtos, mesmo que n�o haja um produto ou item de pedido correspondente:

SELECT *
FROM Pedidos
RIGHT JOIN ItensPedido ON Pedidos.IdPedido = ItensPedido.IdPedido
RIGHT JOIN Produtos ON ItensPedido.IdProduto = Produtos.IdProduto;

-- Escreva uma consulta SQL que retorne os clientes e seus pedidos, incluindo aqueles que n�o possuem pedidos.

SELECT *
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente;

-- Escreva uma consulta SQL que retorne todos os produtos, seus pre�os e quantidades vendidas em pedidos, incluindo aqueles que n�o foram vendidos em nenhum pedido.

SELECT *
FROM Produtos
FULL OUTER JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto;

-- Escreva uma consulta SQL que retorne todos os clientes, seus pedidos e os produtos em cada pedido, incluindo aqueles que n�o possuem pedidos ou produtos.

SELECT *
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
FULL OUTER JOIN ItensPedido ON Pedidos.IdPedido = ItensPedido.IdPedido;

-- Escreva uma consulta SQL que retorne a quantidade total de cada produto vendido em pedidos, incluindo aqueles que n�o foram vendidos em nenhum pedido.

SELECT Produtos.IdProduto, Produtos.NomeProduto, COALESCE(SUM(ItensPedido.Quantidade), 0) AS QuantidadeVendida
FROM Produtos
FULL OUTER JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto
GROUP BY Produtos.IdProduto, Produtos.NomeProduto;

-- Escreva uma consulta SQL que retorne os clientes e seus pedidos, incluindo aqueles que n�o possuem pedidos, ordenados por nome do cliente e data do pedido.

SELECT *
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
ORDER BY Clientes.NomeCliente, Pedidos.DataPedido;
