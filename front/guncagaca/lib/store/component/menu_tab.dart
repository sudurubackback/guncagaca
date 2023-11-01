import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guncagaca/menu/menu_detail.dart';
import 'package:guncagaca/menu/menu_card.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/dio_client.dart';
import '../../menu/menu.dart';

class MenuTabWidget extends StatefulWidget {
  final int cafeId;
  final String storeName;

  MenuTabWidget({required this.cafeId, required this.storeName});

  @override
  _ReviewTabWidgetState createState() => _ReviewTabWidgetState();
}

class _ReviewTabWidgetState extends State<MenuTabWidget> {
  List<Menu> menus = [];

  @override
  void initState() {
    super.initState();
    fetchMenuList();  // 가상의 메서드, 실제 구현이 필요합니다.
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<List<Menu>> fetchMenuList() async {
    final String apiUrl = "$baseUrl/api/store/${widget.cafeId}/menu";

    final response = await dio.get(apiUrl);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((json) => Menu.fromMap(json)).toList();
    } else {
      throw Exception("Failed to fetch menus.");
    }
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DefaultLayout(
                    title: widget.storeName,
                    child: DetailPage(menu: menus[index])),
              ),
            );
          },
          child: MenuCard(menu: menus[index],
          ),
        );
      },
    );
  }
}
