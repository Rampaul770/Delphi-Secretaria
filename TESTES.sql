Execute SP_INSERE_ALUNO('qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', '01234', 'qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', '07787320', 9999999999, 99999999999, '13-01-2017');
Execute SP_ATUALIZA_ALUNO(NULL, 'qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', '01234', 'qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', '07787320', 9999999999, 99999999999, '13-01-2017');
Execute SP_EXCLUI_ALUNO('X');

UPDATE ALUNO
SET 
NOME = 'qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', 
RA = '01234', 
ENDERECO = 'qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', 
CEP = '07787320', 
TELEFONE = 9999999999, 
CELULAR = 99999999999,
NASCIMENTO = '13-01-2017'
WHERE ID = 10;



INSERT INTO ALUNO 
VALUES(1, 'qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', '01234', 'qwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioqwertyuioQ', '07787320', 9999999999, 99999999999, '13-01-2017', CURRENT_TIMESTAMP);

DELETE FROM ALUNO;

SELECT * FROM ALUNO;

SELECT TO_TIMESTAMP(CURRENT_TIMESTAMP) FROM DUAL;
SELECT CURRENT_DATE FROM DUAL;
SELECT TO_TIMESTAMP_TZ(CURRENT_TIMESTAMP, 'HH.MI.SS') FROM DUAL;

SELECT COUNT(*) FROM MATERIA;
SELECT * FROM VW_CURSO;
