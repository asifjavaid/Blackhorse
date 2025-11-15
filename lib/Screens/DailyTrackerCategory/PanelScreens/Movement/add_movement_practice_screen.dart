import 'package:ekvi/Components/Movements/movement_form.dart';
import 'package:ekvi/Components/Movements/movement_shell.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_vault_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddMovementPracticeScreen extends StatelessWidget {
  const AddMovementPracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovementVaultProvider>().initialiseFields(model: null);
    return MovementShell(
      title: 'New practice',
      body: MovementForm(
        isEdit: false,
        onSubmit: () => context.read<MovementVaultProvider>().submitPracticeData(context),
      ),
    );
  }
}
