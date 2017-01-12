CREATE OR REPLACE PROCEDURE SP_EXCLUI_GRADE
(
P_ID                IN GRADE.ID%TYPE,
P_CURSO_ID          IN CURSO.ID%TYPE,
P_MATERIA_ID        IN MATERIA.ID%TYPE,
P_ALUNO_ID          IN ALUNO.ID%TYPE
)
IS

V_CURSO_MATERIA_ID  NUMBER(5);

GRADE_ID_INVALIDO           EXCEPTION;
GRADE_CURSO_ID_INVALIDO     EXCEPTION;
GRADE_MATERIA_ID_INVALIDO   EXCEPTION;
GRADE_ALUNO_ID_INVALIDO     EXCEPTION;

BEGIN
    
    BEGIN -- Valida��o do par�metro ID

        IF P_ID IS NULL THEN
            RAISE GRADE_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'C�DIGO ID DA GRADE INV�LIDO!');
        
    END;
    
    BEGIN -- Valida��o do par�metro ID do Curso

        IF P_CURSO_ID IS NULL THEN
            RAISE GRADE_CURSO_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_CURSO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'C�DIGO ID DO CURSO INV�LIDO!');
        
    END;
    
    BEGIN -- Valida��o do par�metro ID do Mat�ria

        IF P_MATERIA_ID IS NULL THEN
            RAISE GRADE_MATERIA_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_MATERIA_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20003, 'C�DIGO ID DA MAT�RIA INV�LIDO!');
        
    END;
    
    BEGIN -- Valida��o do par�metro ID do Aluno

        IF P_ALUNO_ID IS NULL THEN
            RAISE GRADE_ALUNO_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_ALUNO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20004, 'C�DIGO ID DO ALUNO INV�LIDO!');
        
    END;
    
    BEGIN
    
        SELECT ID INTO V_CURSO_MATERIA_ID
        FROM CURSO_MATERIA
        WHERE CURSO_ID = P_CURSO_ID
        AND MATERIA_ID = P_MATERIA_ID;
        
    EXCEPTION
    
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'C�DIGO ID DE CURSO OU MAT�RIA INV�LIDOS!');
            
    END;
        
    BEGIN
    
        DELETE FROM GRADE
        WHERE ID = P_ID
        AND CURSO_MATERIA_ID = V_CURSO_MATERIA_ID
        AND ALUNO_ID = P_ALUNO_ID;
        
        COMMIT;
    
    EXCEPTION
    
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006, 'ERRO INESPERADO - ' || SQLERRM);
            END;
    
    END;

END;