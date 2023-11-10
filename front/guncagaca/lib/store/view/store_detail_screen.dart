import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/custom_appbar.dart';
import 'package:guncagaca/store/component/intro_tab.dart';
import 'package:guncagaca/store/component/menu_tab.dart';
import 'package:guncagaca/store/component/review_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/dio_client.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../../menu/menu.dart';
import '../models/store_detail.dart';


class StoreDetailScreen extends StatefulWidget {
  final int storeId;
  final MainViewModel mainViewModel;

  StoreDetailScreen({required this.storeId, required this.mainViewModel});


  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  bool? isLiked;
  bool? isOpen;
  late Future<StoreDetail?> storeDetailFuture;
  late SharedPreferences prefs;
  final token = TokenManager().token;

  StoreDetail? storeDetail;

  List<Menu> sampleMenus = [];

  @override
  void initState() {
    super.initState();
    storeDetailFuture = fetchStoreDetail();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  // 가게 상세 정보를 가져오는 메서드
  Future<StoreDetail> fetchStoreDetail() async {
    final String apiUrl = "$baseUrl/api/store/${widget.storeId}";

    final response = await dio.get(
        apiUrl,
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        )
    );

    if (response.statusCode == 200) {
      print(response.data);
      isLiked = response.data['liked'];
      isOpen = response.data['open'];
      widget.mainViewModel.updateTitle(response.data['cafeName']);
      return StoreDetail.fromMap(response.data);
    } else {
      throw Exception("Failed to fetch store detail.");
    }

  }

  // 찜 상태를 토글하는 메서드
  Future<void> toggleFavorite() async {
    final String apiUrl = "$baseUrl/api/store/${widget.storeId}/like";

    final response = await dio.post(
        apiUrl,
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        )
    );

    if (response.statusCode == 200) {
      print(response.data);
      setState(() {
        isLiked = response.data['liked'];
      });
    } else {
      print("Failed to toggle favorite status.");
    }

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreDetail?>(
      future: storeDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();  // 로딩 중
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No Data');
        } else {
          storeDetail = snapshot.data!;
          return Hero(
              tag: "store",
              child: Scaffold(
                appBar: CustomAppBar(title: storeDetail!.cafeName, mainViewModel: widget.mainViewModel,),
                body: ListView(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          storeDetail!.img,
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        if (!storeDetail!.isOpen) // 영업 중 아닐때 이미지 처리
                          Positioned.fill(
                            child: Container(
                              color: Colors.black45,
                              child: Center(
                                child: Text(
                                  "영업중이\n아닙니다",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // 별점
                              RatingBar.builder(
                                initialRating: storeDetail!.starTotal,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 24.0,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              SizedBox(width: 8),
                              Text('${storeDetail!.starTotal.toStringAsFixed(2)}/5', style: TextStyle(fontSize: 12)),
                              SizedBox(width: 25),
                              Text(" 리뷰 ${storeDetail!.reviewCount} 개", style: TextStyle(fontSize: 12)),
                              SizedBox(width: 20),
                              Text(" 찜", style: TextStyle(fontSize: 12)),
                              SizedBox(width: 5),
                              // 찜 toggle
                              GestureDetector(
                                onTap: () => toggleFavorite(),
                                child: Icon(
                                  isLiked == true ? Icons.favorite : Icons.favorite_border,
                                  color: isLiked == true ? Colors.red : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          DefaultTabController(
                            length: 3,
                            child: Column(
                              children: [
                                TabBar(
                                  indicatorColor: PRIMARY_COLOR,
                                  labelColor: PRIMARY_COLOR,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: [
                                    Tab(text: "메뉴"),
                                    Tab(text: "소개"),
                                    Tab(text: "리뷰"),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Container(
                                  height: 400,
                                  child: TabBarView(
                                    children: [
                                      MenuTabWidget(isOpen: isOpen!, storeName: storeDetail!.cafeName, cafeId: storeDetail!.storeId,mainViewModel: widget.mainViewModel,),
                                      IntroTabWidget(storeDetail: storeDetail),
                                      ReviewTabWidget(cafeId: storeDetail!.storeId,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          );
        }
      },
    );
  }
}

