import 'package:flutter/material.dart';
import 'package:passwords_client/core/theme/form_field_theme.dart';
import 'package:passwords_client/models/category.dart';
import 'package:passwords_client/models/password.dart';
import 'package:passwords_client/providers/password_provider.dart';
import 'package:provider/provider.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  int selectedCategoryID = 0;
  String selectedCategoryName = '';

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    final List<Category> categories = [
      Category(id: 1, categoryName: "Entreterimento"),
      Category(id: 2, categoryName: "Entreterimento"),
      Category(id: 3, categoryName: "Entreterimento"),
      Category(id: 4, categoryName: "Entreterimento"),
      Category(id: 5, categoryName: "Entreterimento"),
      Category(id: 6, categoryName: "Entreterimento"),
    ];

    final teste = [];
    for (Category cat in categories) {
      teste.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedCategoryID = cat.id!;
            selectedCategoryName = cat.categoryName!;
          });
        },
        child: Container(
          margin: EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: cat.id == selectedCategoryID ? Colors.blue : Colors.white,
            border: cat.id == selectedCategoryID
                ? null
                : Border.all(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(48)),
          ),
          child: Text(cat.categoryName!,
              style: cat.id == selectedCategoryID
                  ? TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )
                  : TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    )),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text(
            'Your Categories',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        centerTitle: false,
        leadingWidth: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 8),
            child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
        leading: SizedBox.shrink(),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: 32,
              left: 24,
              right: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Here you can view, edit and delete your categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.25,
              ),
            ),
          ),
          SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [SizedBox(width: 16), ...teste],
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Editing category: $selectedCategoryName'),
                SizedBox(height: 16),
                TextFormField(
                  controller: textController,
                  decoration: getFormDecoration(context, true, 'Category name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (String? teste) {},
                  validator: (chegada) => chegada == null || chegada.isEmpty
                      ? "Can't be null"
                      : null,
                ),
                SizedBox(height: 24),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Edit Category'))),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Delete Category'))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
