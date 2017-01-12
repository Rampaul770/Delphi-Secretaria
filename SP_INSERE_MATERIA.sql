CREATE OR REPLACE PROCEDURE SP_INSERE_MATERIA
(
P_NOME      IN MATERIA.NOME%TYPE,
P_DESCRICAO IN MATERIA.DESCRICAO%TYPE,
P_CURSO_ID  IN CURSO.ID%TYPE
)
IS

V_COUNT     NUMBER(5);
ID_MATERIA  NUMBER(5);

NOME_INVALIDO       EXCEPTION;
DESCRICAO_INVALIDA  EXCEPTION;
CURSO_ID_INVALIDO   EXCEPTION;

BEGIN

    BEGIN -- Validação do parâmetro Nome
        
        IF P_NOME IS NULL OR P_NOME = '' OR LENGTH(P_NOME) > 100 THEN 
            RAISE NOME_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN NOME_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'NOME INVÁLIDO!');

    END;

    BEGIN -- Validação do parâmetro Descrição
        
        IF P_DESCRICAO IS NULL OR P_DESCRICAO = '' OR LENGTH(P_DESCRICAO) > 500 THEN 
            RAISE DESCRICAO_INVALIDA;
        END IF;
        
    EXCEPTION
    
        WHEN DESCRICAO_INVALIDA THEN
            RAISE_APPLICATION_ERROR(-20002, 'DESCRIÇÃO INVÁLIDA!');

    END;    

    BEGIN -- Validação do parâmetro ID do Curso

        IF P_CURSO_ID IS NULL THEN
            RAISE CURSO_ID_INVALIDO;
        END IF;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM CURSO
        WHERE ID = P_CURSO_ID;

    EXCEPTION    

        WHEN CURSO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20003, 'CODIGO ID DO CURSO INVÁLIDO!');
            
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'CODIGO ID DO CURSO INVÁLIDO!');
        
    END;    
    
    BEGIN
    
        ID_MATERIA := SQ_MATERIA.NEXTVAL;
    
        INSERT INTO MATERIA(ID, NOME, DESCRICAO)
        VALUES(ID_MATERIA, P_NOME, P_DESCRICAO);
        
        INSERT INTO CURSO_MATERIA(ID, CURSO_ID, MATERIA_ID)
        VALUES(SQ_CURSO_MATERIA.NEXTVAL, P_CURSO_ID, ID_MATERIA);                
        
        COMMIT;
    
    EXCEPTION
    
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20005, 'ERRO INESPERADO - ' || SQLERRM);
            END;    
            
    END;

END;