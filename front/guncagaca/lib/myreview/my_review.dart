
class MyReview {
  final int reviewId;
  final int storeId;
  final String storeName;
  final String img;
  final String comment;
  final double starTotal;
  final double star;

  MyReview({
    required this.storeId,
    required this.storeName,
    required this.img,
    required this.reviewId,
    required this.comment,
    required this.starTotal,
    required this.star
  });

  factory MyReview.fromMap(Map<String, dynamic> map) {
    return MyReview(
      reviewId: map['id'],
      storeName: map['storeName'],
      storeId: map['storeId'],
      img: map['img'],
      comment: map['comment'],
      starTotal: map['starTotal'],
      star: map['star'],
    );
  }

}