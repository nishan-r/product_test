
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_test/utils/common_widgets/common_button.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../controller/home_controller.dart';

class CustomFilterSheet extends StatefulWidget {
   CustomFilterSheet({
    super.key, required this.homeController,
  });

  final HomeController homeController;

  @override
  State<CustomFilterSheet> createState() => _CustomFilterSheetState();
}

class _CustomFilterSheetState extends State<CustomFilterSheet> {
  final Set<String> _selectedCategories = {};
  final Set<String> _selectedTags = {};

  double _selectedPrice = 100;

 

  @override
void initState() {
  super.initState();
  _selectedCategories.addAll(widget.homeController.selectedCategories);
  _selectedTags.addAll(widget.homeController.selectedTags);
  _selectedPrice = widget.homeController.maxPrice.value;
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.filter_alt_outlined),
                Text('Filter'),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
              ],
            ),
            TabBar(tabs: [
              Tab(text: 'Category'),
              Tab(text: 'Price'),
              Tab(text: 'Tags'),
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                shrinkWrap: true,
                itemCount: AppConstants.categories.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.categories[index];
                  final isSelected = _selectedCategories.contains(category);
                  return ListTile(
                    title: Text(category),
                    trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedCategories.remove(category);
                        } else {
                          _selectedCategories.add(category);
                        }
                      });
                    },
                  );
                },
              ),
                 Column(
                  children: [
                    SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                    ),
                    child: Slider(
                      value: _selectedPrice,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: '\$${_selectedPrice.toInt()}',
                      onChanged: (value) {
                        setState(() {
                          _selectedPrice = value;
                        });
                      },
                    ),
                  ),
                  Text('Max Price: \$${_selectedPrice.toInt()}'),
                  ],
                 ),
                  ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                child: Column(
                  children: AppConstants.tagsList.map((tag) {
                    final isSelected = _selectedTags.contains(tag);
                    return ListTile(
                      title: Text(tag),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        setState(() {
                          isSelected ? _selectedTags.remove(tag) : _selectedTags.add(tag);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
                ]
              ),
            ),
        
            Row(
              children: [
                Expanded(child: CommonButton(title: 'Back', onTap: (){})),
                Expanded(child: CommonButton(title: 'Apply', onTap: (){
                  // widget.homeController.selectedCategories
                  //   ..clear()
                  //   ..addAll(_selectedCategories);
        
                  // widget.homeController.selectedTags
                  //   ..clear()
                  //   ..addAll(_selectedTags);
        
                  // widget.homeController.maxPrice.value = _selectedPrice;
                  // widget.homeController.applyFilters();
        
                  log('max price----${_selectedPrice}');
                  Navigator.pop(context);
                }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
