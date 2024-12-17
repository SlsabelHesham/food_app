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
  FiltersScreenState createState() => FiltersScreenState();
}

class FiltersScreenState extends State<FilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedType = "";
  String selectedLocation = "";
  List<String> selectedFoods = [];
  bool hasNavigated = false;
  bool isSearchButttonDisabled = false;

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
                              Strings.typeTitle,
                              style: TextStyles.mainTitle(),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              children: [
                                GenericChoiceChip(
                                  label: Strings.restaurant,
                                  isSelected:
                                      selectedType == Strings.restaurant,
                                  onTap: () {
                                    setState(() {
                                      selectedType = Strings.restaurant;
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: Strings.menu,
                                  isSelected: selectedType == Strings.menu,
                                  onTap: () {
                                    setState(() {
                                      selectedType = Strings.menu;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              Strings.locationTitle,
                              style: TextStyles.mainTitle(),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              children: [
                                GenericChoiceChip(
                                  label: Strings.oneKm,
                                  isSelected: selectedLocation == Strings.oneKm,
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = Strings.oneKm;
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: Strings.moreThanTenKm,
                                  isSelected:
                                      selectedLocation == Strings.moreThanTenKm,
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = Strings.moreThanTenKm;
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: Strings.lessThanTenKm,
                                  isSelected:
                                      selectedLocation == Strings.lessThanTenKm,
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = Strings.lessThanTenKm;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              Strings.food,
                              style: TextStyles.mainTitle(),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                GenericChoiceChip(
                                  label: Strings.foodChip,
                                  isSelected:
                                      selectedFoods.contains(Strings.foodChip),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          Strings.foodChip, selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: Strings.soup,
                                  isSelected:
                                      selectedFoods.contains(Strings.soup),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          Strings.soup, selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: Strings.mainCourse,
                                  isSelected: selectedFoods
                                      .contains(Strings.mainCourse),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          Strings.mainCourse, selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: Strings.appetizer,
                                  isSelected:
                                      selectedFoods.contains(Strings.appetizer),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          Strings.appetizer, selectedFoods);
                                    });
                                  },
                                ),
                                GenericChoiceChip(
                                  label: Strings.dessert,
                                  isSelected:
                                      selectedFoods.contains(Strings.dessert),
                                  onTap: () {
                                    setState(() {
                                      _toggleFilterChip(
                                          Strings.dessert, selectedFoods);
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
                  onPressed: isSearchButttonDisabled
                      ? null
                      : () {
                          setState(() {
                            isSearchButttonDisabled = true;
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget.searchBloc.add(SearchEvent(
                              mealName: _searchController.text.trim(),
                              selectedType: selectedType,
                              selectedLocation: selectedLocation,
                              selectedFoods: selectedFoods,
                            ));
                          });
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: isSearchButttonDisabled
                        ? Colors.grey
                        : const Color.fromARGB(255, 56, 214, 130),
                    minimumSize: const Size(double.infinity, 57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    Strings.search,
                    style: TextStyles.buttonText(),
                  ),
                ),
              ),
              BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (hasNavigated) return;
                  if (state is LoadedState) {
                    hasNavigated = true;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamed(
                        context,
                        Strings.resultScreen,
                        arguments: {
                          Strings.searchBlock: widget.searchBloc,
                          Strings.type: state.type,
                          Strings.restaurants: state.restaurants,
                          Strings.foods: selectedFoods,
                          Strings.location: selectedLocation,
                          Strings.mealName:
                              _searchController.text.toString().trim(),
                        },
                      ).then((_) {
                        hasNavigated = false;
                      });
                    });
                  } else if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                  setState(() {
                    isSearchButttonDisabled = false;
                  });
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
      hintText: Strings.searchHint,
      searchIconAsset: AppTheme.getSearchIconAsset(context),
      hintColor: colorScheme.onPrimaryContainer.withOpacity(0.2),
      fillColor: colorScheme.onPrimaryContainer.withOpacity(0.1),
      iconColor: colorScheme.onPrimaryContainer,
      onTap: () {},
    );
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: Strings.headerText,
      imageAsset: Strings.headerImage,
    );
  }
}
