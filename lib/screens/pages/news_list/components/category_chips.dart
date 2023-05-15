// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';

import '../../../../data/category_info.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key, required this.onCategorySelected});

  final ValueChanged onCategorySelected;

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int value = 0;

  ///
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        categories.length,
        (int index) {
          return ChoiceChip(
            label: Text(categories[index].nameJp),
            selected: value == index,
            onSelected: (bool isSelected) {
              setState(
                () {
                  value = isSelected ? index : 0;

                  widget.onCategorySelected(categories[index]);
                },
              );
            },
          );
        },
      ).toList(),
    );
  }
}
