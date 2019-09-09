create table Livros(ISBN int primary key
	,estoque int
	,autor char(50)
	,titulo char(50)
	,ano int
	,custo real);
	
create table Pedidos( id_pedido int primary key
	,data_pedido char(10)
	,data_remessa char(10));
	
create table Clientes (id_cliente int primary key
	,nome char(50)
	,email char(50)
	,senha char(15));

create table Endereco(id_endereco int primary key
	,numero int
	,bairro char(50)
	,cidade char(50)
	,estado char(50)
	,rua char(50));
	
create table Itens_pedido(ISBN int
	,id_pedido int
	,quantidade int
	,valor_unitario real
	,primary key (ISBN,id_pedido)
	,foreign key(ISBN) references Livros(ISBN)
	,foreign key(id_pedido) references Pedidos(id_pedido));

create table Compra(id_pedido int
	,id_cliente int
	,primary key(id_pedido,id_cliente)
	,foreign key(id_cliente) references Clientes(id_cliente)
	,foreign key(id_pedido) references Pedidos(id_pedido));

create table Mora_em( id_cliente int
	,id_endereco int
	,primary key(id_cliente, id_endereco)
	,foreign key (id_endereco) references Endereco(id_endereco)on delete cascade
	,foreign key (id_cliente) references Clientes(id_cliente));