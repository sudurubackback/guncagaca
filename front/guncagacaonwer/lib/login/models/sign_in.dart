class TokenResult {
  final String? refreshToken;
  final String? accessToken;

  TokenResult({
    this.refreshToken,
    this.accessToken,
  });

  factory TokenResult.fromJson(Map<String, dynamic> json) {

    Map<String, dynamic> data = json['data'];
    return TokenResult(
      refreshToken: data['refreshToken'] as String?,
      accessToken: data['accessToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "refreshToken": refreshToken,
    "accessToken": accessToken,
  };
}