import 'package:quizapp/models/item_model.dart';

class AppConstants {

  static List<ItemModel> type = [
    ItemModel("any", "Any"),
    ItemModel("multiple", "Multi - Choice"),
    ItemModel("boolean", "True / False")
  ];

  static List<ItemModel> difficulty = [
    ItemModel("any", "Any"),
    ItemModel("easy", "Easy"),
    ItemModel("medium", "Medium"),
    ItemModel("hard", "Hard")
  ];

  static List<ItemModel> categories = [
    ItemModel("9", "General Knowledge"),
    ItemModel("10", "Books"),
    ItemModel("14", "Television"),
    ItemModel("17", "Science & Nature"),
    ItemModel("18", "Computer"),
    ItemModel("19", "Maths"),
    ItemModel("20", "Mythology"),
    ItemModel("21", "Sports"),
    ItemModel("22", "Geography"),
    ItemModel("23", "History"),
    ItemModel("24", "Politics"),
    ItemModel("28", "Vehicles"),
    ItemModel("30", "Gadgets")
  ];
}