import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_learning/cubit/todo_cubit.dart';
import 'package:flutter_crud_learning/model.dart';
// class TodoPage extends StatefulWidget {
//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//   final TextEditingController _titleController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     final cubit = context.read<DataCubit>();
//     cubit.fetchTodos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo App'),
//       ),
//       body: BlocConsumer<DataCubit, DataState>(
//         listener: (context, state) {
//           if (state is DataErrorState) {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text('Error'),
//                 content: Text(state.errorMessage),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text('OK'),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is DataLoadingState) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is DataLoadedState) {
//             final todos = state.todos;
//             return ListView.builder(
//               itemCount: todos.length,
//               itemBuilder: (context, index) {
//                 final todo = todos[index];

//                 return ListTile(
//                   title: Text(todo.title),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () {
//                           _showEditTodoDialog(context, todo);
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () {
//                           _showDeleteConfirmationDialog(context, todo);
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else if (state is DataErrorState) {
//             return Center(
//               child: Text(state.errorMessage),
//             );
//           }

//           return Container();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           _showAddTodoDialog(context);
//         },
//       ),
//     );
//   }

//   void _showEditTodoDialog(BuildContext context, TodoModel todo) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String updatedTitle = todo.title;

//         return AlertDialog(
//           title: Text('Edit Todo'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   updatedTitle = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                 ),
//                 controller: TextEditingController(text: todo.title),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final updatedTodo = TodoModel(
//                   id: todo.id,
//                   title: updatedTitle,
//                   completed: todo.completed,
//                 );
//                 context.read<DataCubit>().editTodo(updatedTodo);
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showDeleteConfirmationDialog(BuildContext context, TodoModel todo) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Todo'),
//           content: Text('Are you sure you want to delete this todo?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 context.read<DataCubit>().deleteTodoById(todo.id);
//                 Navigator.pop(context);
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showAddTodoDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String title = '';

//         return AlertDialog(
//           title: Text('Add Todo'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _titleController,
//                 onChanged: (value) {
//                   title = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 final todo = TodoModel(
//                   id: DateTime.now().millisecondsSinceEpoch,
//                   title: title,
//                   completed: true,
//                 );

//                 try {
//                   // Add the todo
//                   await context.read<DataCubit>().addTodo(todo);
//                   // Clear the text field
//                   _titleController.clear();
//                   // Close the dialog
//                   Navigator.pop(context);
//                 } catch (e) {
//                   // Handle error
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text('Error'),
//                         content: Text('Failed to add todo.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }