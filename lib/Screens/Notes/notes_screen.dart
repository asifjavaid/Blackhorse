import 'package:flutter/material.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';

class NotesScreen extends StatefulWidget {
  final ScreenArguments arguments;

  const NotesScreen({super.key, required this.arguments});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notesController.text = widget.arguments.notes ?? '';
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InputDecoration(
      hintText: 'Add a note...',
      hintStyle: textTheme.bodyMedium!.copyWith(color: AppColors.neutralColor500),
      filled: true,
      fillColor: AppColors.neutralColor50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              BackNavigation(
                title: 'Notes',
                callback: () => AppNavigation.goBack(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: notesController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 10,
                    decoration: _inputDecoration(context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                  title: 'Save note',
                  onPressed: () => widget.arguments.notesCallback?.call(notesController.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
