class ApiResponseModel {
  final int _statusCode;
  final String _message;
  final Map _body;

  ApiResponseModel(this._statusCode, this._message, this._body);

  String get message => _message;

  Map get body => _body;

  int get statusCode => _statusCode;
}

enum Status { loading, error, completed }
