class AppException implements Exception {
  AppException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => message;
}

class CacheException extends AppException {
  CacheException(super.message, {super.code});
}

class DatabaseException extends AppException {
  DatabaseException(super.message, {super.code});
}

class ValidationException extends AppException {
  ValidationException(super.message, {super.code});
}
