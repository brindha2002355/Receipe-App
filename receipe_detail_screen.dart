import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe['title'])),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe['image']),
            SizedBox(height: 10),
            Text(
              recipe['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add more recipe details here, such as ingredients and nutrition
          ],
        ),
      ),
    );
  }
}
