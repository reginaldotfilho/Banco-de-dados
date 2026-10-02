CREATE DATABASE japdv
DEFAULT CHARACTER SET UTF8
DEFAULT COLLATE UTF8_GENERAL_CI;

use japdv;

show tables;
 
 create table fornecedores (
 idFornecedor int auto_increment primary key,
 nome varchar(50) not null,
 fone varchar(20) not null,
 email varchar(50)
 );
 
 insert into fornecedores (nome, fone, email)
 values
 ('Kalunga', '119999-1111', 'kalunga@kalunga.com.br'),
 ('Tilibra', '119999-2222', 'vendas@tilibra.com.br');
 
 create table produtos (
 idProduto int auto_increment primary key,
 codigoBarras varchar(20)unique,
 descricao  varchar(100) not null,
 categoria varchar(50),
 precoCusto decimal(10,2)not null,
 precoVenda decimal(10,2) not null,
 quantidade int not null default 0,
 estoqueMinimo int not null default 0,
 idFornecedor int not null,

constraint fk_produtos
foreign key (idFornecedor)
references fornecedores(idFornecedor)
);

insert into produtos(codigoBarras, descricao, categoria,
 precoCusto,precoVenda, quantidade, estoqueMinimo, idFornecedor)
 values
 
 (789100000001, 'Caneta BIC Azul', 'Canetas', '1.50','3.00','50','10',1),
 (789100000002, 'Caneta BIC Vermelha', 'Canetas', '1.60','3.20','8','10',1),
 (789100000003, 'Caderno Universitario', 'Cadernos', '18.00','29.90','0','5',2),
 (789100000004, 'Régua 30 cm', 'Réguas', '5.00','10.00','15','5',1);
 
 create table vendas (
 idVenda int auto_increment primary key,
 dataVenda datetime,
 total decimal(10,2) not null
 );
 
create table itens_vendas (
idItem int auto_increment primary key,
idVenda int not null,
idProduto int not null,
quantidade int not null,
precoUnitario decimal(10,2) not null,

constraint fk_itens_vendas
foreign key (idVenda)
references vendas(idVenda)
ON DELETE CASCADE,

constraint fk_itens_vendas_produtos
foreign key (idProduto)
references produtos(idProduto)
);


insert into vendas(dataVenda, total)
values (now(), 16.00);

insert into itens_vendas(idVenda,idProduto,quantidade,precoUnitario)
values
(1,1,2,3.00),
(1,4,1,10.00);

insert into vendas(dataVenda,total)
values (now(), 23.00);

UPDATE vendas
SET total = 16.00
WHERE idVenda = 2;

select * from vendas;

insert into itens_vendas(idVenda,idProduto,quantidade,precoUnitario)
values
(2,2,5,3.20);

insert into vendas(dataVenda, total)
values(now(), 23.00);

insert into itens_vendas(idVenda,idProduto,quantidade,precoUnitario)
values
(3,4,2,10.00),
(3,1,1,3.00);

select * from itens_vendas;

-- consulta 1

select
	fornecedores.nome,
    produtos.idProduto,
    produtos.descricao,
    produtos.precoVenda,
    produtos.quantidade,
    produtos.estoqueMinimo
    from produtos
    join fornecedores on produtos.idFornecedor = fornecedores.idFornecedor
    order by descricao desc;
    
-- consulta 2
    
    select    
		produtos.idProduto,
		produtos.codigoBarras,
		produtos.descricao,
		produtos.categoria,
		produtos.quantidade,
		produtos.estoqueMinimo,
		fornecedores.nome,
		(produtos.estoqueMinimo - produtos.quantidade) AS quantidade_necessaria
		FROM produtos
		JOIN fornecedores ON produtos.idFornecedor = fornecedores.idFornecedor
		WHERE produtos.quantidade <= produtos.estoqueMinimo
		ORDER BY produtos.quantidade asc, produtos.descricao asc;
        
-- Consulta 3 
-- venda 1

select
	itens_vendas.idVenda,
    vendas.dataVenda,
    produtos.descricao,
    itens_vendas.quantidade,
    itens_vendas.precoUnitario
    from itens_vendas
    join vendas on itens_vendas.idVenda = vendas.idVenda
    join produtos on itens_vendas.idProduto = produtos.idProduto
    where vendas.idVenda = 1;
    
-- venda 2

   select
	itens_vendas.idVenda,
    vendas.dataVenda,
    produtos.descricao,
    itens_vendas.quantidade,
    itens_vendas.precoUnitario
    from itens_vendas
    join vendas on itens_vendas.idVenda = vendas.idVenda
    join produtos on itens_vendas.idProduto = produtos.idProduto
    where vendas.idVenda = 2; 
    
-- venda 3
	
    select
	itens_vendas.idVenda,
    vendas.dataVenda,
    produtos.descricao,
    itens_vendas.quantidade,
    itens_vendas.precoUnitario
    from itens_vendas
    join vendas on itens_vendas.idVenda = vendas.idVenda
    join produtos on itens_vendas.idProduto = produtos.idProduto
    where vendas.idVenda = 3;
    
    
    -- 8.1
    select count(quantidade)
    from produtos;
    
    -- 8.2
    select count(quantidade)
    from produtos
    where quantidade <= estoqueMinimo and quantidade >= 1 ;
    
    -- 8.3
    select count(quantidade)
    from produtos
    where quantidade = 0;
    
    -- 8.4
    select count(dataVenda)
    from vendas
    where date(dataVenda) = curdate();
    
    -- 8.5
	select 
		ifnull(sum(itens_vendas.quantidade), 0) as TotalUnidades,
        count(vendas.dataVenda) as vendasHoje
	from itens_vendas
    join vendas on itens_vendas.idVenda = vendas.idVenda
	where date(vendas.dataVenda) = curdate();
    
    -- 8.6
    select ifnull(sum(total), 0) as FaturamentoHoje
    from vendas
    where date(dataVenda) = curdate();
    
   /*
   
   -- 9 Últimas vendas

Apresente as últimas vendas cadastradas.

Exiba:

* `idVenda`
* `dataVenda`
* `total`

Apresente no máximo **10 registros**, começando pela venda mais recente.

Formate a `dataVenda` como:

**dd/mm/aaaa hh:mm**
*/


select
	idVenda,
    dataVenda,
    total
    from vendas
    order by idVenda desc
    limit 10;
    
    
    
    
    -- Desafio Extra
    
    -- Desafio 1
    -- Identifique o produto com maior quantidade em estoque.

select 
	idProduto,
	quantidade,
    descricao
    from produtos
    order by quantidade desc
    limit 1;
    
-- Desafio 2
-- Identifique o produto que possui a maior diferença entre `precoVenda` e `precoCusto`

select * from produtos;

select 
	descricao,
    (precoVenda - precoCusto) as Diferenca
    from produtos
    order by Diferenca desc
    limit 1;
    
  -- Desafio 3 
  -- Apresente cada produto e a quantidade total vendida.
  -- Produtos que ainda não foram vendidos também devem ser considerados.
select
	produtos.descricao,
	ifnull(sum(itens_vendas.quantidade),0) as TotalVendido
    from produtos
    left join itens_vendas on produtos.idProduto = itens_vendas.idProduto
    group by descricao;
   
 -- Desafio 4
 -- Identifique o produto que possui a maior quantidade total vendida.
 
 select 
	produtos.descricao,
    sum(itens_vendas.quantidade) as TotalVendido
    from itens_vendas
    join produtos on itens_vendas.idProduto = produtos.idProduto
    group by descricao
    order by TotalVendido desc
    limit 1;
    
    -- Desafio 5
    -- Calcule o valor de cada venda a partir dos registros de `itens_venda`.
	-- Não utilize diretamente o campo `total` de `vendas`.
    -- Compare posteriormente o resultado calculado com o valor armazenado em `vendas.total`.
	select
		itens_vendas.idVenda,
        sum(itens_vendas.quantidade * precoUnitario) as cadaVenda,
        vendas.total
        from itens_vendas
        join vendas on itens_vendas.idVenda = vendas.idVenda
        join produtos on itens_vendas.idProduto = produtos.idProduto
        group by itens_vendas.idVenda, vendas.total;
    

    
    
		
    
    
        
        
    
    
    
    
    
    
    
    




 
 
 
 
