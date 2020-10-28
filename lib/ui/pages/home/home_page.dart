import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/models/quiz_options.dart';
import 'package:quizapp/ui/pages/home/home_controller.dart';
import 'package:quizapp/ui/pages/quiz/quiz_binding.dart';
import 'package:quizapp/ui/pages/quiz/quiz_page.dart';
import 'package:quizapp/ui/widgets/common_widgets.dart';
import 'package:quizapp/ui/widgets/items_drop_down.dart';
import 'package:quizapp/utils/colors.dart';

class HomePage extends GetView<HomeController> {

  static const ROOT_PAGE = '/';

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
            _createLabelWidget(marginTop: 25, name: "Select Category"),
            SizedBox(
              height: 15,
            ),
            ItemDropDown(
              defaultItem: controller.categories[0],
              items: controller.categories,
              selectedId: (id) {
                controller.category = id;
              },
            ),
            _createLabelWidget(marginTop: 25, name: "Select Difficulty"),
            SizedBox(
              height: 15,
            ),
            ItemDropDown(
              defaultItem: controller.difficulties[0],
              items: controller.difficulties,
              selectedId: (id) {
                controller.difficulty = id;
              },
            ),
            _createLabelWidget(marginTop: 25, name: "Select Type"),
            SizedBox(
              height: 15,
            ),
            ItemDropDown(
              defaultItem: controller.types[0],
              items: controller.types,
              selectedId: (id) {
                controller.type = id;
              },
            ),
            SizedBox(
              height: 50,
            ),
            AppButton(
              text: "Submit",
              handler: () {
                _toQuiz();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _createLabelWidget({double marginTop, String name}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          SizedBox(
            height: marginTop,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Monteserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _toQuiz() {
    Get.to(
      QuizScreen(),
      arguments: QuizOptions(
        typeId: controller.type,
        categoryId: controller.category,
        difficultyId: controller.difficulty,
      ),
      binding: QuizBinding()
    );
  }
}
