// 회원가입 요청 데이터 모델
class SignUpRequest {
  final String email;
  final String password;
  final String tel;
  final int business_id;

  SignUpRequest(this.email, this.password, this.tel, this.business_id);

  Map<String, dynamic> toJson() {
    return {
      'email' : email,
      'password' : password,
      'tel' : tel,
      'business_id' : business_id,
    };
  }
}

// 회원가입 응답 데이터 모델
class SignUpResponse {
  final int status;
  final String message;
  final Map<String, dynamic> data;

  SignUpResponse(this.status, this.message, this.data);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      json['status'] as int,
      json['message'] as String,
      json['data'] as Map<String, dynamic>,
    );
  }
}
