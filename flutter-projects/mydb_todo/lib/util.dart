class Util {
  static const priorities = ['High', 'Low'];

  static String getPrioritiyAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0];
        break;
      case 2:
        priority = priorities[1];
        break;
    }
    return priority;
  }
}
