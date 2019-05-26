class Employee{
int _empId;
String _empName;
String _empAddress;
int _empSalary;

Employee(this._empName,this._empAddress,this._empSalary);
Employee.withId(this._empId,this._empName,this._empAddress,this._empSalary);
int get id => _empId;
String get name => _empName;
String get address => _empAddress;
int get salary =>_empSalary;

set name(String newName)
{
  if (newName.length <= 255) {
    _empName = newName;
  }
}

set address(String newAddress)
{
  if (newAddress.length <= 350) {
    _empAddress = newAddress;
  }
}
set salary(int newSalary)
{
    _empSalary = newSalary;

}


Map <String, dynamic> toMap(){
  var map = Map<String, dynamic>();
  map["name"] = _empName;
  map["address"] = _empAddress;
  map["salary"] = _empSalary;
  if (_empId != null) {
    map["id"] = _empId;
  }
  return map;
}

Employee.fromObject(dynamic o) {
  this._empId = o["id"];
  this._empName = o["name"];
  this._empAddress = o["address"];
  this._empSalary = o["salary"];

}
}