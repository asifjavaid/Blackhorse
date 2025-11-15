import 'package:ekvi/Components/SelfCare/selfcare_form.dart';
import 'package:ekvi/Components/SelfCare/selfcare_shell.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_vault_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateSelfcarePracticeScreen extends StatelessWidget {
  final ScreenArguments args;
  const UpdateSelfcarePracticeScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    context.read<SelfcareVaultProvider>().initialiseFields(model: args.selfcarePractice);
    return SelfcareShell(
      title: 'Edit practice',
      body: SelfcareForm(
        isEdit: true,
        onSubmit: () => context.read<SelfcareVaultProvider>().submitPracticeData(context),
      ),
    );
  }
}
