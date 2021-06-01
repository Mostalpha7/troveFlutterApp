class Exceptions {
  String message;

  Exceptions({this.message});

  Map throwError() {
    return {"message": this.message};
  }
}
