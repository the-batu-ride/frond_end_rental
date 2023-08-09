class UnauthorizeError implements Exception {
  final String message;

  const UnauthorizeError(this.message);
}
