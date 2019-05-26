import 'package:flutter/material.dart';
import 'package:flutter_employeemangement/db/dbhelper.dart';
import 'package:flutter_employeemangement/model/Employee.dart';

class ViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewListState();

}

class ViewListState extends State {
  DbHelper helper = DbHelper();
  List<Employee> employees;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (employees == null) {
      employees = List<Employee>();
      getData();
    }
    return Scaffold(
      body: todoListItems(),
    );
  }
  ListView todoListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,


          /*child: ListTile(
              leading: Icon(Icons.account_circle),
            *//*leading: CircleAvatar(
              child:Text(this.employees[position].id.toString()),
            ),*//*
            title: Text(this.employees[position].name),
            subtitle:Text(this.employees[position].address),
            onTap: () {
              debugPrint("Tapped on " + this.employees[position].id.toString());
             // navigateToDetail(this.employees[position]);
            },
          )*/

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.employees[position].name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),),
              Text(this.employees[position].address,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),),
              Text(this.employees[position].salary.toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),),
            ],
          )),
        );
      },
    );
  }
  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final employee = helper.getEmployees();
      employee.then((result){
        List<Employee> employeeList = List<Employee>();
        count = result.length;
        for (int i=0; i<count; i++) {
          employeeList.add(Employee.fromObject(result[i]));
          debugPrint(employeeList[i].name);
        }
        setState(() {
          employees = employeeList;
          count = count;
        });
        debugPrint("Items " + count.toString());
      });
    });
  }


  Color getColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }
  }

  /*void navigateToDetail(Employee employee) async {
    bool result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => TodoDetail(todo)),
    );
    if (result == true) {
      getData();
    }
  }*/
}







