### Networking

Back to README: [../README.md](../README.md)

The network layer centralizes HTTP calls and error handling, with endpoints enumerated in one place.

### Structure

- Base helper: `lib/Network/api_base_helper.dart`
- Endpoints: `lib/Network/api_links.dart`
- Exceptions: `lib/Network/api_exception.dart`
- Feature services use the helper and links: `lib/Services/**`

### Base client

```11:24:lib/Network/api_base_helper.dart
class ApiBaseHelper {
  static Future<dynamic> httpGetRequest(String endPoint,{Map<String, String>? queryParams}) async {
    final response = await http.get(Uri.parse('${AppConstant.appBaseURL}$endPoint').replace(queryParameters: queryParams), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await HelperFunctions.getAccessToken()}',
    });
    return _returnResponse(response);
  }
}
```

Other verbs: `httpPostRequest`, `httpPatchRequest`, `httpPutRequest`, `httpDeleteRequest`, and multipart uploading.

### Error handling

```158:179:lib/Network/api_base_helper.dart
switch (response.statusCode) {
  case 200:
  case 201:
    return jsonResponse;
  case 400: throw BadRequestException(jsonResponse['message'] ?? AppConstant.exceptionMessage);
  case 401: throw UnauthorisedException("You've been logged out due to session timeout.");
  default: throw FetchDataException(jsonResponse['message'] ?? AppConstant.exceptionMessage);
}
```

Exceptions are defined in `lib/Network/api_exception.dart`.

### Endpoints

All path constants live in `lib/Network/api_links.dart`, grouped by feature (User, Onboarding, Dashboard, Daily Tracker, Pain Relief, Reminders, Cycle, Insights, Journeys).

```1:9:lib/Network/api_links.dart
class ApiLinks {
  static const String createUser = "/user";
  static const String updateUser = "/user";
  static const String getUser = "/user";
  // ...
}
```

Base URL and environment are defined in `lib/Utils/constants/app_constant.dart`:

```17:22:lib/Utils/constants/app_constant.dart
static const String appBaseURL = 'https://prod.ekvi.io';
static const String appEnvironment = 'prod';
```

### Auth

- Access token is fetched from shared preferences via `HelperFunctions.getAccessToken()` and used in the `Authorization` header.

### Timeouts/retries

- Timeouts are implicitly handled by catching `TimeoutException`; no retry policy is implemented by default.
