import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main()=>runApp(MiApp());
class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App Final",
      home: Inicio(),
    );
  }
}
class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  
  Future <List<Person>>getData() async {
  var response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/comments"),
    headers: {"Accept":"Application/json"}
  );
  var data=json.decode(response.body);
  print(data);
  List<Person> persona=[];
  for(var p in data){
    Person person=Person(p["Name"], p["Email"]);
    persona.add(person);
  }
  print(persona.length);
  return persona;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title:Text("Nico App")
    ),
    body: Container(
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext  context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if(snapshot.data == null){
            return Container(child: Center(child: Text("loading..."),),);
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int name){
                return ListTile(title:Text(snapshot.data[name].email),
                subtitle: Text(snapshot.data[name].email.toString()),
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
  final int name;
  final String email;

  Person (this.name, this.email);
}
