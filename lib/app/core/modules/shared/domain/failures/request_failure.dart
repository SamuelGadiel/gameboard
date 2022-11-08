import 'failure.dart';

class RequestFailure implements Failure {
  final String message;

  RequestFailure({required this.message});
}
