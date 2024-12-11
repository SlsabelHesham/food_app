import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/search_edit_text_widget.dart';
import 'package:food_app/presentation/widgets/choise_chip.dart';
import 'package:food_app/styles/text_styles.dart';
import 'package:food_app/styles/theme.dart';

class FilterScreen extends StatefulWidget {
  final SearchBloc searchBloc;

  const FilterScreen({super.key, required this.searchBloc});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedType = "";
  String selectedLocation = "";
  List<String> selectedFoods = [];

  void _toggleFilterChip(String label, List<String> filterList) {
    setState(() {
      if (filterList.contains(label)) {
        filterList.remove(label);
      } else {
        filterList.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.searchBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSearchEditText(context),
                            const SizedBox(height: 20),
                            Text(
                              "Type",
                              style: TextStyles.mainTitle(),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              children: [
                                GenericChoiceChip(
                                  label: "Restaurant",
                                  isSelected: selectedType == "Restaurant",
                                  onTap: () {
                                    setState(() {
                                      selectedType = "Restaurant";
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: "Menu",
                                  isSelected: selectedType == "Menu",
                                  onTap: () {
                                    setState(() {
                                      selectedType = "Menu";
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Location",
                              style: TextStyles.mainTitle(),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              children: [
                                GenericChoiceChip(
                                  label: "1 Km",
                                  isSelected: selectedLocation == "1 Km",
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = "1 Km";
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: ">10 Km",
                                  isSelected: selectedLocation == ">10 Km",
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = ">10 Km";
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: "<10 Km",
                                  isSelected: selectedLocation == "<10 Km",
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = "<10 Km";
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Food",
                              style: TextStyles.mainTitle(),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                GenericChoiceChip(
                                  label: "food",
                                  isSelected: selectedFoods.contains("food"),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip("food", selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: "soup",
                                  isSelected: selectedFoods.contains("soup"),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip("soup", selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: "Main Course",
                                  isSelected:
                                      selectedFoods.contains("Main Course"),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          "Main Course", selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: "Appetizer",
                                  isSelected:
                                      selectedFoods.contains("Appetizer"),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          "Appetizer", selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: "Dessert",
                                  isSelected: selectedFoods.contains("Dessert"),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          "Dessert", selectedFoods);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    widget.searchBloc.add(SearchEvent(
                      mealName: _searchController.text.trim(),
                      selectedType: selectedType,
                      selectedLocation: selectedLocation,
                      selectedFoods: selectedFoods,
                    ));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 56, 214, 130),
                    minimumSize: const Size(double.infinity, 57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Search",
                    style: TextStyles.buttonText(),
                  ),
                ),
              ),
              BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (state is LoadedState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamed(
                        context,
                        Strings.resultScreen,
                        arguments: {
                          'type': state.type,
                          'restaurants': state.restaurants,
                        },
                      );
                    });
                  } else if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: Center(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is InitialState) {
                        return const SizedBox();
                      }
                      if (state is LoadingState) {
                        return const CircularProgressIndicator();
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchEditText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SearchEditText(
      enabled: true,
      controller: _searchController,
      hintText: "What do you want to order?",
      searchIconAsset: AppTheme.getSearchIconAsset(context),
      hintColor: colorScheme.onPrimaryContainer.withOpacity(0.2),
      fillColor: colorScheme.onPrimaryContainer.withOpacity(0.1),
      iconColor: colorScheme.onPrimaryContainer,
      onTap: () {},
    );
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: "Find Your \nFavorite Food",
      imageAsset: "assets/images/pattern.png",
    );
  }
}
