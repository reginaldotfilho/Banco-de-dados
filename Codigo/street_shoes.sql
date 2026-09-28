create database street_shoes;

use street_shoes;

create table clientes (
codigo int auto_increment primary key,

nome varchar(50),

telefone varchar(20),

endereco varchar(50)
);

show tables;

describe clientes;

INSERT INTO clientes
(nome, telefone, endereco)
VALUES

('João',   '11999999999', 'Rua A'),

('Maria',  '11988888888', 'Rua B'),

('Pedro',  '11977777777', 'Rua C'),

('Ana',    '11966666666', 'Rua D'),

('Carlos', '11955555555', 'Rua E');

create table produtos(
codigo int auto_increment primary key,

nome varchar(20),

marca varchar(30),

tamanho int(30),

preco int(20)
);


insert into produtos (nome, marca, tamanho, preco) 
values

('Vapor Max', 'Nike', '40' , '999.00'),

('Air max 90', 'Nike' , '38' , '599.00'),

('Springblade' , 'Adidas' , '41' , '999.00'),

('Bounce' , 'Adidas' , '44' , '499.00'),

('Timberland' , 'Tirberland' , '34' , ' 1.200.00'),

('Puma Disk' , 'Puma' , '37' , ' 699.00');

select * from produtos;

create table vendas (
codigo int auto_increment primary key,

codigo_cliente INT NOT NULL,

codigo_produto int not null,

quantidade INT,

data_pedido datetime,

CONSTRAINT fk_vendas

FOREIGN KEY (codigo_cliente)

REFERENCES clientes(codigo),

CONSTRAINT fk_vendas_produtos

FOREIGN KEY (codigo_produto)

REFERENCES produtos(codigo)

);

describe vendas;

insert into vendas (codigo_cliente)
values
(99 );

INSERT INTO vendas (codigo_cliente, codigo_produto,quantidade, data_pedido)
values
(1,3,5,now()),
(1,2,2,now()),
(2,5,1,now()),
(3,6,2,now()),
(3,1,3,now()),
(4,4,2,now()),
(4,5,6,now()),
(5,1,1,now());

select * from vendas;

select * from produtos;

select * from clientes;

select * from produtos
where preco > 400;

select * from produtos
where preco < 400;

select * from vendas
where quantidade > 1;

select * from produtos
order by preco asc;

select * from produtos
order by preco desc;

select count(codigo_cliente)
from vendas;

select
	vendas.codigo_cliente,
    vendas.quantidade,
    clientes.nome
    from vendas
    join clientes on vendas.codigo_cliente = clientes.codigo;
    
    
    select
		vendas.codigo_cliente,
        vendas.quantidade,
        produtos.nome,
        produtos.marca
        from vendas
        join produtos on vendas.codigo_produto = produtos.codigo;
        
        select
			clientes.nome,
            produtos.nome,
            produtos.marca,
            vendas.quantidade
            from vendas
            join clientes on vendas.codigo_cliente = clientes.codigo
            join produtos on vendas.codigo_produto = produtos.codigo;
            
            select
				clientes.nome,
				produtos.nome,
                produtos.preco,
                vendas.quantidade
                
                from vendas
                join produtos on vendas.codigo_produto = produtos.codigo
                join clientes on vendas.codigo_cliente = clientes.codigo
                where codigo_cliente = 2 and preco > 399
                order by preco asc;
                
                
INSERT INTO clientes
(nome, telefone, endereco)
VALUES

('Reginaldo',   '11944444444', 'Rua F'),

('ryan',  '11933333333', 'Rua G'),

('Felippe',  '11922222222', 'Rua H'),

('Gabriel',    '11911111111', 'Rua I'),

('Gustavo', '11900000000', 'Rua J');

insert into produtos (nome, marca, tamanho, preco) 
values

('Air Max Fire', 'Nike', '44' , '899.00'),

('Pegasus 42', 'Nike' , '43' , '599.00'),

('Ultraboost 5' , 'Adidas' , '41' , '1.099.99'),

('530' , 'New Balance' , '45' , '749.90'),

('Gel-Nimbus 28' , 'Asics' , '36' , ' 1.200.00'),

('Fade' , 'Puma' , '37' , ' 799.99');
  
INSERT INTO vendas (codigo_cliente, codigo_produto, quantidade, data_pedido)
values
(1,8,1,now()),
(7,9,1,now()),
(6,10,1,now()),
(6,8,1,now()),
(8,1,1,now()),
(9,9,1,now()),
(10,6,1,now()),
(10,10,1,now()),
(3,6,1,now()),
(4,9,1,now()),
(9,2,1,now()),
(1,1,1,now());

select * from vendas;

select * from produtos;

select * from clientes;

select
	nome,
    marca,
    preco
    from produtos
    where preco > 600
    order by preco desc;
   
select 
	vendas.codigo_cliente,
    vendas.quantidade,
    clientes.nome,
    produtos.nome
    from vendas
    join clientes on vendas.codigo_cliente = clientes.codigo
    join produtos on vendas.codigo_produto = produtos.codigo
    where quantidade > 1;
    
select 
	clientes.nome,
    produtos.nome,
    produtos.preco,
    vendas.quantidade,
    produtos.preco*vendas.quantidade as valor_total
    from vendas
    join clientes on vendas.codigo_cliente = clientes.codigo
    join produtos on vendas.codigo_produto = produtos.codigo;
    
    select
		clientes.nome,
        produtos.nome,
        produtos.marca,
        vendas.quantidade,
        vendas.data_pedido
        from vendas
        join produtos on vendas.codigo_produto = produtos.codigo
        join clientes on vendas.codigo_cliente = clientes.codigo
        where codigo_cliente = 5;
        
        
        select
			clientes.nome,
            count(quantidade)
            from vendas
            join clientes on vendas.codigo_cliente = clientes.codigo
            group by clientes.nome;
            
            
		select
			clientes.nome,
            sum(produtos.preco*vendas.quantidade)
            from vendas
            join produtos on vendas.codigo_produto = produtos.codigo
            join clientes on vendas.codigo_cliente = clientes.codigo
            group by clientes.nome;
            
            
            select
				produtos.nome,
				sum(vendas.quantidade)
				from vendas
				join produtos on vendas.codigo_produto = produtos.codigo
				group by produtos.nome;
            
            
            select
			clientes.nome,
            sum(produtos.preco*vendas.quantidade) as valor_total
            from vendas
            join produtos on vendas.codigo_produto = produtos.codigo
            join clientes on vendas.codigo_cliente = clientes.codigo
            group by clientes.nome
            order by valor_total desc;
            
            
            select
				produtos.nome,
				sum(vendas.quantidade) as quantidade_total
				from vendas
				join produtos on vendas.codigo_produto = produtos.codigo
				group by produtos.nome
                order by total desc;
                
                select
					clientes.nome,
                    vendas.quantidade,
                    sum(vendas.quantidade) as total_itens_comprados,
                    sum(produtos.preco) as total_gasto
                    from vendas
                    join clientes on vendas.codigo_cliente = clientes.codigo
                    join produtos on vendas.codigo_produto = produtos.codigo
                    group by clientes.nome
                    order by total_gasto desc;
                    
                    
                    insert into produtos (nome, marca, tamanho, preco) 
					values

					('Air Max TN', 'Nike', '44' , '1.199.99');
                    
                    select * from produtos;
                    select * from clientes;
                    select * from vendas;
				
                    select
						produtos.nome,
                        vendas.quantidade
                        from vendas
                        right join produtos on vendas.codigo_produto = produtos.codigo
                        where quantidade is null;
                        
	INSERT INTO clientes(nome, telefone, endereco)
	VALUES
	('Anderson',   '11944444444', 'Rua g');
                        
	select
		clientes.nome,
		vendas.quantidade
		from vendas
		right join clientes on vendas.codigo_cliente = clientes.codigo
		where quantidade is null;
        
        
select
	clientes.nome,
	sum(produtos.preco*vendas.quantidade) as valor_total
	from vendas
	join produtos on vendas.codigo_produto = produtos.codigo
	join clientes on vendas.codigo_cliente = clientes.codigo
	group by clientes.nome
	order by valor_total desc
    limit 1;
		
   -- Desafio 3
   
	update vendas 
    set data_pedido = '2026-08-10' where codigo = 1;
   
	update vendas 
	set data_pedido = '2026-08-12' where codigo = 2;
   
     update vendas 
	 set data_pedido = '2026-08-13' where codigo = 3;
   
     update vendas 
	 set data_pedido = '2026-08-19' where codigo = 4;
	
     update vendas 
     set data_pedido = '2026-08-18' where codigo = 5;
   
     update vendas 
	 set data_pedido = '2026-08-11' where codigo = 6;
   
	update vendas 
	set data_pedido = '2026-08-14' where codigo = 7;
   
	update vendas 
	set data_pedido = '2026-08-20' where codigo = 8;
    
select * from vendas;
select * from produtos;
select * from clientes;
    
 select codigo, data_pedido
 from pedidos;
    
    
    
    
   
   
   
   
                   
                        
                
            
                
            
            
			
            
            
            
            
            
            
            
    
    
    