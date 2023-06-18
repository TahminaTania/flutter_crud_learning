part of 'todo_cubit.dart';

// @immutable
// abstract class DataState {}

abstract class DataState extends Equatable {
  const DataState();

  List<TodoModel> get todos; // Define the getter for todos
  // ...
}

class DataInitial extends DataState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement todos
  List<TodoModel> get todos => throw UnimplementedError();
}

class DataLoadingState extends DataState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement todos
  List<TodoModel> get todos => throw UnimplementedError();
}

class DataLoadedState extends DataState {
  // final List<TodoModel> todos;

  // DataLoadedState(this.todos);
  final List<TodoModel> todos;

  const DataLoadedState(this.todos);

  @override
  List<Object?> get props => [todos];
}

class DataErrorState extends DataState {
  final String errorMessage;

  const DataErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  // TODO: implement todos
  List<TodoModel> get todos => throw UnimplementedError();
}
