class Task {
  int? id;
  String title;
  String description;
  String date;
  bool completed;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.completed = false,
  });

  // Converte um objeto Task para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'completed': completed ? 1 : 0, // Armazena como inteiro (0 ou 1)
    };
  }

  // Converte um Map para um objeto Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      completed: map['completed'] == 1 ? true : false,
    );
  }
}
