ALTER SESSION SET CONTAINER=<%= serviceName %>;

PROMPT === Now in <%= serviceName %> ===

DEFINE username = '<%= connectionUsername %>'
DEFINE userpwd  = '<%= connectionPassword %>'

DECLARE
    v_user_count INT;
BEGIN
    SELECT COUNT(*) INTO v_user_count 
        FROM dba_users 
        WHERE username = UPPER('&username');

    IF v_user_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER &username IDENTIFIED BY "&userpwd"';
        EXECUTE IMMEDIATE 'GRANT CONNECT TO &username';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO &username';
        EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE TO &username';
        EXECUTE IMMEDIATE 'GRANT CONNECT, CREATE SESSION, CREATE PROCEDURE, CREATE TABLE TO &username';
        EXECUTE IMMEDIATE 'GRANT EXECUTE ON JAVASCRIPT TO &username';
        EXECUTE IMMEDIATE 'GRANT CREATE MLE TO &username';
        EXECUTE IMMEDIATE 'GRANT CREATE ANY DIRECTORY TO &username';
        EXECUTE IMMEDIATE 'GRANT EXECUTE DYNAMIC MLE TO &username';
    END IF;
END;
/