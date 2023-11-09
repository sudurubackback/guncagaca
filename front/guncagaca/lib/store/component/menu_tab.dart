import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guncagaca/menu/menu_detail.dart';
import 'package:guncagaca/menu/menu_card.dart';
import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../../common/utils/dio_client.dart';
import '../../kakao/main_view_model.dart';
import '../../menu/menu.dart';

class MenuTabWidget extends StatefulWidget {
  final int cafeId;
  final String storeName;
  final MainViewModel mainViewModel;
  final bool isOpen;

  MenuTabWidget({required this.isOpen, required this.cafeId, required this.storeName, required this.mainViewModel});

  @override
  _ReviewTabWidgetState createState() => _ReviewTabWidgetState();
}

class _ReviewTabWidgetState extends State<MenuTabWidget> {
  List<Menu> menus = [];
  Map<String, List<Menu>> categorizedMenus = {}; // 카테고리별 분류

  @override
  void initState() {
    super.initState();
    fetchMenuList().then((result) {
      setState(() {
        categorizedMenus = result;
      });
    });
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<Map<String, List<Menu>>> fetchMenuList() async {
    final String apiUrl = "$baseUrl/api/ceo/${widget.cafeId}/menu";
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = response.data;

      jsonData.forEach((category, menus) {
        List<Menu> menuList = (menus as List).map((json) => Menu.fromMap(json)).toList();

        if (categorizedMenus.containsKey(category)) {
          categorizedMenus[category]!.addAll(menuList);
        } else {
          categorizedMenus[category] = menuList;
        }
      });
      return categorizedMenus;
    } else {
      throw Exception("Failed to fetch menus.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categorizedMenus.keys.length,
      itemBuilder: (BuildContext context, int index) {
        String category = categorizedMenus.keys.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(category, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // 카테고리 이름
            ),
            Column(
              children: categorizedMenus[category]!.map((menu) {
                return InkWell(
                  onTap: () {
                    if (widget.isOpen) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DefaultLayout(
                            title: widget.storeName,
                            mainViewModel: widget.mainViewModel,
                            child: DetailPage(menu: menu, storeName: widget.storeName,),
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Column(
                            children: [
                              Text('알림'),
                              Divider(color: Colors.grey),
                            ],
                          ),
                          content: Text('영업중이 아닙니다.\n영업시간에 다시 방문해주세요.'),
                          actions: [
                            TextButton(
                              child: Text('확인', style: TextStyle(color: PRIMARY_COLOR)),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: MenuCard(menu: menu),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
