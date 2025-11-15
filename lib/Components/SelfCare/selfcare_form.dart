import 'package:ekvi/Components/SelfCare/selfcare_delete_dialog.dart';
import 'package:ekvi/Components/SelfCare/selfcare_dropdown.dart';
import 'package:ekvi/Components/SelfCare/selfcare_text_and_switch.dart';
import 'package:ekvi/Components/SelfCare/selfcare_trigger_option_chip.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_vault_provider.dart';
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

class SelfcareForm extends StatefulWidget {
  final bool isEdit;
  final VoidCallback onSubmit;
  const SelfcareForm({super.key, required this.isEdit, required this.onSubmit});

  @override
  State<SelfcareForm> createState() => _SelfcareFormState();
}

class _SelfcareFormState extends State<SelfcareForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelfcareVaultProvider>();
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
                      content: const SelfcareDescriptionWidget(),
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
              SelfcareDropdown<String>(
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
              SelfcareTextAndSwitch(
                  text: 'Show in tracker',
                  value: provider.isVisibleInTracker,
                  callback: provider.setIsVisibleInTracker),
              const SizedBox(height: 16),
              SelfcareTextAndSwitch(
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
                          SelfcareTriggerOptionChip(option: symptom))
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
              onPressed: provider.validateSelfcareData(context, false)
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
                            return SelfcareDeleteAlertDialog(
                              title:
                                  'Are you sure you want to delete this practice?',
                              subtitle:
                                  'You will not be able to restore or see this practice when it is deleted.',
                              buttionTitle: 'Delete practice',
                              onPress: () {
                                final vaultProvider =
                                    Provider.of<SelfcareVaultProvider>(context,
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

class SelfcareDescriptionWidget extends StatelessWidget {
  const SelfcareDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bulletStyle = textTheme.titleSmall?.copyWith(
        color: AppColors.neutralColor600, fontWeight: FontWeight.w700);
    final bodyStyle = textTheme.bodySmall
        ?.copyWith(color: AppColors.neutralColor600, height: 1.6);

    final items = <Map<String, String>>[
      {
        'title': 'Restorative',
        'body':
            'For when you’re tired, overwhelmed, or in need of pause. These practices help you slow down and restore your energy. Think: bubble baths, alone time, naps, soft blankets, silence.'
      },
      {
        'title': 'Regulating',
        'body':
            'Helps bring your nervous system into balance—from overdrive or shutdown back to safety and flow. Think: breathwork, fascia release, stretching, sound baths, cuddles.'
      },
      {
        'title': 'Emotional care',
        'body':
            'For when you’re feeling big emotions (or numbness). These practices help you feel, express, and process what’s inside. Think: journaling, crying, therapy, deep talks, gratitude.'
      },
      {
        'title': 'Nourishing',
        'body':
            'Gives something back to your body or soul—comfort, warmth, or sustenance. Think: tea, massage, comfort food, face oil, sunlight on your skin.'
      },
      {
        'title': 'Relational',
        'body':
            'Involves safe connection, boundaries, or co-regulation with others. Think: time with loved ones, saying no, community, pet snuggles.'
      },
      {
        'title': 'Creative',
        'body':
            'Brings beauty, wonder, or expression into your life—with no pressure to perform. Think: music, art, writing, play, dancing, daydreaming.'
      },
      {
        'title': 'Reclaiming',
        'body':
            'Helps you reconnect with your power, identity, cycle, or voice. Think: setting boundaries, menstrual rest, learning, doing nothing on purpose.'
      },
      {
        'title': 'Spiritual',
        'body':
            'Connects you to something bigger—nature, meaning, ancestors, intuition, or the divine. Think: prayer, ritual, oracle cards, awe, sacred space.'
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add or edit your self-care practice',
            style: textTheme.headlineSmall
                ?.copyWith(color: AppColors.neutralColor600),
          ),
          const SizedBox(height: 24),
          Text(
            'Make it yours! Here’s how to fill out each field:',
            style: bodyStyle,
          ),
          const SizedBox(height: 16),
          _buildSection(
              'Emoji',
              'Choose an emoji that captures the vibe of your practice. Whether it’s 🌊 for a bath, 📚 for reading, or 🕯️ for a grounding ritual — emojis make your list easy to recognize and a little more joyful to scroll.',
              textTheme),
          _buildSection(
              'Name',
              'Choose a short, clear name you’ll recognize right away. Think “Bubble bath,” “Journaling,” or “Nature walk.” This name will show up in your tracker and insights, so make it feel like you.',
              textTheme),
          _buildSection(
            'Type',
            'Select the type of care this practice gives you. This helps Ekvi understand what you’re needing — and what’s truly helping. You can choose from:',
            textTheme,
          ),
          const SizedBox(height: 12),
          // now render bullets as separate Rows
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' • ', style: bulletStyle),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${item['title']}: ', style: bulletStyle),
                          TextSpan(text: item['body'], style: bodyStyle),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Text(
            '\nEvery practice you log is a little love note to yourself. You’re not just tracking data — you’re honoring what holds you together💜',
            style: bodyStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String subtitle, TextTheme textTheme) {
    final titleStyle = textTheme.titleSmall?.copyWith(
        color: AppColors.neutralColor600, fontWeight: FontWeight.w700);
    final bodyStyle = textTheme.bodySmall
        ?.copyWith(color: AppColors.neutralColor600, height: 1.6);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 4),
        Text(subtitle, style: bodyStyle),
        const SizedBox(height: 16),
      ],
    );
  }
}
