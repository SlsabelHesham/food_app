import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/presentation/widgets/search_edit_text_widget.dart';
import 'package:food_app/styles/theme.dart';

class SearchBarWidget extends StatelessWidget {
  final BuildContext context;
  final String searchHintText;
  final String filterImageAsset;
  final Color backgroundColor;

  const SearchBarWidget({
    super.key,
    required this.context,
    required this.searchHintText,
    required this.filterImageAsset,
    this.backgroundColor = const Color.fromARGB(255, 249, 168, 77),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: Row(
        children: [
          Flexible(
            child: _buildSearchEditText(context),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 11, bottom: 11, left: 14, right: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage(filterImageAsset),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchEditText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SearchEditText(
      controller: TextEditingController(),
      enabled: false,
      hintText: "What do you want to order?",
      searchIconAsset: AppTheme.getSearchIconAsset(context),
      hintColor: colorScheme.onPrimaryContainer.withOpacity(0.2),
      fillColor: colorScheme.onPrimaryContainer.withOpacity(0.1),
      iconColor: colorScheme.onPrimaryContainer,
      onTap: () {
        Navigator.pushNamed(
          context,
          Strings.filterScreen,
          arguments: context.read<SearchBloc>(),
        );
      },
    );
  }
}
