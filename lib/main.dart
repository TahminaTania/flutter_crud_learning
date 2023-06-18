import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_learning/cubit/todo_cubit.dart';
import 'package:flutter_crud_learning/repository.dart';
import 'package:flutter_crud_learning/todo_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DataRepository repository = DataRepository(http.Client());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(repository),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoPage(),
      ),
    );
  }
}
