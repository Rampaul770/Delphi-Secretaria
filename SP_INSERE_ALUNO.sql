CREATE OR REPLACE PROCEDURE SP_INSERE_ALUNO
(
P_NOME       IN ALUNO.NOME%TYPE,
P_RA         IN ALUNO.RA%TYPE,
P_ENDERECO   IN ALUNO.ENDERECO%TYPE,
P_CEP        IN ALUNO.CEP%TYPE,
P_TELEFONE   IN ALUNO.TELEFONE%TYPE,
P_CELULAR    IN ALUNO.CELULAR%TYPE,
P_NASCIMENTO IN ALUNO.NASCIMENTO%TYPE
)
IS

V_RA            ALUNO.RA%TYPE;
V_CEP           ALUNO.CEP%TYPE;
V_NASCIMENTO    ALUNO.NASCIMENTO%TYPE;
        
NOME_INVALIDO       EXCEPTION;
RA_INVALIDO         EXCEPTION;
ENDERECO_INVALIDO   EXCEPTION;
CEP_INVALIDO        EXCEPTION;
TELEFONE_INVALIDO   EXCEPTION;
CELULAR_INVALIDO    EXCEPTION;
NASCIMENTO_INVALIDO EXCEPTION;

BEGIN

    BEGIN -- Validação do parâmetro Nome
        
        IF P_NOME IS NULL OR P_NOME = '' OR LENGTH(P_NOME) > 100 THEN 
            RAISE NOME_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN NOME_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20001, 'NOME INVÁLIDO! - ' || SQLERRM);

    END;

    BEGIN -- Validação do parâmetro RA
       
        IF P_RA IS NULL OR LENGTH(P_RA) <> 5 THEN
            RAISE RA_INVALIDO;
        END IF;
        
        SELECT TO_NUMBER(P_RA) INTO V_RA FROM DUAL;

    EXCEPTION    
    
        WHEN RA_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20002, 'CODIGO DO RA INVÁLIDO! - ' || SQLERRM);
            
        WHEN INVALID_NUMBER THEN
            RAISE_APPLICATION_ERROR(-20003, 'CODIGO DO RA INVÁLIDO! - ' || SQLERRM);
        
    END;

    BEGIN -- Validação do parâmetro Endereço
        
        IF P_ENDERECO IS NULL OR P_ENDERECO = '' OR LENGTH(P_ENDERECO) > 200 THEN 
            RAISE ENDERECO_INVALIDO;
        END IF;
        
    EXCEPTION
    
        WHEN ENDERECO_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20004, 'ENDERECO INVÁLIDO! - ' || SQLERRM);

    END;

    BEGIN -- Validação do parâmetro CEP
       
        IF P_CEP IS NULL OR LENGTH(P_CEP) <> 8 THEN
            RAISE CEP_INVALIDO;
        END IF;
        
        SELECT TO_NUMBER(P_CEP) INTO V_CEP FROM DUAL;

    EXCEPTION    
    
        WHEN CEP_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20005, 'CODIGO DO CEP INVÁLIDO! - ' || SQLERRM);
            
        WHEN INVALID_NUMBER THEN
            RAISE_APPLICATION_ERROR(-20006, 'CODIGO DO CEP INVÁLIDO! - ' || SQLERRM);
        
    END;

    BEGIN -- Validação do parâmetro Telefone
       
        IF P_TELEFONE IS NULL OR LENGTH(P_TELEFONE) <> 10 THEN
            RAISE TELEFONE_INVALIDO;
        END IF;
        
    EXCEPTION    
    
        WHEN TELEFONE_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20007, 'TELEFONE INVÁLIDO! - ' || SQLERRM);
        
    END;
    
    BEGIN -- Validação do parâmetro Celular
       
        IF P_CELULAR IS NULL OR LENGTH(P_CELULAR) <> 11 THEN
            RAISE CELULAR_INVALIDO;
        END IF;
        
    EXCEPTION    
    
        WHEN CELULAR_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20008, 'CELULAR INVÁLIDO! - ' || SQLERRM);
        
    END;
    
    BEGIN -- Validação do parâmetro Nascimento
       
        IF P_NASCIMENTO IS NULL THEN
            RAISE NASCIMENTO_INVALIDO;
        END IF;
        
        SELECT TO_DATE(P_NASCIMENTO, 'yyyy-mm-dd') INTO V_NASCIMENTO FROM DUAL;

    EXCEPTION    
    
        WHEN CEP_INVALIDO THEN
            RAISE_APPLICATION_ERROR(-20009, 'DATA DE NASCIMENTO INVÁLIDA! - ' || SQLERRM);
            
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20010, 'DATA DE NASCIMENTO INVÁLIDA! - ' || SQLERRM);
        
    END;
    

    INSERT INTO ALUNO(ID,
                      NOME, RA, ENDERECO, CEP, 
                      TELEFONE, CELULAR, NASCIMENTO, MATRICULA)
    VALUES(SQ_ALUNO.NEXTVAL, 
           P_NOME, P_RA, P_ENDERECO, P_CEP, 
           P_TELEFONE, P_CELULAR, P_NASCIMENTO, CURRENT_TIMESTAMP);
           
    
    COMMIT;
    

EXCEPTION

    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20011, 'ERRO INESPERADO - ' || SQLERRM);

END;