import 'package:flutter/material.dart';
import 'package:flutter_employeemangement/db/dbhelper.dart';
import 'package:flutter_employeemangement/model/Employee.dart';


class AddPage extends StatefulWidget {
  //final Employee employee;
  //AddPage(this.employee);
  @override
  State<StatefulWidget> createState() {
    return _DBAddPageState();
  }
}

class _DBAddPageState extends State {
  //_DBAddPageState(this.employee);
  bool _nameValidate = false;
  bool _addressValidate = false;
  bool _salaryValidate = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  DbHelper db;

  @override
  void initState() {
    super.initState();
    db = new DbHelper();
  }

  final _formKey = GlobalKey<_DBAddPageState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextField(
                        controller: namecontroller,
                        style: textStyle,
                        decoration: InputDecoration(
                            labelText: "Enter Name",
                            labelStyle: textStyle,
                            errorText:
                                _nameValidate ? 'Value Can\'t Be Empty' : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                          child: TextField(
                            controller: addressController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Enter Address",
                                labelStyle: textStyle,
                                errorText: _addressValidate
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                          child: TextField(
                            controller: salaryController,
                            style: textStyle,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Enter Salary",
                                labelStyle: textStyle,
                                errorText: _salaryValidate
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 50.0, bottom: 0.0),
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 80.0),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                textBaseline: TextBaseline.alphabetic),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          elevation: 5.0,
                          splashColor: Colors.red,
                          onPressed: () {
                            setState(() {
                              updateData(context);

                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }

  updateData(BuildContext _context) {
    Employee employee;
    String name = namecontroller.text.trim();
    String address = addressController.text.trim();
    String salaryString = salaryController.text.trim();
    int salary;
    if (name.isNotEmpty) {
      _nameValidate = false;
    } else {
      _nameValidate = true;

    }
    if (address.isNotEmpty) {
      _addressValidate = false;
    } else {
      _addressValidate = true;
    }
    if (salaryString.isNotEmpty) {
      _salaryValidate = false;
      salary=int.parse(salaryString);
    } else {

      _salaryValidate = true;
    }
    debugPrint("Employee:-> " +
        salary.toString() +
        " " +
        name +
        " " +
        address);
    if(name.isNotEmpty&&address.isNotEmpty && salaryString.isNotEmpty) {
      employee = Employee(name, address, salary);
      db.insertEmployee(employee);
      showAddedDialog(context);

    }
  }

  void showAddedDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Employee Management"),
      content: Text("Added Sucessfully!"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
    _reset();
  }

  void _reset() {
    namecontroller.text = '';
    addressController.text = '';
    salaryController.text = '';
    setState(() {

    });
  }
}
