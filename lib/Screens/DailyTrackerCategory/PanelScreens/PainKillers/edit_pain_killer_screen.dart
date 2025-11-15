import 'package:ekvi/Components/PainKillers/pain_killer_form.dart';
import 'package:ekvi/Components/PainKillers/pain_killer_shell.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPainKillerScreen extends StatelessWidget {
  final ScreenArguments args;
  const EditPainKillerScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    context.read<PainKillersVaultProvider>().initialiseFields(model: args.painkiller);

    return PainKillerShell(
      title: 'Edit Painkiller',
      body: PainKillerForm(
        isEdit: true,
        onSubmit: () => context.read<PainKillersVaultProvider>().submitPainkillerData(context),
      ),
    );
  }
}
