import 'package:ekvi/Components/Movements/movement_delete_dialog.dart';
import 'package:ekvi/Components/Movements/movement_dropdown.dart';
import 'package:ekvi/Components/Movements/movement_text_and_switch.dart';
import 'package:ekvi/Components/Movements/movement_trigger_option_chip.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_vault_provider.dart';
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

class MovementForm extends StatefulWidget {
  final bool isEdit;
  final VoidCallback onSubmit;
  const MovementForm({super.key, required this.isEdit, required this.onSubmit});

  @override
  State<MovementForm> createState() => _MovementFormState();
}

class _MovementFormState extends State<MovementForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovementVaultProvider>();
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
                      dividerColor: AppColors.actionColor600),
                  emojiViewConfig:
                      EmojiViewConfig(backgroundColor: AppColors.whiteColor),
                  searchViewConfig: SearchViewConfig(
                    backgroundColor: AppColors.whiteColor,
                  )));
        },
      );
    }

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Description', style: textTheme.headlineSmall),
                  GestureDetector(
                    onTap: () => HelperFunctions.openCustomBottomSheet(
                      context,
                      content: const EditPracticeWidget(),
                      height: 700,
                    ),
                    child: SvgPicture.asset(
                      '${AppConstant.assetIcons}info.svg',
                      semanticsLabel: 'Info',
                    ),
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
              // Name

              const SizedBox(height: 16),
              MovementDropdown<String>(
                options: provider.practiceTypeList,
                value: provider.practiceType,
                getLabel: (s) => s,
                onChanged: (value) {
                  if (value != null && value != 'Select type') {
                    provider.setSelectedType(value);
                  }
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MovementTextAndSwitch(
                  text: 'Show in tracker',
                  value: provider.isVisibleInTracker,
                  callback: provider.setIsVisibleInTracker),
              const SizedBox(height: 16),
              MovementTextAndSwitch(
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
                          MovementTriggerOptionChip(option: symptom))
                      .toList(),
                ),
              ],
            ]),
          ),

          const SizedBox(height: 16),

          // ---------- NOTES ----------
          Notes(
            notesText: provider.note,
            placeholderText:
                'Add your description of this practice, instructions, etc. here.',
            placeHolderFontStyle: FontStyle.normal,
            callback: provider.setNote,
          ),

          const SizedBox(height: 24),

          // ---------- ACTION BUTTONS ----------
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              onPressed: provider.validateMovementsData(context, false)
                  ? widget.onSubmit
                  : null,
              title: widget.isEdit ? 'Save changes' : 'Save practice',
            ),
          ),
          if (!widget.isEdit) const SizedBox(height: 16),
          widget.isEdit
              ? Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: CustomButton(
                    buttonType: ButtonType.secondary,
                    onPressed: () {
                      showDialog(
                          context: AppNavigation.currentContext!,
                          builder: (BuildContext context) {
                            return MovementDeleteAlertDialog(
                              title:
                                  'Are you sure you want to delete this practice?',
                              subtitle:
                                  'You will not be able to restore or see this practice when it is deleted.',
                              buttionTitle: 'Delete practice',
                              onPress: () {
                                final vaultProvider =
                                    Provider.of<MovementVaultProvider>(context,
                                        listen: false);
                                vaultProvider.deletePracticeData();
                              },
                            );
                          }).then((value) => AppNavigation.goBack());
                    },
                    title: 'Delete practice',
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class EditPracticeWidget extends StatelessWidget {
  const EditPracticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add or edit your practice',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  "Make it yours! Here’s how to fill out each field:\n",
                  textTheme),
            ],
          )),
          Text.rich(
            TextSpan(children: [
              _TitleText('Emoji ', textTheme),
            ]),
          ),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  "Choose an emoji that represents the vibe of your movement. It helps you find it faster and adds a little joy to your list! 🏃‍♀️🧘‍♀️💃🏔️\n",
                  textTheme),
            ],
          )),
          Text.rich(
            TextSpan(children: [
              _TitleText('Name ', textTheme),
            ]),
          ),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  "Give your practice a simple and recognizable name. Keep it short and sweet — like “Walking,” “Yoga,” or “Strength Class.” This name will appear in your tracker and insights.\n",
                  textTheme),
            ],
          )),
          Text.rich(
            TextSpan(children: [
              _TitleText('Type ', textTheme),
            ]),
          ),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  "Pick the type of movement this falls under. This helps Ekvi understand what kind of support it’s giving your body. You can choose from:\n",
                  textTheme),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text.rich(
              TextSpan(
                children: [
                  _TitleText('• Cardio ', textTheme),
                  _SubtitleText(
                      "– gets your heart rate up and energy flowing\n",
                      textTheme),
                  _TitleText('• Strength ', textTheme),
                  _SubtitleText(
                      "– builds muscle, supports your metabolism\n", textTheme),
                  _TitleText('• Mobility ', textTheme),
                  _SubtitleText("– helps you move freely and reduce tension\n",
                      textTheme),
                  _TitleText('• Coordination ', textTheme),
                  _SubtitleText(
                      "– supports balance and injury prevention\n", textTheme),
                  _TitleText('• Recovery ', textTheme),
                  _SubtitleText(
                      "– gentle practices that restore and heal\n", textTheme),
                  _TitleText('• Core ', textTheme),
                  _SubtitleText("– supports core strength and pelvic health\n",
                      textTheme),
                  _TitleText('• Emotional ', textTheme),
                  _SubtitleText("– helps you process, release, and reconnect\n",
                      textTheme),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TitleText extends TextSpan {
  _TitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.titleSmall?.copyWith(
              color: AppColors.neutralColor600,
              fontWeight: FontWeight.w700,
              height: 0),
        );
}

class _SubtitleText extends TextSpan {
  _SubtitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            height: 1.60,
          ),
        );
}
