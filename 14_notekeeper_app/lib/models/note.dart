class Note {
  int _id;
  String _title;
  String _desc;
  String _date;
  int _priority;

  Note(this._title,this._priority,this._date,[this._desc]);
  Note.withId(this._id,this._priority,this._date,this._title,[this._desc]);

  set title(String newTitle){
    if(newTitle.length<=50){
      this._title=newTitle;
    }
  }

  set desc(String newDesc){
    this._desc=newDesc;
  }

  set date(String newDate){
    this._date=newDate;
  }
  set priority(int newPriority){
    if(newPriority>=0 && newPriority<=2){
      this._priority=newPriority;
    }
  }

  int get id=>_id;
  String get title => _title;
  String get desc => _desc;
  String get date => _date;
  int get priority => _priority;

  Map <String,dynamic> toMap(){
    Map <String,dynamic> map = Map();
    if(id!=null){
      map['id']=_id;
    }
    map['title']=_title;
    map['desc']=_desc;
    map['priority']=_priority;
    map['date']=_date;
    return map;
  }

  Note.fromMap(Map<String,dynamic> map){
    this._id=map['id'];
    this._title=map['title'];
    this._desc=map['desc'];
    this._priority=map['priority'];
    this._date=map['date'];
  }




}