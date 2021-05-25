class ErrorResponse implements Exception {
  final String message;
  ErrorResponse(this.message);

  @override
  String toString() {
    return message;
  }

  static String statusToMessage(int statusCode) {
    if (statusCode == 500) {
      return "Sorry, something went wrong.";
    } else {
      return "Please check you internet connection.";
    }
  }
}
