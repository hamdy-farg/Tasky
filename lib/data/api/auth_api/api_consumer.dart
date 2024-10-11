abstract class ApiConsumer {
  // get method to get data
  Future<dynamic> get(
    String path,
    String accessToken, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });

  // post method to upload and edit data
  Future<dynamic> post(
    String path,
    String accessToken, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  // patch method to edit data
  Future<dynamic> patch(
    String path,
    String accessToken, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  // delete data of the
  Future<dynamic> delete(
    String path,
    String accessToken, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
