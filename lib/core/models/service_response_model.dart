class ServiceResponse {
  final String successMessage;
  final String errorMessage;
  final String? responseMessage;

  ServiceResponse({
    this.successMessage = '',
    this.errorMessage = 'An error occurred',
    this.responseMessage,
  });
}
