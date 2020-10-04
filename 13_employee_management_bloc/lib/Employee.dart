class Employee {
  int _id;
  String _name;
  double _salary;

  Employee(this._id, this._name, this._salary);

  set id(int id) {
    this._id = id;
  }

  set name(String name) {
    this._name = name;
  }

  set salary(double salary) {
    this._salary = salary;
  }

  int get id => this._id;

  String get name => this._name;

  double get salary => this._salary;
}
