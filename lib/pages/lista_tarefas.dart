import 'package:flutter/material.dart';
import 'package:lista_tarefa/widgets/lista_item.dart';

import '../models/todo.dart';

class ListaTarefas extends StatefulWidget {
  ListaTarefas({Key? key}) : super(key: key);

  @override
  State<ListaTarefas> createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  final TextEditingController listaController = TextEditingController();

  List<Todo> tarefas = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Lista de Tarefas',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: listaController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Adicione uma tarefa',
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black45,
                              ))),
                        ),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          if (listaController.text != '') {
                            String text = listaController.text;
                            setState(() {
                              Todo newTodo =
                                  Todo(title: text, dateTime: DateTime.now());
                              tarefas.add(newTodo);
                            });
                          }

                          listaController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff000000),
                          padding: EdgeInsets.all(5),
                          fixedSize: Size(65, 40),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in tarefas)
                        ListaItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        // usar sempre para setar o tamanho da linha no maximo da tela
                        child: Text(
                            'Você possui ${tarefas.length} tarefas pendentes'),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            tarefas.clear();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff000000),
                          padding: EdgeInsets.all(5),
                          fixedSize: Size(65, 40),
                        ),
                        child: Text('Limpar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = tarefas.indexOf(todo);
    setState(() {
      tarefas.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa ${todo.title} removida!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              tarefas.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
      ),
    );
  }
}
