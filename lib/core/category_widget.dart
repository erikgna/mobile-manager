import 'package:flutter/material.dart';
import 'package:passwords_client/models/category.dart';

class CategoryWidget extends StatefulWidget {
  final void Function() changeFunction;
  final Category category;
  final int selectedCategoryID;
  final String? selectedCategoryName;
  const CategoryWidget({
    Key? key,
    required this.changeFunction,
    required this.category,
    required this.selectedCategoryID,
    required this.selectedCategoryName,
  }) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.changeFunction,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: widget.category.id == widget.selectedCategoryID
              ? Colors.blue
              : Colors.white,
          border: widget.category.id == widget.selectedCategoryID
              ? null
              : Border.all(color: Colors.blue),
          borderRadius: const BorderRadius.all(Radius.circular(48)),
        ),
        child: Text(widget.category.categoryName!,
            style: widget.category.id == widget.selectedCategoryID
                ? const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )
                : const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  )),
      ),
    );
  }
}
