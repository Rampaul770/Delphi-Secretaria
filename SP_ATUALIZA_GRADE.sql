CREATE OR REPLACE PROCEDURE SP_ATUALIZA_GRADE
(
P_ID                    IN GRADE.ID%TYPE,
P_CURSO_ID              IN CURSO.ID%TYPE,
P_MATERIA_ID            IN MATERIA.ID%TYPE,
P_ALUNO_ID              IN ALUNO.ID%TYPE,
P_NOME                  IN GRADE.NOME%TYPE,
P_CURSO_ID_NOVO         IN CURSO.ID%TYPE,
P_MATERIA_ID_NOVO       IN MATERIA.ID%TYPE,
P_ALUNO_ID_NOVO         IN ALUNO.ID%TYPE
)
IS

V_COUNT                     NUMBER(5);
V_CURSO_MATERIA_ID          CURSO_MATERIA.ID%TYPE;
V_CURSO_MATERIA_ID_NOVO     CURSO_MATERIA.ID%TYPE;

GRADE_ID_INVALIDO   EXCEPTION;
NOME_INVALIDO       EXCEPTION;
CURSO_ID_INVALIDO   EXCEPTION;
ALUNO_ID_INVALIDO   EXCEPTION;
MATERIA_ID_INVALIDO EXCEPTION;

BEGIN
    
    BEGIN -- Validação do parâmetro ID da Grade

        IF P_ID IS NULL THEN
            RAISE GRADE_ID_INVALIDO;
        END IF;

    EXCEPTION    

        WHEN GRADE_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'CÓDIGO ID DA GRADE INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro Nome
        
        IF P_NOME IS NULL OR P_NOME = '' OR LENGTH(P_NOME) > 100 THEN 
            RAISE NOME_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN NOME_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'NOME INVÁLIDO!');

    END;
    
    BEGIN -- Validação do parâmetro ID do Curso

        IF P_CURSO_ID_NOVO IS NULL THEN
            RAISE CURSO_ID_INVALIDO;
        END IF;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM CURSO
        WHERE ID = P_CURSO_ID_NOVO;
        
        IF V_COUNT = 0 THEN
            RAISE CURSO_ID_INVALIDO;
        END IF;        

    EXCEPTION    
            
        WHEN CURSO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20003, 'CÓDIGO ID DO CURSO INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro ID da Matéria

        IF P_MATERIA_ID_NOVO IS NULL THEN
            RAISE MATERIA_ID_INVALIDO;            
        END IF;        
        
        SELECT COUNT(*) INTO V_COUNT
        FROM MATERIA
        WHERE ID = P_MATERIA_ID_NOVO;
        
        IF V_COUNT = 0 THEN
            RAISE MATERIA_ID_INVALIDO;
        END IF;         

    EXCEPTION    

        WHEN MATERIA_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20004, 'CÓDIGO ID DA MATÉRIA INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro ID de Aluno

        IF P_ALUNO_ID_NOVO IS NULL THEN
            RAISE ALUNO_ID_INVALIDO;
        END IF;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM ALUNO
        WHERE ID = P_ALUNO_ID_NOVO;
        
        IF V_COUNT = 0 THEN
            RAISE ALUNO_ID_INVALIDO;
        END IF;  
        
    EXCEPTION    

        WHEN ALUNO_ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20005, 'CÓDIGO ID DE ALUNO INVÁLIDO!');
        
    END;
    
    BEGIN
    
        SELECT ID INTO V_CURSO_MATERIA_ID_NOVO
        FROM CURSO_MATERIA
        WHERE MATERIA_ID = P_MATERIA_ID_NOVO
        AND CURSO_ID = P_CURSO_ID_NOVO;
        
    EXCEPTION
        
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'CÓDIGO ID DE MATÉRIA OU CURSO INVÁLIDOS!');
            
    END;
    
    BEGIN
    
        SELECT ID INTO V_CURSO_MATERIA_ID
        FROM CURSO_MATERIA
        WHERE MATERIA_ID = P_MATERIA_ID
        AND CURSO_ID = P_CURSO_ID;
        
    EXCEPTION
        
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20007, 'CÓDIGO ID DE MATÉRIA OU CURSO INVÁLIDOS!');
            
    END;
    
    BEGIN
    
        UPDATE GRADE
        SET CURSO_MATERIA_ID = V_CURSO_MATERIA_ID_NOVO,
            NOME = P_NOME,
            ALUNO_ID = P_ALUNO_ID_NOVO
        WHERE ID = P_ID
        AND CURSO_MATERIA_ID = V_CURSO_MATERIA_ID
        AND ALUNO_ID = P_ALUNO_ID;  
        
        UPDATE GRADE
        SET NOME = P_NOME
        WHERE ID = P_ID;
        
        COMMIT;
    
    EXCEPTION

        WHEN DUP_VAL_ON_INDEX THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20008, 'CURSO, MATÉRIA E ALUNO ESPECIFICADO JÁ CADASTRADOS PARA ESSA GRADE!');
            END;
            
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20009, 'ERRO INESPERADO - ' || SQLERRM);
            END;
    
    END;

END;