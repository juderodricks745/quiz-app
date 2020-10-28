import 'package:get/get.dart';
import 'package:quizapp/models/item_model.dart';
import 'package:quizapp/utils/constants.dart';

class HomeController extends GetxController {

  RxString _typeID = "".obs;
  String get type => _typeID.value;
  set type(value) => this._typeID.value = value;

  RxString _categoryID = "".obs;
  String get category => _categoryID.value;
  set category(value) => this._categoryID.value = value;

  RxString _difficultyID = "".obs;
  String get difficulty => _difficultyID.value;
  set difficulty(value) => this._difficultyID.value = value;

  final List<ItemModel> types = AppConstants.type;
  final List<ItemModel> categories = AppConstants.categories;
  final List<ItemModel> difficulties = AppConstants.difficulty;
}