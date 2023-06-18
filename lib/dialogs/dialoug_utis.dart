import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_learning/cubit/todo_cubit.dart';
import 'package:flutter_crud_learning/model.dart';

class DialogUtils {
  static void showEditTodoDialog(BuildContext context, TodoModel todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedTitle = todo.title;

        return AlertDialog(
          title: Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  updatedTitle = value;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: TextEditingController(text: todo.title),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedTodo = TodoModel(
                  id: todo.id,
                  title: updatedTitle,
                  completed: todo.completed,
                );
                context.read<DataCubit>().editTodo(updatedTodo);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  static void showDeleteConfirmationDialog(
      BuildContext context, TodoModel todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: Text('Are you sure you want to delete this todo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<DataCubit>().deleteTodoById(todo.id);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialog(BuildContext context, String title,
      String message, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
