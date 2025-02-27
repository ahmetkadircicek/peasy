import 'package:peasy/features/home/model/category_model.dart';

class SectionModel {
  final String title;
  final List<CategoryModel> categories;

  SectionModel({
    required this.title,
    required this.categories,
  });
}
