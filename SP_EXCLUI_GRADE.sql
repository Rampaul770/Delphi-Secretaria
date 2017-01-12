CREATE OR REPLACE PROCEDURE SP_EXCLUI_GRADE
(
P_ID  IN GRADE.ID%TYPE
)
IS

GRADE_ID_INVALIDO EXCEPTION;

BEGIN
    
    BEGIN -- Validação do parâmetro ID

        IF P_ID IS NULL THEN
            RAISE GRADE_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'CÓDIGO ID DA GRADE INVÁLIDO!');
        
    END;
    
    BEGIN
    
        DELETE FROM GRADE
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