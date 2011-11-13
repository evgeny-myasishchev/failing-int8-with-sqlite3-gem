require File.expand_path('../test_helper', __FILE__)
require 'sqlite3/database'

class TestFailingInt8Value < Test::Unit::TestCase
  
  DB = begin
    database_path = File.expand_path("test.sqlite", "db")
    FileUtils.rm_rf database_path if File.exists? database_path
    db = SQLite3::Database.new(
      database_path,
      :results_as_hash => true
    )
    db.execute %(CREATE TABLE "employees" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "token" integer(8), "name" varchar(20) NOT NULL))
    db
  end
  
  def test_direct_sql
    token_will_pass = 4907021672125087744
    token_will_fail = 4907021672125087744 + 100
    
    DB.execute "DELETE FROM Employees"
    DB.execute "INSERT INTO Employees(name, token) VALUES('employee-1', #{token_will_pass})"
    result = DB.query("SELECT token FROM Employees WHERE name=?", 'employee-1')
    actual_token  = result.next["token"]
    assert_equal(token_will_pass, actual_token)
    
    DB.execute "DELETE FROM Employees"
    DB.execute "INSERT INTO Employees(name, token) VALUES('employee-1', #{token_will_fail})"
    result = DB.query("SELECT token FROM Employees WHERE name=?", 'employee-1')
    actual_token  = result.next["token"]
    assert_equal(token_will_fail, actual_token)
    
    result.close
  end
  
  def test_with_parameters_binding
    token_will_pass = 4907021672125087744
    token_will_fail = 4907021672125087744 + 100
    
    DB.execute "DELETE FROM Employees"
    DB.execute "INSERT INTO Employees(name, token) VALUES('employee-1', ?)", [token_will_pass]
    result = DB.query("SELECT token FROM Employees WHERE name=?", 'employee-1')
    actual_token  = result.next["token"]
    assert_equal(token_will_pass, actual_token)
    
    DB.execute "DELETE FROM Employees"
    DB.execute "INSERT INTO Employees(name, token) VALUES('employee-1', ?)", [token_will_fail]
    result = DB.query("SELECT token FROM Employees WHERE name=?", 'employee-1')
    actual_token  = result.next["token"]
    assert_equal(token_will_fail, actual_token)
  end
end
