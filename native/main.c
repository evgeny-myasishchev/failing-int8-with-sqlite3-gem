#include <stdio.h>
#include <sqlite3.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"

int main ()
{
    sqlite3 * db;
    char * sql;
    sqlite3_stmt * stmt;
    int i;

    CALL_SQLITE (open ("db/test.sqlite", & db));

	sql = "DROP TABLE \"employees\"";
	CALL_SQLITE(exec(db,sql,0,0,0));
	
	sql = "CREATE TABLE \"employees\" (\"token\" integer(8), \"name\" varchar(20) NOT NULL)";
	CALL_SQLITE(exec(db,sql,0,0,0));

    sql = "INSERT INTO Employees(name, token) VALUES('employee-1', ?)";
    CALL_SQLITE (prepare_v2 (db, sql, strlen (sql) + 1, & stmt, NULL));
    CALL_SQLITE (bind_int64 (stmt, 1, 4907021672125087744 + 100));
    CALL_SQLITE_EXPECT (step (stmt), DONE);
    return 0;
}
