CREATE OR REPLACE PROCEDURE SP_ATUALIZA_ALUNO
(
P_ID         IN ALUNO.ID%TYPE,
P_NOME       IN ALUNO.NOME%TYPE,
P_RA         IN ALUNO.RA%TYPE,
P_ENDERECO   IN ALUNO.ENDERECO%TYPE,
P_CEP        IN ALUNO.CEP%TYPE,
P_TELEFONE   IN VARCHAR2,
P_CELULAR    IN VARCHAR2,
P_NASCIMENTO IN VARCHAR2
)
IS

V_COUNT NUMBER(5);

V_TELEFONE      ALUNO.TELEFONE%TYPE;
V_CELULAR       ALUNO.CELULAR%TYPE;
V_NASCIMENTO    ALUNO.NASCIMENTO%TYPE;

ID_INVALIDO         EXCEPTION;        
NOME_INVALIDO       EXCEPTION;
RA_INVALIDO         EXCEPTION;
ENDERECO_INVALIDO   EXCEPTION;
CEP_INVALIDO        EXCEPTION;
TELEFONE_INVALIDO   EXCEPTION;
CELULAR_INVALIDO    EXCEPTION;
NASCIMENTO_INVALIDO EXCEPTION;

BEGIN

    BEGIN -- Validação do parâmetro ID
       
        IF P_ID IS NULL THEN
            RAISE ID_INVALIDO;
        END IF;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM ALUNO
        WHERE ID = P_ID;
        
        IF V_COUNT = 0 THEN
            RAISE ID_INVALIDO;
        END IF;          

    EXCEPTION    
    
        WHEN ID_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'CODIGO ID INVÁLIDO! - ');
    END;

    BEGIN -- Validação do parâmetro Nome
        
        IF P_NOME IS NULL OR P_NOME = '' OR LENGTH(P_NOME) > 100 THEN 
            RAISE NOME_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN NOME_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'NOME INVÁLIDO!');

    END;

    BEGIN -- Validação do parâmetro RA
       
        IF P_RA IS NULL OR LENGTH(P_RA) <> 5 THEN
            RAISE RA_INVALIDO;
        END IF;
        
    EXCEPTION    
    
        WHEN RA_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20003, 'CODIGO DO RA INVÁLIDO!');
            
        WHEN INVALID_NUMBER THEN
            RAISE_APPLICATION_ERROR(-20004, 'CODIGO DO RA INVÁLIDO!');

    END;

    BEGIN -- Validação do parâmetro Endereço
        
        IF P_ENDERECO IS NULL OR P_ENDERECO = '' OR LENGTH(P_ENDERECO) > 200 THEN 
            RAISE ENDERECO_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN ENDERECO_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20005, 'ENDERECO INVÁLIDO!');

    END;

    BEGIN -- Validação do parâmetro CEP
       
        IF P_CEP IS NULL OR LENGTH(P_CEP) <> 8 THEN
            RAISE CEP_INVALIDO;
        END IF;

    EXCEPTION    
    
        WHEN CEP_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20006, 'CODIGO DO CEP INVÁLIDO!');
            
        WHEN INVALID_NUMBER THEN
            RAISE_APPLICATION_ERROR(-20007, 'CODIGO DO CEP INVÁLIDO!');
        
    END;

    BEGIN -- Validação do parâmetro Telefone
       
        IF P_TELEFONE IS NULL OR LENGTH(P_TELEFONE) <> 10 THEN
            RAISE TELEFONE_INVALIDO;
        END IF;
        
        SELECT TO_NUMBER(P_TELEFONE) INTO V_TELEFONE FROM DUAL;
        
    EXCEPTION    
    
        WHEN TELEFONE_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20008, 'TELEFONE INVÁLIDO!');
            
        WHEN INVALID_NUMBER THEN
            RAISE_APPLICATION_ERROR(-20009, 'TELEFONE INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro Celular
       
        IF P_CELULAR IS NULL OR LENGTH(P_CELULAR) <> 11 THEN
            RAISE CELULAR_INVALIDO;
        END IF;
        
        SELECT TO_NUMBER(P_CELULAR) INTO V_CELULAR FROM DUAL;
        
    EXCEPTION    
    
        WHEN CELULAR_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20010, 'CELULAR INVÁLIDO!');
            
        WHEN INVALID_NUMBER THEN
            RAISE_APPLICATION_ERROR(-20011, 'CELULAR INVÁLIDO!');
        
    END;
    
    BEGIN -- Validação do parâmetro Nascimento
       
        IF P_NASCIMENTO IS NULL THEN
            RAISE NASCIMENTO_INVALIDO;
        END IF;
        
        SELECT TO_DATE(P_NASCIMENTO, 'yyyy-mm-dd') INTO V_NASCIMENTO FROM DUAL;

    EXCEPTION    
    
        WHEN NASCIMENTO_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20012, 'DATA DE NASCIMENTO INVÁLIDA!');
            
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20013, 'DATA DE NASCIMENTO INVÁLIDA!');
        
    END;
    
    BEGIN    
        
        UPDATE ALUNO
        SET NOME = P_NOME, RA = P_RA, ENDERECO = P_ENDERECO, CEP = P_CEP, 
            TELEFONE = V_TELEFONE, CELULAR = V_CELULAR, NASCIMENTO = V_NASCIMENTO
        WHERE ID = P_ID;    
        
        COMMIT;    
    
    EXCEPTION
    
        WHEN OTHERS THEN
            BEGIN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20014, 'ERRO INESPERADO - ' || SQLERRM);
            END;
    
    END;

END;