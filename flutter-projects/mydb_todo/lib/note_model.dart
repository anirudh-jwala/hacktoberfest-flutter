class NoteModel {
  final int id;
  final String title;
  final String desc;
  final int priority;

  NoteModel({this.id, this.title, this.desc, this.priority});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'priority': priority,
    };
  }
}
