import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar defaultAppBar({required String title}) {
  return AppBar(
    toolbarHeight: 100,
    title: Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 32,
        ),
      ),
    ),
    centerTitle: false,
    leadingWidth: 0,
    actions: [
      Padding(
          padding: const EdgeInsets.only(top: 24),
          child: IconButton(
              icon: const Icon(Icons.close), onPressed: () => Get.back()))
    ],
    leading: const SizedBox.shrink(),
    elevation: 0,
  );
}

Container defaultBigAppBar(
    {required String description, required BuildContext context}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.only(
      top: 8,
      bottom: 32,
      left: 24,
      right: 24,
    ),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      color: Theme.of(context).primaryColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      description,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: 1.25,
      ),
    ),
  );
}
