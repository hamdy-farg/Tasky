// checkIfAutherized({
//   required ApiConsumer? api,
//   required Future<Either<String, dynamic>> func,
// }) async {
//   try {
//     final response = await api!.get(EndPoint.refresh, queryParameters: {
//       ApiKey.token: CacheHelper().getData(key: ApiKey.refresh_token) != null
//           ? CacheHelper().getData(key: ApiKey.refresh_token)
//           : AuthRepo.refresh_token,
//     });
//     RefreshTokenResponse refresh_token_response =
//         RefreshTokenResponse.fromMap(response);
//     CacheHelper().saveData(
//       key: ApiKey.access_token,
//       value: refresh_token_response.access_token,
//     );
//     func;
//   } on Exception catch (e) {
//     return left(e.toString());
//     // TODO
//   }
// }

