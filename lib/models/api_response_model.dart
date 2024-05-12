class ApiResponseModel {
  final int _statusCode;
  final String _message;
  final String _body;

  ApiResponseModel(this._statusCode, this._message, this._body);

  String get message => _message;

  String get body => _body;

  int get statusCode => _statusCode;
}

enum Status { loading, error, completed }
