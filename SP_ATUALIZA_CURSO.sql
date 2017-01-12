CREATE OR REPLACE PROCEDURE SP_ATUALIZA_CURSO
(
P_ID            IN CURSO.ID%TYPE,
P_NOME          IN CURSO.NOME%TYPE,
P_DESCRICAO     IN CURSO.DESCRICAO%TYPE
)
IS
       
V_COUNT NUMBER(5);       
       
ID_INVALIDO         EXCEPTION;
NOME_INVALIDO       EXCEPTION;
DESCRICAO_INVALIDA  EXCEPTION;

BEGIN

    BEGIN -- Validação do parâmetro ID
       
        IF P_ID IS NULL THEN
            RAISE ID_INVALIDO;
        END IF;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM CURSO
        WHERE ID = P_ID;
        
        IF V_COUNT = 0 THEN
            RAISE ID_INVALIDO;
        END IF;          

    EXCEPTION    
    
        WHEN ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'CODIGO ID INVÁLIDO!');
    END;

    BEGIN -- Validação do parâmetro Nome
        
        IF P_NOME IS NULL OR P_NOME = '' OR LENGTH(P_NOME) > 100 THEN 
            RAISE NOME_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN NOME_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'NOME INVÁLIDO!');

    END;

    BEGIN -- Validação do parâmetro Descrição
        
        IF P_DESCRICAO IS NULL OR P_DESCRICAO = '' OR LENGTH(P_DESCRICAO) > 500 THEN 
            RAISE DESCRICAO_INVALIDA;
        END IF;
        
    EXCEPTION
    
        WHEN DESCRICAO_INVALIDA THEN
            RAISE_APPLICATION_ERROR(-20003, 'DESCRIÇÃO INVÁLIDA!');

    END;
    
    BEGIN
    
        UPDATE CURSO
        SET NOME = P_NOME, DESCRICAO = P_DESCRICAO
        WHERE ID = P_ID;
            
        COMMIT;
        
    EXCEPTION
    
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20004, 'ERRO INESPERADO - ' || SQLERRM);
            END;
    
    END;

END;