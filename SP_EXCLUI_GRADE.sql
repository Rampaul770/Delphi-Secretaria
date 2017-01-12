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
    
    BEGIN -- Validação do parâmetro ID

        IF P_ID IS NULL THEN
            RAISE GRADE_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'CÓDIGO ID DA GRADE INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro ID do Curso

        IF P_CURSO_ID IS NULL THEN
            RAISE GRADE_CURSO_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_CURSO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'CÓDIGO ID DO CURSO INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro ID do Matéria

        IF P_MATERIA_ID IS NULL THEN
            RAISE GRADE_MATERIA_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_MATERIA_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20003, 'CÓDIGO ID DA MATÉRIA INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro ID do Aluno

        IF P_ALUNO_ID IS NULL THEN
            RAISE GRADE_ALUNO_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_ALUNO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20004, 'CÓDIGO ID DO ALUNO INVÁLIDO!');
        
    END;
    
    BEGIN
    
        SELECT ID INTO V_CURSO_MATERIA_ID
        FROM CURSO_MATERIA
        WHERE CURSO_ID = P_CURSO_ID
        AND MATERIA_ID = P_MATERIA_ID;
        
    EXCEPTION
    
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'CÓDIGO ID DE CURSO OU MATÉRIA INVÁLIDOS!');
            
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