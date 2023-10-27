import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/store/component/intro_tab.dart';
import 'package:guncagaca/store/component/menu_tab.dart';
import 'package:guncagaca/store/component/review_tab.dart';

import '../../menu/menu.dart';
import '../../menu/menu_option.dart';
import '../../menu/option.dart';
import '../models/review.dart';
import '../models/store.dart';


class StoreDetailScreen extends StatefulWidget {
  final Store store;

  StoreDetailScreen({required this.store});

  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  bool isFavorite = false;

  List<MenuOption> shotOptions = [
    MenuOption(
      optionName: "샷",
      subOptions: [
        Option(label: "1샷", price: 0),
        Option(label: "2샷", price: 100),
        Option(label: "3샷", price: 200),
      ],
    ),
    MenuOption(
      optionName: "사이즈",
      subOptions: [
        Option(label: "tall", price: 0),
        Option(label: "grande", price: 300),
        Option(label: "venti", price: 600),
      ],
    ),
    // 여기에 다른 옵션 그룹을 추가할 수 있습니다.
  ];

  List<Menu> sampleMenus = [];


  List<Review> sampleReviews = [
    Review(title: '리뷰 제목 1', content: '리뷰 내용...', rating: 4.5),
    Review(title: '리뷰 제목 2', content: '리뷰 내용...', rating: 3.5),
    // ...
  ];

  @override
  void initState() {
    super.initState();

    sampleMenus = [
      Menu(
        name: '아메리카노',
        initPrice: 5000,
        imagePath: 'assets/image/coffeebean.png',
        description: '전통적인 블랙 커피',
        options: shotOptions,
      ),
      Menu(
        name: '라떼',
        initPrice: 6000,
        imagePath: 'assets/image/coffeebean.png',
        description: '부드러운 우유와 커피의 조화',
        options: shotOptions,
      ),
      Menu(
        name: '카푸치노',
        initPrice: 6500,
        imagePath: 'assets/image/coffeecup.png',
        description: '폼 우유와 함께하는 커피',
        options: shotOptions,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // 가게 사진
          Image(image: widget.store.image, height: 200.0, fit: BoxFit.fill,),
          Padding(padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // SizedBox(width: 10),
                  // 별점
                  RatingBar.builder(
                    initialRating: widget.store.rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24.0,
                    ignoreGestures: true, // 편집 방지
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(width: 8),
                  Text('${widget.store.rating}/5', style: TextStyle(fontSize: 12)),
                  SizedBox(width: 25),
                  Text(" 리뷰 ${widget.store.reviewCount} 개", style: TextStyle(fontSize: 12)),
                  SizedBox(width: 20),
                  Text(" 찜", style: TextStyle(fontSize: 12)),
                  SizedBox(width: 5),
                  // 찜 toggle
                  GestureDetector(
                    onTap: () {
                      setState(() { // 상태를 업데이트하고 화면을 다시 그립니다.
                        isFavorite = !isFavorite; // 찜하기 상태를 토글합니다.
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
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
                      height: 400, // 필요에 따라 조절
                      child: TabBarView(
                        children: [
                          MenuTabWidget(menus: sampleMenus, storeName: widget.store.name,),
                          IntroTabWidget(store: widget.store),
                          ReviewTabWidget(reviews: sampleReviews),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ],
            ),
          ),
        ],
      )
    );
  }
}