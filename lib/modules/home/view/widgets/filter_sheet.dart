import 'package:flutter/material.dart';
import 'package:product_test/utils/common_widgets/common_button.dart';
import 'package:product_test/utils/constants/app_colors.dart';
import 'package:product_test/utils/constants/app_spaces.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../controller/home_controller.dart';

class CustomFilterSheet extends StatefulWidget {
  const CustomFilterSheet({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  State<CustomFilterSheet> createState() => _CustomFilterSheetState();
}

class _CustomFilterSheetState extends State<CustomFilterSheet> {
  final _filterList = ['Category', 'Price', 'Tags'];
  int _selectedFilterIndex = 0;

  Set<String> _selectedCategories = {};
  Set<String> _selectedTags = {};
  RangeValues _rangeValues = RangeValues(0, 10000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.filter_alt_outlined),
                cmWidth10,
                Text('Filter'),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    },
                    child: Icon(Icons.close)),
              ],
            ),
          ),
          cmHeight20,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ColoredBox(
                    color: AppColors.containerBg,
                    child: ListView.builder(
                      itemCount: _filterList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = _filterList[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                          },
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: 5,
                                  color: _selectedFilterIndex == index
                                      ? AppColors.primary
                                      : null,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Text(
                                    item,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                cmWidth15,
                Expanded(
                    flex: 2, child: _buildFilterWidgets(_selectedFilterIndex))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                    child: CommonButton(
                        title: 'Reset',
                        onTap: () {
                          _clearSelectedFilters();
                        })),
                cmWidth10,
                Expanded(
                    child: CommonButton(
                        title: 'Apply',
                        onTap: () {
                          _applyFilter();
                        }))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterWidgets(int index) {
    switch (index) {
      case 0:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: AppConstants.categories.length,
          itemBuilder: (context, index) {
            final category = AppConstants.categories[index];
            final isSelected = _selectedCategories.contains(category);
            return ListTile(
              title: Text(category),
              trailing: isSelected
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
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
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '₹ ${_rangeValues.start.truncate()} - ₹ ${_rangeValues.end.truncate()}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            RangeSlider(
              values: RangeValues(_rangeValues.start, _rangeValues.end),
              labels: RangeLabels(
                  _rangeValues.start.toString(), _rangeValues.end.toString()),
              onChanged: (value) {
                setState(() {
                  _rangeValues = value;
                });
              },
              min: 0.0,
              max: 10000.0,
            ),
          ],
        );
      case 2:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: AppConstants.tagsList.length,
          itemBuilder: (context, index) {
            final tag = AppConstants.tagsList[index];
            final isSelected = _selectedTags.contains(tag);
            return ListTile(
              title: Text(tag),
              trailing: isSelected
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedTags.remove(tag);
                  } else {
                    _selectedTags.add(tag);
                  }
                });
              },
            );
          },
        );
      default:
        return SizedBox.shrink();
    }
  }

  _clearSelectedFilters() {
    _selectedCategories = {};
    _selectedTags = {};
    _rangeValues = RangeValues(0, 10000);
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
  }

  _applyFilter() {
    widget.homeController.selectedCategories
      ..clear()
      ..addAll(_selectedCategories);
    widget.homeController.selectedTags
      ..clear()
      ..addAll(_selectedTags);
    widget.homeController.rangeValues.value = _rangeValues;
    widget.homeController.applyFilters();
    Navigator.pop(context);
  }
}
