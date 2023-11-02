import 'package:flutter/material.dart';

import '../models/review.dart';

class ReviewTabWidget extends StatelessWidget {
  final List<Review> reviews;

  const ReviewTabWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(reviews[index].title),
            subtitle: Text(reviews[index].content),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(reviews[index].rating.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}
