-- Gerado por Oracle SQL Developer Data Modeler 4.1.5.907
--   em:        2017-01-05 23:19:05 BRST
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g




DROP TABLE ALUNO CASCADE CONSTRAINTS ;

DROP TABLE CURSO CASCADE CONSTRAINTS ;

DROP TABLE GRADE CASCADE CONSTRAINTS ;

DROP TABLE MATERIA CASCADE CONSTRAINTS ;

DROP SEQUENCE SQ_ALUNO ;

DROP SEQUENCE SQ_CURSO ;

DROP SEQUENCE SQ_MATERIA ;


CREATE TABLE ALUNO
  (
    ID         NUMBER (5) NOT NULL ,
    NOME       VARCHAR2 (100) NOT NULL ,
    RA         CHAR (5) NOT NULL ,
    ENDERECO   VARCHAR2 (200) NOT NULL ,
    CEP        CHAR (8) NOT NULL ,
    TELEFONE   NUMBER (11) ,
    CELULAR    NUMBER (11) NOT NULL ,
    NASCIMENTO DATE NOT NULL ,
    MATRICULA  TIMESTAMP NOT NULL
  ) ;
ALTER TABLE ALUNO ADD CONSTRAINT ALUNO_PK PRIMARY KEY ( ID ) ;


-- After Create script example for table ALUNO
CREATE TABLE CURSO
  (
    ID        NUMBER (5) NOT NULL ,
    NOME      VARCHAR2 (100) NOT NULL ,
    DESCRICAO VARCHAR2 (500) NOT NULL
  ) ;
ALTER TABLE CURSO ADD CONSTRAINT CURSO_PK PRIMARY KEY ( ID ) ;


CREATE TABLE GRADE
  (
    CURSO_ID   NUMBER (5) NOT NULL ,
    MATERIA_ID NUMBER (5) NOT NULL ,
    ALUNO_ID   NUMBER (5) NOT NULL
  ) ;
ALTER TABLE GRADE ADD CONSTRAINT GRADE_PK PRIMARY KEY ( CURSO_ID, MATERIA_ID, ALUNO_ID ) ;


CREATE TABLE MATERIA
  (
    ID        NUMBER (5) NOT NULL ,
    NOME      VARCHAR2 (100) NOT NULL ,
    DESCRICAO VARCHAR2 (500) NOT NULL
  ) ;
ALTER TABLE MATERIA ADD CONSTRAINT MATERIA_PK PRIMARY KEY ( ID ) ;


ALTER TABLE GRADE ADD CONSTRAINT GRADE_ALUNO_FK FOREIGN KEY ( ALUNO_ID ) REFERENCES ALUNO ( ID ) ;

ALTER TABLE GRADE ADD CONSTRAINT GRADE_CURSO_FK FOREIGN KEY ( CURSO_ID ) REFERENCES CURSO ( ID ) ;

ALTER TABLE GRADE ADD CONSTRAINT GRADE_MATERIA_FK FOREIGN KEY ( MATERIA_ID ) REFERENCES MATERIA ( ID ) ;


CREATE SEQUENCE SQ_ALUNO
MINVALUE 1
MAXVALUE 1000
INCREMENT BY 1
START WITH 1
NOCACHE;


CREATE SEQUENCE SQ_CURSO
MINVALUE 1
MAXVALUE 1000
INCREMENT BY 1
START WITH 1
NOCACHE;


CREATE SEQUENCE SQ_MATERIA
MINVALUE 1
MAXVALUE 1000
INCREMENT BY 1
START WITH 1
NOCACHE;


-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
