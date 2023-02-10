import 'package:flutter/material.dart';
import 'package:lista_tarefa/pages/lista_tarefas.dart';

void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListaTarefas(),
    );
  }
}
