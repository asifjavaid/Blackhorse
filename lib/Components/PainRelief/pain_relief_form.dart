import 'package:ekvi/Components/PainRelief/pain_relief_delete_dialog.dart';
import 'package:ekvi/Components/PainRelief/pain_relief_dropdown.dart';
import 'package:ekvi/Components/PainRelief/pain_relief_practice_help_text.dart';
import 'package:ekvi/Components/PainRelief/pain_relief_text_and_swtich.dart';
import 'package:ekvi/Components/PainRelief/pain_relief_trigger_option_chip.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/notes.dart';
import 'package:ekvi/Widgets/TextFields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class PainReliefForm extends StatefulWidget {
  final bool isEdit;
  final VoidCallback onSubmit;
  const PainReliefForm(
      {super.key, required this.isEdit, required this.onSubmit});

  @override
  State<PainReliefForm> createState() => _PainReliefFormState();
}

class _PainReliefFormState extends State<PainReliefForm> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PainReliefVaultProvider>();
    final textTheme = Theme.of(context).textTheme;

    void openEmojiPicker(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return EmojiPicker(
            onEmojiSelected: (Category? category, Emoji emoji) {
              provider.setEmoji(emoji.emoji);
              Navigator.pop(context);
            },
            config: const Config(
              height: 400,
              bottomActionBarConfig: BottomActionBarConfig(enabled: false),
              categoryViewConfig: CategoryViewConfig(
                backgroundColor: AppColors.whiteColor,
                indicatorColor: AppColors.actionColor600,
                iconColor: AppColors.actionColor600,
                iconColorSelected: AppColors.actionColor600,
                dividerColor: AppColors.actionColor600,
              ),
              emojiViewConfig:
                  EmojiViewConfig(backgroundColor: AppColors.whiteColor),
              searchViewConfig:
                  SearchViewConfig(backgroundColor: AppColors.whiteColor),
            ),
          );
        },
      );
    }

    return Form(
      key: provider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [AppThemes.shadowDown],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Description', style: textTheme.headlineSmall),
                    GestureDetector(
                      onTap: () {
                        HelperFunctions.openCustomBottomSheet(
                          context,
                          content: const PainReliefPracticeHelpText(),
                          height: 645,
                        );
                      },
                      child:
                          SvgPicture.asset('${AppConstant.assetIcons}info.svg'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => openEmojiPicker(context),
                      child: Container(
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFEF5FF),
                          shape: OvalBorder(),
                        ),
                        width: 48,
                        height: 48,
                        child: Center(
                          child: Text(
                            provider.emoji,
                            style: textTheme.headlineSmall!.copyWith(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: CustomTextFormField(
                        hintText: 'Name of practice',
                        hintStyle: textTheme.titleSmall!.copyWith(
                            color: AppColors.neutralColor500,
                            fontStyle: FontStyle.italic),
                        controller: provider.nameController,
                        onChange: (v) => provider.setPracticeName(v ?? ''),
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Please enter the practice name'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                PainReliefDropdown<String>(
                  options: provider.practiceTypeList,
                  value: provider.practiceType,
                  getLabel: (s) => s,
                  onChanged: (value) {
                    if (value != null && value != 'Select type') {
                      provider.setSelectedType(value);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [AppThemes.shadowDown],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PainReliefTextAndSwtich(
                    text: 'Show in tracker',
                    value: provider.isVisibleInTracker,
                    callback: provider.setIsVisibleInTracker),
                const SizedBox(height: 16),
                PainReliefTextAndSwtich(
                    text: 'Mark as trigger',
                    value: provider.isTrigger,
                    callback: provider.setIsTrigger),
                if (provider.isTrigger) ...[
                  const SizedBox(height: 16),
                  Text('Which symptoms did it impact?',
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColors.neutralColor500)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: provider.triggersList
                        .map((symptom) =>
                            PainReliefTriggerOptionChip(option: symptom))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Notes(
            notesText: provider.note,
            placeholderText:
                'Leave notes here, i.e. "How did it make me feel?" or "How has this practice supported me long-term?". It will only be visible to you.',
            placeHolderFontStyle: FontStyle.normal,
            callback: provider.setNote,
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              onPressed: provider.validatePainReliefData(context, false)
                  ? widget.onSubmit
                  : null,
              title: widget.isEdit ? 'Save changes' : 'Save practice',
            ),
          ),
          if (!widget.isEdit) const SizedBox(height: 16),
          if (widget.isEdit)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: CustomButton(
                buttonType: ButtonType.secondary,
                onPressed: () {
                  showDialog(
                    context: AppNavigation.currentContext!,
                    builder: (BuildContext context) {
                      return PainReliefDeleteAlertDialog(
                        title: 'Are you sure you want to delete this practice?',
                        subtitle:
                            'You will not be able to restore or see this practice when it is deleted.',
                        buttionTitle: 'Delete practice',
                        onPress: () {
                          final vaultProvider =
                              Provider.of<PainReliefVaultProvider>(context,
                                  listen: false);
                          vaultProvider.deletePracticeData();
                        },
                      );
                    },
                  ).then((value) => AppNavigation.goBack());
                },
                title: 'Delete practice',
              ),
            ),
        ],
      ),
    );
  }
}
