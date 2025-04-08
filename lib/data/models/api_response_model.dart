class ApiResponseModel {
  final int statusCode;
  final String message;
  final Map data;

  ApiResponseModel(this.statusCode, this.message, this.data );
}
