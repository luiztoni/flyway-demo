USE demoflyway;


DELIMITER $$
CREATE OR REPLACE TRIGGER reposicao_produto
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN
   	IF NEW.quantidade <> OLD.quantidade AND NEW.quantidade = 0 THEN
   		 INSERT INTO reposicao (id_produto) VALUES (NEW.id);
    END IF;  
END $$
DELIMITER ;
   
   
   
DELIMITER $$
CREATE OR REPLACE PROCEDURE obter_produto_mais_vendido2(IN dia_buscado DATE, OUT nome_produto VARCHAR(20))
BEGIN
DECLARE total_quantidade INT;
DECLARE p INT;
 

    SELECT SUM(quantidade) AS total_quantidade, product_id INTO total_quantidade, p
    FROM VENDA
    WHERE dia = dia_buscado
    GROUP BY produto_id
    ORDER BY total_quantidade DESC
    LIMIT 1;
    
    SELECT nome INTO nome_produto FROM PRODUTO WHERE id = p;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE obter_produto_mais_vendido(IN dia_busca DATE, OUT produto_mais_vendido VARCHAR(255))
DETERMINISTIC
BEGIN
    SELECT PRODUTO.nome INTO produto_mais_vendido
    FROM PRODUTO
    JOIN VENDA ON VENDA.produto_id = PRODUTO.id
    WHERE VENDA.dia = dia_busca
    GROUP BY PRODUTO.nome
    ORDER BY COUNT(*) DESC
    LIMIT 1;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE FUNCTION nivel_cliente(
	credito DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE nivel VARCHAR(20);

    IF credito > 50000 THEN
		SET nivel = 'ouro';
    ELSEIF (credito >= 50000 AND 
			credito <= 10000) THEN
        SET nivel = 'prata';
    ELSEIF credito < 10000 THEN
        SET nivel = 'bronze';
    END IF;
	RETURN (nivel);
END $$
DELIMITER ;

-- use select nivel_cliente(100)

