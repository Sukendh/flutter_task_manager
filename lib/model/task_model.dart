class Task {
  int? id;
  String? title;
  DateTime? dueDate;
  String? description;
  int? status; // 0 - Incomplete, 1 - Complete

  Task({this.title, this.dueDate, this.description, this.status});

  Task.withId({this.id, this.title, this.dueDate, this.description, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = dueDate!.toIso8601String();
    map['description'] = description;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      title: map['title'],
      dueDate: DateTime.parse(map['date']),
      description: map['description'],
      status: map['status'],
    );
  }

}