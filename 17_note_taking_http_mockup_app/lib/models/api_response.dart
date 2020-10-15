class APIResponse<T> {
  T data;
  bool error;
  String errorMsg;

  APIResponse({this.data, this.error, this.errorMsg});
}