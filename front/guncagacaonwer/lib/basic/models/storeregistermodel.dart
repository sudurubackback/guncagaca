import 'dart:js_interop';
import 'package:dio/dio.dart';

// 가게 등록 요청데이터 모델
class StoreRegisterRequest {
  final String storeName;
  final String address;
  final String tel;
  final MultipartFile? img;
  final String description;

  StoreRegisterRequest(this.storeName, this.address, this.tel, this.img, this.description);

  FormData toFormData() {
    final formData = FormData();

    formData.fields
      ..add(MapEntry('storeName', storeName))
      ..add(MapEntry('address', address))
      ..add(MapEntry('tel', tel))
      ..add(MapEntry('description', description));

    if (img != null) {
      formData.files.add(MapEntry(
        'img',
        img!,
      ));
    }
    return formData;
  }
}

class StoreRegisterResponse {
  final int status;
  final String message;

  StoreRegisterResponse(this.status, this.message);

  factory StoreRegisterResponse.fromJson(Map<String, dynamic> json) {
    return StoreRegisterResponse(
      json['status'] as int,
      json['message'] as String,
    );
  }
}