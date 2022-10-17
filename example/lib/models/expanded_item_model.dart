import 'package:flutter/material.dart';

class ExpandedItemModel {
  const ExpandedItemModel(
      {required this.title,
      required this.body,
      required this.icon,
      required this.definition});
  final String title;
  final String icon;
  final Widget body;
  final String definition;
}
