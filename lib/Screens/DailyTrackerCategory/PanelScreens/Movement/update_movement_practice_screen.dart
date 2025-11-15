import 'package:ekvi/Components/Movements/movement_form.dart';
import 'package:ekvi/Components/Movements/movement_shell.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_vault_provider.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateMovementPracticeScreen extends StatelessWidget {
  final ScreenArguments args;
  const UpdateMovementPracticeScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    context.read<MovementVaultProvider>().initialiseFields(model: args.movementPractice);
    return MovementShell(
      title: 'Edit practice',
      body: MovementForm(
        isEdit: true,
        onSubmit: () => context.read<MovementVaultProvider>().submitPracticeData(context),
      ),
    );
  }
}
