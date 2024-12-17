import 'package:flutter/material.dart';
import 'package:food_app/styles/text_styles.dart';

class HorizontalListView extends StatelessWidget {
  final List<String> items;
  final Function(int) onItemDeleted;

  const HorizontalListView({
    super.key,
    required this.items,
    required this.onItemDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Chip(
              label: Text(
                items[index],
                style: TextStyles.filterTitle(context),
              ),
              backgroundColor: colorScheme.onPrimaryContainer.withOpacity(0.1),
              deleteIcon: Icon(
                Icons.close,
                size: 18,
                color: colorScheme.onPrimaryContainer,
              ),
              onDeleted: () {
                onItemDeleted(index);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        },
      ),
    );
  }
}
