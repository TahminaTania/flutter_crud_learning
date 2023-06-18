import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_crud_learning/model.dart';
import 'package:flutter_crud_learning/repository.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'todo_state.dart';

class DataCubit extends Cubit<DataState> {
  final DataRepository repository;

  DataCubit(this.repository) : super(DataLoadingState());

  Future<void> fetchTodos() async {
    try {
      final todos = await repository.fetchTodos();
      emit(DataLoadedState(todos));
    } catch (e) {
      emit(DataErrorState('Failed to fetch todos'));
    }
  }

  // Future<void> addTodo(TodoModel todo) async {
  //   try {
  //     final updatedTodos = await repository.addTodo(todo);
  //     emit(DataLoadedState(updatedTodos));
  //   } catch (e) {
  //     emit(DataErrorState('Failed to add todo'));
  //   }
  // }

  Future<void> addTodo(TodoModel todo) async {
    try {
      final updatedTodos = await repository.addTodo(todo);
      final currentState = state; // Get the current state
      if (currentState is DataLoadedState) {
        final currentTodos =
            currentState.todos; // Get the current list of todos
        final updatedList = List<TodoModel>.from(
            currentTodos); // Create a new list based on the current list
        updatedList.add(todo); // Add the new todo to the list
        emit(DataLoadedState(updatedList)); // Emit the updated list of todos
      }
    } catch (e) {
      emit(DataErrorState('Failed to add todo'));
    }
  }

  void deleteTodoById(int id) async {
    try {
      // Delete the todo item from the repository
      await repository.deleteTodoById(id);

      // Get the current state
      final currentState = state;

      if (currentState is DataLoadedState) {
        // Filter out the deleted todo from the current todo list
        final updatedTodos =
            currentState.todos.where((todo) => todo.id != id).toList();

        // Update the state with the updated todo list
        emit(DataLoadedState(updatedTodos));
      }
    } catch (e) {
      emit(DataErrorState('Failed to delete todo'));
    }
  }

  void editTodo(TodoModel updatedTodo) {
    final currentTodos = state.todos;
    final updatedTodos = currentTodos.map((todo) {
      if (todo.id == updatedTodo.id) {
        return updatedTodo;
      } else {
        return todo;
      }
    }).toList();
    emit(DataLoadedState(updatedTodos));
  }
}
