CREATE OR REPLACE PROCEDURE SP_INSERE_GRADE
(
P_NOME              IN GRADE.NOME%TYPE,
P_CURSO_ID          IN CURSO.ID%TYPE,
P_MATERIA_ID        IN MATERIA.ID%TYPE,
P_ALUNO_ID          IN ALUNO.ID%TYPE
)
IS

V_COUNT             NUMBER(5);
V_CURSO_MATERIA_ID  CURSO_MATERIA.ID%TYPE;

NOME_INVALIDO       EXCEPTION;
CURSO_ID_INVALIDO   EXCEPTION;
ALUNO_ID_INVALIDO   EXCEPTION;
MATERIA_ID_INVALIDO EXCEPTION;

BEGIN

    BEGIN -- Validação do parâmetro Nome
        
        IF P_NOME IS NULL OR P_NOME = '' OR LENGTH(P_NOME) > 100 THEN 
            RAISE NOME_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN NOME_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'NOME INVÁLIDO!');

    END;
    
    BEGIN -- Validação do parâmetro ID do Curso

        IF P_CURSO_ID IS NULL THEN
            RAISE CURSO_ID_INVALIDO;
        END IF;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM CURSO
        WHERE ID = P_CURSO_ID;
        
        IF V_COUNT = 0 THEN
            RAISE CURSO_ID_INVALIDO;
        END IF;        

    EXCEPTION    
            
        WHEN CURSO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'CÓDIGO ID DO CURSO INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro ID da Matéria

        IF P_MATERIA_ID IS NULL THEN
            RAISE MATERIA_ID_INVALIDO;            
        END IF;        
        
        SELECT COUNT(*) INTO V_COUNT
        FROM MATERIA
        WHERE ID = P_MATERIA_ID;
        
        IF V_COUNT = 0 THEN
            RAISE MATERIA_ID_INVALIDO;
        END IF;         

    EXCEPTION    

        WHEN MATERIA_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'CÓDIGO ID DA MATÉRIA INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro ID de Aluno

        IF P_ALUNO_ID IS NULL THEN
            RAISE ALUNO_ID_INVALIDO;
        END IF;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM ALUNO
        WHERE ID = P_ALUNO_ID;
        
        IF V_COUNT = 0 THEN
            RAISE ALUNO_ID_INVALIDO;
        END IF;  
        
    EXCEPTION    

        WHEN ALUNO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20003, 'CÓDIGO ID DE ALUNO INVÁLIDO!');
        
    END;
    
    BEGIN
    
        SELECT ID INTO V_CURSO_MATERIA_ID
        FROM CURSO_MATERIA
        WHERE MATERIA_ID = P_MATERIA_ID
        AND CURSO_ID = P_CURSO_ID;
        
    EXCEPTION
        
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'CÓDIGO ID DE MATÉRIA OU CURSO INVÁLIDOS!');
            
    END;
    
    BEGIN
    
        INSERT INTO GRADE(ID, NOME, CURSO_MATERIA_ID, ALUNO_ID)
        VALUES(SQ_GRADE.NEXTVAL, P_NOME, V_CURSO_MATERIA_ID, P_ALUNO_ID);
        
        COMMIT;
    
    EXCEPTION
    
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20005, 'ERRO INESPERADO - ' || SQLERRM);
            END;
    
    END;

END;