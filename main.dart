import 'package:flutter/material.dart';
import 'package:untitled1/services/apiservices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _queryController = TextEditingController();
  List<String> _selectedIngredients = [];
  String? _selectedDiet;
  List recipes = [];



  @override
  void initState() {
    _searchRecipes();
  }

  Future<void> _searchRecipes() async {
    final query = _queryController.text;
    final results = await apiService.searchRecipes(
      query,
      ingredients: _selectedIngredients,
      diet: _selectedDiet,
    );
    setState(() {
      recipes = results;
    });
  }

  void searchForPasta() async {
    try {
      // Calling `searchRecipes` directly with specific parameters
      List recipes = await apiService.searchRecipes(
        'pasta', // dish name as the query
        ingredients: ['tomato', 'basil'], // optional ingredients to include
        diet: 'vegetarian', // optional diet type
      );

      print(recipes);
    } catch (e) {
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Finder')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _queryController,
              decoration: InputDecoration(
                hintText: 'Search for a recipe...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchRecipes,
                ),
              ),
            ),
          ),
          // Optional: Ingredient selection and diet dropdown
          Expanded(
            child: recipes.isEmpty
                ? Center(child: Text('No recipes found'))
                : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  title: Text(recipe['title']),
                  leading: Image.network(recipe['image'] ?? ''),
                  onTap: () {
                    // Navigate to recipe detail screen
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


