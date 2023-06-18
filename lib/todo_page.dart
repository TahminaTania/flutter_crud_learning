import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_learning/cubit/todo_cubit.dart';
import 'package:flutter_crud_learning/dialogs/add_todo.dart';
import 'package:flutter_crud_learning/dialogs/dialoug_utis.dart';

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  //final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DataCubit>();
    cubit.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {
          if (state is DataErrorState) {
            DialogUtils.showAlertDialog(
              context,
              'Error',
              state.errorMessage,
              () => Navigator.pop(context),
            );
          }
        },
        builder: (context, state) {
          if (state is DataLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DataLoadedState) {
            final todos = state.todos;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return ListTile(
                  title: Text(todo.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          DialogUtils.showEditTodoDialog(context, todo);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          DialogUtils.showDeleteConfirmationDialog(
                              context, todo);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is DataErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTodoPage()), // Navigate to AddTodoPage
          );
        },
      ),
    );
  }
}
