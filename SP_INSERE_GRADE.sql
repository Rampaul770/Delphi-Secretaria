CREATE OR REPLACE PROCEDURE SP_INSERE_GRADE
(
P_NOME              IN GRADE.NOME%TYPE,
P_MATERIA_CURSO_ID  IN GRADE.MATERIA_CURSO_ID%TYPE,
P_ALUNO_ID          IN GRADE.ALUNO_ID%TYPE
)
IS

NOME_INVALIDO               EXCEPTION;
MATERIA_CURSO_ID_INVALIDO   EXCEPTION;
ALUNO_ID_INVALIDO           EXCEPTION;

BEGIN

    BEGIN -- Valida��o do par�metro Nome
        
        IF P_NOME IS NULL OR P_NOME = '' OR LENGTH(P_NOME) > 100 THEN 
            RAISE NOME_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN NOME_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'NOME INV�LIDO!');

    END;
    
    BEGIN -- Valida��o do par�metro ID da Materia

        IF P_MATERIA_CURSO_ID IS NULL THEN
            RAISE MATERIA_CURSO_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN MATERIA_CURSO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'C�DIGO ID DA MATERIA INV�LIDO!');
        
    END;
    
    BEGIN -- Valida��o do par�metro ID de Aluno

        IF P_ALUNO_ID IS NULL THEN
            RAISE ALUNO_ID_INVALIDO;
        END IF;
        
    EXCEPTION    

        WHEN ALUNO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20003, 'C�DIGO ID DE ALUNO INV�LIDO!');
        
    END;
    
    BEGIN
    
        INSERT INTO GRADE(ID, MATERIA_CURSO_ID, ALUNO_ID)
        VALUES(SQ_GRADE.NEXTVAL, P_MATERIA_CURSO_ID, P_ALUNO_ID);
        
        COMMIT;
    
    EXCEPTION
    
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20004, 'ERRO INESPERADO - ' || SQLERRM);
            END;
    
    END;

END;