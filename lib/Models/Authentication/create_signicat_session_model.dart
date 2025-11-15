class CreateSignicatEkviSessionResponse {
  String? id;
  String? accountId;
  String? authenticationUrl;
  String? status;
  CallbackUrls? callbackUrls;
  List<String>? allowedProviders;
  String? language;
  String? flow;
  List<String>? requestedAttributes;
  String? externalReference;
  int? sessionLifetime;
  String? requestDomain;

  CreateSignicatEkviSessionResponse(
      {this.id,
      this.accountId,
      this.authenticationUrl,
      this.status,
      this.callbackUrls,
      this.allowedProviders,
      this.language,
      this.flow,
      this.requestedAttributes,
      this.externalReference,
      this.sessionLifetime,
      this.requestDomain});

  CreateSignicatEkviSessionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    authenticationUrl = json['authenticationUrl'];
    status = json['status'];
    callbackUrls = json['callbackUrls'] != null ? CallbackUrls.fromJson(json['callbackUrls']) : null;
    allowedProviders = json['allowedProviders'].cast<String>();
    language = json['language'];
    flow = json['flow'];
    requestedAttributes = json['requestedAttributes'].cast<String>();
    externalReference = json['externalReference'];
    sessionLifetime = json['sessionLifetime'];
    requestDomain = json['requestDomain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountId'] = accountId;
    data['authenticationUrl'] = authenticationUrl;
    data['status'] = status;
    if (callbackUrls != null) {
      data['callbackUrls'] = callbackUrls!.toJson();
    }
    data['allowedProviders'] = allowedProviders;
    data['language'] = language;
    data['flow'] = flow;
    data['requestedAttributes'] = requestedAttributes;
    data['externalReference'] = externalReference;
    data['sessionLifetime'] = sessionLifetime;
    data['requestDomain'] = requestDomain;
    return data;
  }
}

class CallbackUrls {
  String? success;
  String? abort;
  String? error;

  CallbackUrls({this.success, this.abort, this.error});

  CallbackUrls.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    abort = json['abort'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['abort'] = abort;
    data['error'] = error;
    return data;
  }
}
