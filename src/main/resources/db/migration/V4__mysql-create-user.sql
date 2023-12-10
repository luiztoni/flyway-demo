USE demoflyway;
CREATE USER IF NOT EXISTS 'dev'@'localhost' IDENTIFIED BY 'devpwd';

/*GRANT PRIVILEGE ON database.table TO 'username'@'host';*/
GRANT ALL PRIVILEGES ON demoflyway TO 'dev'@'localhost';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'dev'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'dev'@'localhost';
DROP USER IF EXISTS 'dev'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'myroot';

