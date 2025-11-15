import 'package:ekvi/Components/SelfCare/selfcare_form.dart';
import 'package:ekvi/Components/SelfCare/selfcare_shell.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_vault_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddSelfcareScreen extends StatelessWidget {
  const AddSelfcareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SelfcareVaultProvider>().initialiseFields(model: null);
    return SelfcareShell(
      title: 'New practice',
      body: SelfcareForm(
        isEdit: false,
        onSubmit: () => context.read<SelfcareVaultProvider>().submitPracticeData(context),
      ),
    );
  }
}
