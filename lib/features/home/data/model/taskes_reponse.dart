class TaskModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TaskModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  // Factory constructor to create an instance from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }
}

class TaskessResponse {
  final List<TaskModel> todos;
  final int total;
  final int skip;
  final int limit;

  TaskessResponse({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  // Factory constructor to create an instance from JSON
  factory TaskessResponse.fromJson(Map<String, dynamic> json) {
    var todoList =
        (json['todos'] as List).map((i) => TaskModel.fromJson(i)).toList();

    return TaskessResponse(
      todos: todoList,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((todo) => todo.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}
