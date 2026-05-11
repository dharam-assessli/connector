import "package:connector/models/auth/send_otp.dart";
import "package:connector/models/auth/sign_in_methods.dart";
import "package:connector/models/auth/verify_otp.dart";
import "package:horizon/models/api/api_result.dart";
import "package:horizon/services/api_gateway.dart";
import "package:horizon/services/api_service.dart";

class AuthRepository {
  factory AuthRepository() {
    return _singleton;
  }

  AuthRepository._internal();
  static final AuthRepository _singleton = AuthRepository._internal();

  Future<SignInMethods> getAvailableSignInMethods() async {
    SignInMethods signInMethods = SignInMethods();

    final APIResult result = await APIGateway().makeRequest(
      method: Method.get,
      endPoint: "auth/methods",
    );

    await result.when(
      apiSuccess: (APISuccess value) {
        signInMethods = SignInMethods.fromJson(value.data);
      },
      apiFailure: (APIFailure value) {
        signInMethods = SignInMethods();
      },
    );

    return Future<SignInMethods>.value(signInMethods);
  }

  Future<SendOTP> sendOTP(Map<String, dynamic> body) async {
    SendOTP sendOTP = SendOTP();

    final APIResult result = await APIGateway().makeRequest(
      method: Method.post,
      endPoint: "auth/otp/send",
      body: body,
    );

    await result.when(
      apiSuccess: (APISuccess value) {
        sendOTP = SendOTP.fromJson(value.data);
      },
      apiFailure: (APIFailure value) {
        sendOTP = SendOTP();
      },
    );

    return Future<SendOTP>.value(sendOTP);
  }

  Future<VerifyOTP> verifyOTP(Map<String, dynamic> body) async {
    VerifyOTP verifyOTP = VerifyOTP();

    final APIResult result = await APIGateway().makeRequest(
      method: Method.post,
      endPoint: "auth/otp/verify",
      body: body,
    );

    await result.when(
      apiSuccess: (APISuccess value) {
        verifyOTP = VerifyOTP.fromJson(value.data);
      },
      apiFailure: (APIFailure value) {
        verifyOTP = VerifyOTP();
      },
    );

    return Future<VerifyOTP>.value(verifyOTP);
  }

  Future<VerifyOTP> googleSignIn(Map<String, dynamic> body) async {
    VerifyOTP verifyOTP = VerifyOTP();

    final APIResult result = await APIGateway().makeRequest(
      method: Method.post,
      endPoint: "auth/google",
      body: body,
    );

    await result.when(
      apiSuccess: (APISuccess value) {
        verifyOTP = VerifyOTP.fromJson(value.data ?? <String, dynamic>{});
      },
      apiFailure: (APIFailure value) {
        verifyOTP = VerifyOTP();
      },
    );

    return Future<VerifyOTP>.value(verifyOTP);
  }

  Future<VerifyOTP> appleSignIn(Map<String, dynamic> body) async {
    VerifyOTP verifyOTP = VerifyOTP();

    final APIResult result = await APIGateway().makeRequest(
      method: Method.post,
      endPoint: "auth/apple",
      body: body,
    );

    await result.when(
      apiSuccess: (APISuccess value) {
        verifyOTP = VerifyOTP.fromJson(value.data ?? <String, dynamic>{});
      },
      apiFailure: (APIFailure value) {
        verifyOTP = VerifyOTP();
      },
    );

    return Future<VerifyOTP>.value(verifyOTP);
  }
}
