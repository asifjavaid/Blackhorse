import 'package:ekvi/Components/PainKillers/pain_killer_form.dart';
import 'package:ekvi/Components/PainKillers/pain_killer_shell.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddPainKillerScreen extends StatelessWidget {
  const AddPainKillerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PainKillersVaultProvider>().initialiseFields(model: null);

    return PainKillerShell(
      title: 'New Painkiller',
      body: PainKillerForm(
        isEdit: false,
        onSubmit: () => context.read<PainKillersVaultProvider>().submitPainkillerData(context),
      ),
    );
  }
}
