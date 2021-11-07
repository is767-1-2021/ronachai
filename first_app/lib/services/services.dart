import 'dart:convert';
import 'package:first_app/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

abstract class Services {
  Future<List<Todo>> getTodos();
  Future<void> updateTodos(int idl, bool completed);
}

class FirebaseServices extends Services {
  @override
  Future<List<Todo>> getTodos() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('todos').get();

    AllTodos todos = AllTodos.fromSnapshot(snapshot);
    return todos.todos;
  }

  @override
  Future<void> updateTodos(int _id, bool completed) async {
    CollectionReference _ref = await FirebaseFirestore.instance.collection('todos');
    FirebaseFirestore.instance
        .collection('todos')
        .where('id', isEqualTo: _id)
        .get()
        .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _ref
              .doc(doc.id)
              .update({'completed': completed})
              .then((value) => print("Todos Updated"))
              .catchError((error) => print("Failed to update Todos : $error"));
        });
    });
  }

  //ไม่ได้ใช้
  Future<String> getDocumentById(int _id) async {
    String documentId = "";
    FirebaseFirestore.instance
        .collection('todos')
        .where('id', isEqualTo: _id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        documentId = doc.id;
        //print('doc:${documentId}');
      });
    });
    return documentId;
  }
}

class HttpServices extends Services{
  Client client = Client();
  Future<List<Todo>> getTodos() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(
        json.decode(response.body),
      );

      return all.todos;
    }

    throw Exception('Failed to load todos');
  }

  @override
  Future<void> updateTodos(int idl, bool completed) {
    // TODO: implement updateTodos
    throw UnimplementedError();
  }
}
