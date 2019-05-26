import 'dart:async';
import 'dart:io'as io;
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_employeemangement/model/Employee.dart';

  class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblEmployee = "employee";
  String colEmpId = "id";
  String colEmpName = "name";
  String colEmpAddress = "address";
  String colEmpSalary = "salary";
  DbHelper._internal();

  factory DbHelper() {
  return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "employee.db";

    var dbEmployees = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbEmployees;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblEmployee($colEmpId INTEGER PRIMARY KEY, $colEmpName TEXT, " +
            "$colEmpAddress TEXT, $colEmpSalary INTEGER NOT NULL )");

  }

  Future<int> insertEmployee(Employee employee) async {
    Database db = await this.db;
    var result = await db.insert(tblEmployee, employee.toMap());
    return result;
  }

  Future<List> getEmployees() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblEmployee order by $colEmpId ASC");
    return result;
  }

  /*Future<List<Employee>> getEmployees() async {
    var dbClient =await db;
    List<Map>maps =await dbClient.query(tblEmployee,columns: [colEmpId,colEmpName,colEmpAddress,colEmpSalary]);
   // var result = await db.rawQuery("SELECT * FROM $tblEmployee order by $colEmpId ASC");
    List<Employee> employees= [];
    if(maps.length>0)
      {
      for(int i=0;i<maps.length;i++)
        {
        employees.add(Employee.fromObject(maps[i]));
      }
  }
    return employees ;
  }
*/
  Future<int> deleteEmployee(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblEmployee WHERE $colEmpId = $id');
    return result;
  }

  Future<int> updateEmployee(Employee employee) async {
    var db = await this.db;
    var result = await db.update(tblEmployee, employee.toMap(),
        where: "$colEmpId = ?", whereArgs: [employee.id]);
    return result;
  }
  Future close()async{
    var db = await this.db;
    db.close();
  }
  Future<int> updateTodo(Employee employee) async {
    var db = await this.db;
    var result = await db.update(tblEmployee, employee.toMap(),
        where: "$colEmpId = ?", whereArgs: [employee.id]);
    return result;
  }


  }














