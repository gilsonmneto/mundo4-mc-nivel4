--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cria tabela Motoristas
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    Nome VARCHAR(100),
    CNH VARCHAR(20),
    Endereço VARCHAR(200),
    Contato VARCHAR(50)
);
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cria tabela Clientes
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Empresa VARCHAR(100),
    Endereço VARCHAR(200),
    Contato VARCHAR(50)
);
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cria tabela Pedidos
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ClientID INT,
    DriverID INT,
    DetalhesPedido TEXT,
    DataEntrega DATE,
    Status VARCHAR(50),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Insere dados na tabela Drivers
INSERT INTO Drivers (DriverID, Nome, CNH, Endereço, Contato) VALUES
(1, 'João Silva', 'AB123456', 'Rua das Flores, 10, Centro, Sabará', '31-99999-1111'),
(2, 'Maria Santos', 'AC234567', 'Av. Brasil, 20, Jardim, Sabará', '31-88888-2222'),
(3, 'Pedro Oliveira', 'AD345678', 'Praça da Liberdade, 30, Belo Horizonte', '31-77777-3333'),
(4, 'Ana Souza', 'AE456789', 'Rua da Paz, 40, Nova Lima', '31-66666-4444'),
(5, 'Carlos Costa', 'AF567890', 'Av. Contorno, 50, Contagem', '31-55555-5555');
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Insere dados na tabela Clients
INSERT INTO Clients (ClientID, Nome, Empresa, Endereço, Contato) VALUES
(1, 'José Alves', 'ABC Ltda.', 'Rua do Sol, 100, Centro, Sabará', '31-44444-6666'),
(2, 'Mariana Rocha', 'DEF S.A.', 'Av. Tiradentes, 200, Jardim, Sabará', '31-33333-7777'),
(3, 'Paulo Lima', 'GHI EPP', 'Praça da Estação, 300, Belo Horizonte', '31-22222-8888'),
(4, 'Luciana Dias', 'JKL MEI', 'Rua da Esperança, 400, Nova Lima', '31-11111-9999'),
(5, 'Ricardo Gomes', 'MNO EIRELI', 'Av. Amazonas, 500, Contagem', '31-00000-0000');
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Insere dados na tabela Orders
INSERT INTO Orders (OrderID, ClientID, DriverID, DetalhesPedido, DataEntrega, Status) VALUES
(1, 1, 1, 'Entregar 10 caixas de papel A4 na empresa ABC Ltda.', '2024-03-01', 'Pendente'),
(2, 2, 2, 'Retirar 5 sacos de lixo reciclável na empresa DEF S.A.', '2024-03-02', 'Pendente'),
(3, 3, 3, 'Levar 3 funcionários da empresa GHI EPP para o aeroporto', '2024-03-03', 'Pendente'),
(4, 4, 4, 'Buscar 2 encomendas na empresa JKL MEI e entregar em outro endereço', '2024-03-04', 'Pendente'),
(5, 5, 5, 'Transportar 1 máquina de lavar da empresa MNO EIRELI para o depósito', '2024-03-05', 'Pendente');
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recuperar os nomes e endereços dos clientes que têm pedidos pendentes
SELECT C.Nome, C.Endereço FROM Clients C
JOIN Orders O ON C.ClientID = O.ClientID
WHERE O.Status = 'Pendente';
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recuperar os nomes e as CNHs dos motoristas que têm pedidos concluídos
SELECT D.Nome, D.CNH FROM Drivers D
JOIN Orders O ON D.DriverID = O.DriverID
WHERE O.Status = 'Concluído';
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Atualizar o status das Orders 2 e 4 para 'Concluído'
UPDATE Orders SET Status = 'Concluído' WHERE OrderID IN (2, 4);
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recuperar os nomes e as CNHs dos motoristas que têm pedidos concluídos
SELECT D.Nome, D.CNH FROM Drivers D
JOIN Orders O ON D.DriverID = O.DriverID
WHERE O.Status = 'Concluído';
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recuperar os detalhes dos pedidos que têm data de entrega entre 2024-03-01 e 2024-03-05 e ordenar por data de entrega
SELECT DetalhesPedido FROM Orders WHERE DataEntrega BETWEEN '2024-03-01' AND '2024-03-05' ORDER BY DataEntrega;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recuperar os detalhes dos pedidos que estão pendentes entre 2024-03-02 e 2024-03-04 incluindo o nome dos motoristas e clientes e o endereço do cliente
-- Seleciona os campos desejados das tabelas Orders, Drivers e Clients
SELECT Orders.OrderID, Orders.DetalhesPedido, Orders.DataEntrega, Orders.Status, Drivers.Nome AS NomeMotorista, Clients.Nome AS NomeCliente, Clients.Endereço AS EndereçoCliente
-- Junta as tabelas Orders, Drivers e Clients usando as chaves estrangeiras
FROM Orders
JOIN Drivers ON Orders.DriverID = Drivers.DriverID
JOIN Clients ON Orders.ClientID = Clients.ClientID
-- Filtra os pedidos que estão pendentes e cuja data de entrega está entre 2024-03-02 e 2024-03-04
WHERE Orders.Status = 'Pendente' AND Orders.DataEntrega BETWEEN '2024-03-02' AND '2024-03-04';
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recuperar os nomes dos clientes, dos motoristas e os status dos pedidos que envolvem a empresa ABC Ltda.
SELECT C.Nome AS NomeCliente, D.Nome AS NomeMotorista, O.Status AS StatusPedido FROM Orders O
JOIN Clients C ON O.ClientID = C.ClientID
JOIN Drivers D ON O.DriverID = D.DriverID
WHERE C.Empresa = 'ABC Ltda.';
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Criar um novo pedido com o OrderID = 6, ClientID = 2, DriverID = 4, DetalhesPedido = 'Entregar 20 garrafas de água na empresa DEF S.A.', DataEntrega = '2024-03-06', Status = 'Pendente'
INSERT INTO Orders (OrderID, ClientID, DriverID, DetalhesPedido, DataEntrega, Status) VALUES
(6, 2, 4, 'Entregar 20 garrafas de água na empresa DEF S.A.', '2024-03-06', 'Pendente');
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ler os dados do pedido com o OrderID = 6
SELECT * FROM Orders WHERE OrderID = 6;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Atualizar o nome do cliente com o ClientID = 3 para 'Paulo Ribeiro'
SELECT * FROM Clients WHERE ClientID = 3;
GO
UPDATE Clients SET Nome = 'Paulo Ribeiro' WHERE ClientID = 3;
SELECT * FROM Clients WHERE ClientID = 3;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRUD para tabela Drivers:
-- Lista todos os registros.
SELECT * FROM Drivers;
GO

-- INSERT: Este comando insere um novo registro na tabela Drivers.
INSERT INTO Drivers (DriverID, Nome, CNH, Endereço, Contato) VALUES (6, 'Luís Ferreira', 'AG678901', 'Rua do Ouro, 60, Ouro Preto', '31-99999-0000');
SELECT * FROM Drivers;
GO

-- UPDATE: Este comando altera o valor do campo Nome do registro com DriverID = 6 na tabela Drivers.
UPDATE Drivers SET Nome = 'Luís Alberto' WHERE DriverID = 6;
SELECT * FROM Drivers;
GO

-- DELETE: Este comando exclui o registro com DriverID = 6 da tabela Drivers.
DELETE FROM Drivers WHERE DriverID = 6;
SELECT * FROM Drivers;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRUD para tabela Clients:
-- Lista todos os registros.
SELECT * FROM Clients;
GO

-- INSERT: Este comando insere um novo registro na tabela Clients.
INSERT INTO Clients (ClientID, Nome, Empresa, Endereço, Contato) VALUES (6, 'Fernanda Costa', 'PQR Ltda.', 'Av. Afonso Pena, 600, Belo Horizonte', '31-88888-0000');
SELECT * FROM Clients;
GO

-- UPDATE: Este comando altera o valor do campo Empresa do registro com ClientID = 6 na tabela Clients.
UPDATE Clients SET Empresa = 'XYZ S.A.' WHERE ClientID = 6;
SELECT * FROM Clients;
GO

-- DELETE: Este comando exclui o registro com ClientID = 6 da tabela Clients.
DELETE FROM Clients WHERE ClientID = 6;
SELECT * FROM Clients;
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRUD para tabela Orders:
-- Lista todos os registros.
SELECT * FROM Orders;
GO

-- INSERT: Este comando insere um novo registro na tabela Orders.
INSERT INTO Orders (OrderID, ClientID, DriverID, DetalhesPedido, DataEntrega, Status) VALUES (7, 5, 5, 'Entregar 20 livros na empresa PQR Ltda.', '2024-03-06', 'Pendente');
SELECT * FROM Orders;
GO

-- UPDATE: Este comando altera o valor do campo Status do registro com OrderID = 7 na tabela Orders.
UPDATE Orders SET Status = 'Concluído' WHERE OrderID = 7;
SELECT * FROM Orders;
GO

-- DELETE: Este comando exclui o registro com OrderID = 7 da tabela Orders.
DELETE FROM Orders WHERE OrderID = 7;
SELECT * FROM Orders;
GO
