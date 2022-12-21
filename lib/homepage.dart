import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class ListPage extends StatefulWidget {

  const ListPage(
      {Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List todos = <dynamic>[];
  TextEditingController titleController = TextEditingController();
  bool isEdit = false;


  //Delete
  delData(var todo) async{
    await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo['id']}'));
    setState(() {
      todos.remove(todo);
    });
  }


  @override
  void initState() {
    super.initState();
    getTodo();
  }

  //GET
  getTodo() async {
    var dataUrl = 'https://jsonplaceholder.typicode.com/todos';
    var response = await http.get(Uri.parse(dataUrl));

    setState(() {
      todos = convert.jsonDecode(response.body) as List<dynamic>;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.blue,
          elevation: 0,
          title: Text('Hands On Semi Final '),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))
          ),
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return Card(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: ListTile(
                    title: Text(todo['title']),
                    leading: Checkbox(
                      value: todo['completed'],
                      onChanged: (bool? newVal){
                        setState(() {
                          todo['completed'] = newVal!;
                        });
                        print(todo('completed'));
                      },
                    ),
                    trailing: Container(
                      width: 90,
                      child: Row(children: [
                        Expanded(child: IconButton(onPressed: () {},
                            icon: const Icon(Icons.edit))),
                        Expanded(child:
                        IconButton(onPressed: () {
                          delData(todo);
                        }, icon: const Icon(Icons.delete))
                        ),
                      ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              );
            }
        )
    );
  }
}