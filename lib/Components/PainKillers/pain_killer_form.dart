import 'package:ekvi/Components/PainKillers/pain_killer_active_ingredient_info_sheet.dart';
import 'package:ekvi/Components/PainKillers/pain_killer_delete_dialog.dart';
import 'package:ekvi/Components/PainKillers/pain_killer_dropdown.dart';
import 'package:ekvi/Components/PainKillers/pain_killers_dosage_field.dart';
import 'package:ekvi/Components/PainKillers/pain_killers_text_and_switch.dart';
import 'package:ekvi/Components/PainKillers/pain_killers_trigger_option_chip.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:ekvi/Widgets/TextFields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PainKillerForm extends StatelessWidget {
  final bool isEdit;
  final VoidCallback onSubmit;
  const PainKillerForm({super.key, required this.isEdit, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PainKillersVaultProvider>();
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: provider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- DESCRIPTION CARD ----------
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [AppThemes.shadowDown],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Description', style: textTheme.headlineSmall),
                  GestureDetector(
                    onTap: () => HelperFunctions.openCustomBottomSheet(
                      context,
                      content: const ActiveIngredientInfoSheet(),
                      height: 500,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/info.svg',
                      semanticsLabel: 'Info',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              CustomTextFormField(
                hintText: 'Name of painkiller',
                hintStyle: textTheme.titleSmall!.copyWith(color: AppColors.neutralColor500, fontStyle: FontStyle.italic),
                controller: provider.nameController,
                onChange: (v) => provider.setPainkillerName(v ?? ''),
                validator: (v) => (v == null || v.isEmpty) ? 'Please enter the painkiller name' : null,
              ),
              // Name

              const SizedBox(height: 16),

              // Ingredient dropdown
              PainKillerDropdown(
                selectedPainKillerLevel: provider.painkillerIngredient,
                isOpen: isEdit,
                onChanged: isEdit ? null : (value) => provider.setPainkillerIngredient(value ?? ''),
                items: provider.listPainKillerIngredients,
                hintText: 'Active ingredient',
              ),
              const SizedBox(height: 16),

              // Dosage
              DosageField(
                dosageController: provider.dosageController,
                selectedEntity: provider.dosageEntity,
                isOpen: !isEdit,
                onEntityChanged: provider.setDosageEntity,
                onDosageChanged: (value) => provider.setDosage(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dosage';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Only numeric values allowed';
                  }
                  return null;
                },
              ),
            ]),
          ),

          const SizedBox(height: 16),

          // ---------- SWITCHES CARD ----------
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [AppThemes.shadowDown],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextSwitch(text: 'Show in tracker', value: provider.isVisibleInTracker, callback: provider.setIsVisibleInTracker),
              const SizedBox(height: 16),
              TextSwitch(text: 'Prescription', value: provider.isPrescription, callback: provider.setIsPrescription),
              const SizedBox(height: 16),
              TextSwitch(text: 'Mark as Trigger', value: provider.isTrigger, callback: provider.setIsTrigger),
              if (provider.isTrigger) ...[
                const SizedBox(height: 16),
                Text('Which symptoms did it impact?', style: textTheme.bodySmall?.copyWith(color: AppColors.neutralColor500)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const ['Pain', 'Bleeding', 'Mood', 'Stress', 'Energy', 'Headache', 'Nausea', 'Fatigue', 'Bloating', 'Brain fog', 'Bowel movement', 'Urination', 'Exercise', 'Sleep']
                      .map((symptom) => TriggerOptionChip(option: symptom))
                      .toList(),
                ),
              ],
            ]),
          ),

          const SizedBox(height: 16),

          // ---------- NOTES ----------
          Notes(
            notesText: provider.note,
            placeholderText: 'e.g. take with food, how you felt before starting it, etc.',
            placeHolderFontStyle: FontStyle.normal,
            callback: provider.setNote,
          ),

          const SizedBox(height: 24),

          // ---------- ACTION BUTTONS ----------
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              buttonType: provider.validatePainkillerData(context, false) ? ButtonType.primary : ButtonType.secondary,
              onPressed: provider.validatePainkillerData(context, false) ? onSubmit : null,
              title: isEdit ? 'Save changes' : 'Save painkiller',
            ),
          ),
          const SizedBox(height: 16),

          isEdit
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    buttonType: ButtonType.secondary,
                    onPressed: () {
                      showDialog(
                          context: AppNavigation.currentContext!,
                          builder: (BuildContext context) {
                            return DeleteAlertDialog(
                              title: 'Are you sure you want to  delete this painkiller?',
                              subtitle: 'You will not be able to restore or see this painkiller once it is deleted.',
                              buttionTitle: 'Delete painkiller',
                              onPress: () {
                                final vaultProvider = Provider.of<PainKillersVaultProvider>(context);
                                vaultProvider.deletePainkillerData();
                              },
                            );
                          }).then((value) => AppNavigation.goBack());
                    },
                    title: 'Delete painkiller',
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
