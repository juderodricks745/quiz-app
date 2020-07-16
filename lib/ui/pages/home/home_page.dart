import 'package:flutter/material.dart';
import 'package:quizapp/models/item_model.dart';
import 'package:quizapp/models/quiz_options.dart';
import 'package:quizapp/ui/pages/quiz/quiz_page.dart';
import 'package:quizapp/ui/widgets/items_drop_down.dart';
import 'package:quizapp/utils/colors.dart';
import 'package:quizapp/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ItemModel _type;
  ItemModel _selectedCategory;
  ItemModel _selectedDifficulty;

  final List<ItemModel> type = AppConstants.type;
  final List<ItemModel> categories = AppConstants.categories;
  final List<ItemModel> difficulty = AppConstants.difficulty;

  String _typeID;
  String _categoryID;
  String _difficultyID;

  @override
  void initState() {
    super.initState();
    // ID's selected by default
    _typeID = type[0].id;
    _categoryID = categories[0].id;
    _difficultyID = difficulty[0].id;

    _type = type[0];
    _selectedCategory = categories[0];
    _selectedDifficulty = difficulty[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(
          "Select Quiz Options",
          style: TextStyle(fontFamily: 'Monteserrat'),
        ),
        elevation: 5,
      ),
      body: Container(
        color: AppColors.bodyBg,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            _createLabelWidget("Select Category"),
            SizedBox(
              height: 15,
            ),
            ItemDropDown(
              defaultItem: _selectedCategory,
              items: categories,
              selectedId: (id) {
                _categoryID = id;
              },
            ),
            SizedBox(
              height: 25,
            ),
            _createLabelWidget("Select Difficulty"),
            SizedBox(
              height: 15,
            ),
            ItemDropDown(
              defaultItem: _selectedDifficulty,
              items: difficulty,
              selectedId: (id) {
                _difficultyID = id;
              },
            ),
            SizedBox(
              height: 25,
            ),
            _createLabelWidget("Select Type"),
            SizedBox(
              height: 15,
            ),
            ItemDropDown(
              defaultItem: _type,
              items: type,
              selectedId: (id) {
                _typeID = id;
              },
            ),
            SizedBox(
              height: 50,
            ),
            _createRaisedButton()
          ],
        ),
      ),
    );
  }

  Widget _createLabelWidget(String name) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Monteserrat',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createRaisedButton() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: 140,
          height: 50,
          child: RaisedButton(
            onPressed: () => {
              Navigator.pushNamed(
                context,
                QuizScreen.QUIZ_PAGE,
                arguments: QuizOptions(
                  typeId: _typeID,
                  categoryId: _categoryID,
                  difficultyId: _difficultyID,
                ),
              ),
            },
            color: AppColors.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              "Submit",
              style: TextStyle(
                fontFamily: 'Monteserrat',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
