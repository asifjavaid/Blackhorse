import 'package:ekvi/Components/PainRelief/pain_relief.dart';
import 'package:ekvi/Components/PainRelief/pain_relief_form.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPainReliefScreen extends StatelessWidget {
  const AddPainReliefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PainReliefVaultProvider>().initialiseFields(model: null);
    return PainReliefShell(
      title: 'New practice',
      body: PainReliefForm(
        isEdit: false,
        onSubmit: () => context.read<PainReliefVaultProvider>().submitPracticeData(context),
      ),
    );
  }
}
