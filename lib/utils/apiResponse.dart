class ApiResponse {
  bool success;
  String message;
  var data;

  ApiResponse({this.success, this.message, this.data});

  Map apiResponse() {
    return {
      "success": this.success,
      "message": this.message,
      "data": this.data
    };
  }
}
