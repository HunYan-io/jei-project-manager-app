import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final void Function() onApprove;
  const DeleteDialog({Key? key, required this.onApprove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Attention'),
      content:
          const Text('Êtes-vous sûr de vouloir supprimer cette ressource?'),
      actions: [
        TextButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: onApprove,
          child: const Text("Supprimer"),
        ),
      ],
    );
  }
}
