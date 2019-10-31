class NoteModel {
  int id;
  String title;
  String desc;
  String date;
  int priority;

  NoteModel({this.id, this.title, this.desc, this.priority, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'priority': priority,
      'date': date
    };
  }
}
