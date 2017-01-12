CREATE OR REPLACE PROCEDURE SP_EXCLUI_CURSO
(
P_ID IN CURSO.ID%TYPE
)
IS

ID_INVALIDO EXCEPTION;

BEGIN

    BEGIN -- Valida��o do par�metro ID
       
        IF P_ID IS NULL THEN
            RAISE ID_INVALIDO;
        END IF;

    EXCEPTION    
    
        WHEN ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'CODIGO ID INV�LIDO!');
    END;
    
    BEGIN    
    
        DELETE FROM CURSO
        WHERE ID = P_ID;
        
        COMMIT;
        
    EXCEPTION
    
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20002, 'ERRO INESPERADO - ' || SQLERRM);
            END;
    
    END;

END;