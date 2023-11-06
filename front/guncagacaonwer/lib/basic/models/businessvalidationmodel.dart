import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BusinessValidationRequest {
  final String business_name;
  final String address;
  final String business_number;
  final String owner_name;
  final String open_date;
  final String account_number;

  BusinessValidationRequest(this.business_name, this.address, this.business_number, this.owner_name, this.open_date, this.account_number);

  Map<String, dynamic> toJson() {
    return {
      'business_name' : business_name,
      'address' : address,
      'business_number' : business_number,
      'owner_name' : owner_name,
      'open_date' : open_date,
      'account_number' : account_number,
    };
  }
}

@JsonSerializable()
class BusinessValidationResponse {
  final int status;
  final String message;
  final BusinessData data;

  BusinessValidationResponse(this.status, this.message, this.data);

  factory BusinessValidationResponse.fromJson(Map<String, dynamic> json) {
    return BusinessValidationResponse(
      json['status'] as int,
      json['message'] as String,
      BusinessData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

@JsonSerializable()
class BusinessData {
  final int business_id;

  BusinessData(this.business_id);

  factory BusinessData.fromJson(Map<String, dynamic> json) {
    return BusinessData(
      json['business_id'] as int,
    );
  }
}
