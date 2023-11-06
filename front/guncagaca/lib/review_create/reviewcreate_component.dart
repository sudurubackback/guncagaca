import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewInputComponent extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingUpdate;
  final TextEditingController textEditingController;
  final String cafeName;

  const ReviewInputComponent({
    Key? key,
    required this.rating,
    required this.onRatingUpdate,
    required this.textEditingController,
    required this.cafeName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          cafeName,
          style: TextStyle(fontSize: 25, color: Color(0xff000000)),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: RatingBar.builder(
            initialRating: rating,
            minRating: 0.5,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            glow: false,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            unratedColor: Color(0xffD9D9D9),
            onRatingUpdate: onRatingUpdate,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.25,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          margin: EdgeInsets.only(bottom: 40.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9B5748),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: textEditingController,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            maxLength: 50,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '리뷰를 작성해주세요',
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.zero,
            ),
            textInputAction: TextInputAction.newline,
          ),
        ),
      ],
    );
  }
}
