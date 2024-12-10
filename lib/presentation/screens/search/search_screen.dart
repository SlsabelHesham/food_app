import 'package:flutter/material.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/search_edit_text_widget.dart';
import 'package:food_app/presentation/widgets/choise_chip.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    return Scaffold(
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
                          const Text(
                            "Type",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                          const Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                          const Text(
                            "Food",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                isSelected: selectedFoods.contains("Appetizer"),
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
                                    _toggleFilterChip("Dessert", selectedFoods);
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
                onPressed: () {} /*_onSearch*/,
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 56, 214, 130),
                  minimumSize: const Size(double.infinity, 57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchEditText(BuildContext context) {
    return SearchEditText(
      enabled: true,
      controller: _searchController,
      hintText: "What do you want to order?",
      searchIconAsset: "assets/images/icon_search.png",
      hintColor: const Color.fromARGB(255, 218, 99, 23).withOpacity(0.2),
      fillColor: const Color.fromARGB(255, 249, 168, 77).withOpacity(0.1),
      iconColor: const Color.fromARGB(255, 218, 99, 23),
      onTap: () {},
    );
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: "Find Your \nFavorite Food",
      imageAsset: "assets/images/pattern.png",
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );
  }
}
