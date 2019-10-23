class Note {
  int _id;
  String _title;
  String _description;
  String _date; // Alternative Date _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  // Having [] are optional parameters

  // When you want to edit that note taken down, you would use this to call and edit with help of ID
  Note.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  // Getters

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  int get priority => _priority;

  // Setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  // Used to save & retrive from database

  // Convert Note object to Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // Convert Map object to Note object

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
