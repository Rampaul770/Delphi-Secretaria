CREATE OR REPLACE PROCEDURE SP_RESET_SEQUENCE( P_SEQUENCE_NAME IN VARCHAR2 )
IS
    L_VAL NUMBER;
BEGIN
    EXECUTE IMMEDIATE
    'SELECT ' || P_SEQUENCE_NAME || '.NEXTVAL FROM DUAL' INTO L_VAL;

    EXECUTE IMMEDIATE
    'ALTER SEQUENCE ' || P_SEQUENCE_NAME || ' INCREMENT BY -' || L_VAL || ' MINVALUE 0';

    EXECUTE IMMEDIATE
    'SELECT ' || P_SEQUENCE_NAME || '.NEXTVAL FROM DUAL' INTO L_VAL;

    EXECUTE IMMEDIATE
    'ALTER SEQUENCE ' || P_SEQUENCE_NAME || ' INCREMENT BY 1 MINVALUE 0';
END;