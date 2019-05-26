import 'package:flutter/material.dart';
import 'package:flutter_employeemangement/ui/page/add.dart';
import 'package:flutter_employeemangement/ui/page/search.dart';
import 'package:flutter_employeemangement/ui/page/view.dart';
import './model/Employee.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
      return MyAppState();
  }

}
class MyAppState extends State<MyApp>
{
  int _selectedPage =0;
  final _pageOption =[
    AddPage(),
    ViewPage(),
    SearchPage()
    /*Text("Add",style: TextStyle(fontSize: 36.0),),
    Text("View",style: TextStyle(fontSize: 36.0),),
    Text("Search",style: TextStyle(fontSize: 36.0),)*/
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:Scaffold(appBar: AppBar(title: Text("Add Page"),),
       body: _pageOption[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(currentIndex: _selectedPage,
        onTap:(int index) {
          setState(() {
            _selectedPage=index;
          });

        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text("Add")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              title: Text("View")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Search")
          ),
        ],
        ),

      ) ,
    );
  }
}


