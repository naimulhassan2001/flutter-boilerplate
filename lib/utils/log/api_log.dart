import 'package:pretty_dio_logger/pretty_dio_logger.dart';

PrettyDioLogger apiLog() {
  return PrettyDioLogger(requestHeader: true, requestBody: true);
}
