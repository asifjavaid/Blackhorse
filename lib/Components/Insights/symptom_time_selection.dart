import 'package:ekvi/Components/Insights/insights_year_month_selection.dart';
// import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:ekvi/Providers/Insights/insights_symptom_time_selection_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SymptomTimeSelection extends StatefulWidget {
  const SymptomTimeSelection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SymptomTimeSelectionState createState() => _SymptomTimeSelectionState();
}

class _SymptomTimeSelectionState extends State<SymptomTimeSelection> with SingleTickerProviderStateMixin {
  bool _isSymptomSelectionVisible = false;
  bool _isPainKillerSelectionVisible = false;
  bool _isYearMonthSelectionVisible = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _isYearMonthSelectionVisible = false;
      _isSymptomSelectionVisible = !_isSymptomSelectionVisible;
      if (_isSymptomSelectionVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _togglePainKillerDropdown() {
    setState(() {
      _isPainKillerSelectionVisible = !_isPainKillerSelectionVisible;
    });
  }

  void _toggleYearTimeSelection() {
    setState(() {
      _isSymptomSelectionVisible = false;
      _isYearMonthSelectionVisible = !_isYearMonthSelectionVisible;
      if (_isYearMonthSelectionVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InsightsSymptomTimeSelectionProvider>(context);

    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                child: InkWell(
                  onTap: _toggleDropdown,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                provider.symptoms.firstWhere((element) => element.name == provider.selectedSymptom).icon,
                                color: AppColors.actionColor600,
                                size: 16,
                              ),
                              const SizedBox(width: 10),
                              Text(provider.selectedSymptom, style: textTheme.titleSmall!.copyWith(fontSize: 12)),
                            ],
                          ),
                          Icon(
                            _isSymptomSelectionVisible ? AppCustomIcons.arrow_up : AppCustomIcons.arrow_down,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                child: InkWell(
                  onTap: _toggleYearTimeSelection,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                AppCustomIcons.calendar,
                                color: AppColors.actionColor600,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(provider.selectedMonthString, style: textTheme.titleSmall!.copyWith(fontSize: 12)),
                            ],
                          ),
                          Icon(
                            _isYearMonthSelectionVisible ? AppCustomIcons.arrow_up : AppCustomIcons.arrow_down,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_isYearMonthSelectionVisible)
          SizeTransition(
              sizeFactor: _animation,
              child: YearMonthSelection(
                toggleYearTimeSelection: _toggleYearTimeSelection,
              )),
        if (_isSymptomSelectionVisible)
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 16,
                    children: provider.symptoms.map((symptom) {
                      return GestureDetector(
                        onTap: () {
                          provider.setSelectedSymptom(symptom.name);
                          _toggleDropdown();
                          setState(() {
                            _isPainKillerSelectionVisible = false;
                          });
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: provider.selectedSymptom == symptom.name ? AppColors.secondaryColor600 : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                symptom.icon,
                                size: 16,
                                color: provider.selectedSymptom == symptom.name ? AppColors.whiteColor : AppColors.neutralColor600,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                symptom.name,
                                style: textTheme.titleSmall!.copyWith(
                                  color: provider.selectedSymptom == symptom.name ? AppColors.whiteColor : AppColors.neutralColor600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )),
          ),
        if (provider.selectedSymptom == 'Painkillers')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              child: InkWell(
                onTap: _togglePainKillerDropdown,
                borderRadius: BorderRadius.circular(30.0),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              AppCustomIcons.pill_1,
                              color: AppColors.actionColor600,
                              size: 16,
                            ),
                            const SizedBox(width: 10),
                            Text(provider.selectedActiveIngredient, style: textTheme.titleSmall!.copyWith(fontSize: 12)),
                          ],
                        ),
                        Icon(
                          _isPainKillerSelectionVisible ? AppCustomIcons.arrow_up : AppCustomIcons.arrow_down,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (_isPainKillerSelectionVisible)
          Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 16,
                  children: provider.listPainKillerIngredients.map((symptom) {
                    return GestureDetector(
                      onTap: () {
                        provider.setSelectedActiveIngredient(symptom);
                        _togglePainKillerDropdown();
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: provider.selectedActiveIngredient == symptom ? AppColors.secondaryColor600 : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              AppCustomIcons.pill_1,
                              color: provider.selectedActiveIngredient == symptom ? AppColors.whiteColor : AppColors.neutralColor600,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              symptom,
                              style: textTheme.titleSmall!.copyWith(
                                color: provider.selectedActiveIngredient == symptom ? AppColors.whiteColor : AppColors.neutralColor600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )),
      ],
    );
  }
}
