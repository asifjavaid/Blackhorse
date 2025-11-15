import 'package:ekvi/Components/PainRelief/pain_relief.dart';
import 'package:ekvi/Components/PainRelief/pain_relief_form.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePainReliefPracticeScreen extends StatelessWidget {
  final ScreenArguments args;
  const UpdatePainReliefPracticeScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    context.read<PainReliefVaultProvider>().initialiseFields(model: args.painReliefPractice);
    return PainReliefShell(
      title: 'Edit practice',
      body: PainReliefForm(
        isEdit: true,
        onSubmit: () => context.read<PainReliefVaultProvider>().submitPracticeData(context),
      ),
    );
  }
}
