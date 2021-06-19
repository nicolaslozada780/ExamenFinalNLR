import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main()=>runApp(MiApp());
class MiApp extends StatelessWidget 
{
  const MiApp({Key key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
  return MaterialApp(
  title: "Mi app",
  home: Inicio(),
  );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio>
{
    Future <List<Person>>getData() async {
  var response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/comments"),
    headers: {"Accept":"Application/json"}
  );
   var data=json.decode(response.body);
  print(data);
  List<Person> person=[];
  for(var p in data){
    Person count=Person(p["id"], p["name"], p["email"]);
    person.add(count);
  }
  print(person.length);
  return person;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title:Text("nlr App")
    ),

    body: Container(
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext  context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if(snapshot.data == null){
            return Container(child: Center(child: Text("Loading..."),),);
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int id){
                return ListTile(title:Text(snapshot.data[id].name),
                subtitle: Text(snapshot.data[id].email.toString()),
                );

              },
               );
          }
        },
      ) ,
      )
    );
  }
}
class Person {
  final int id;
  final String name;
  final String email;

  Person (this.id, this.name, this.email);
}
