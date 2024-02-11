import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NumberInputDialog extends StatefulWidget {
  int initialValue;
  Function onAdd;
  Function onRemove;
  Function onCon;

  NumberInputDialog(
      {super.key,
      required this.initialValue,
      required this.onAdd,
      required this.onCon,
      required this.onRemove});

  @override
  // ignore: library_private_types_in_public_api
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Изменить количество'),
      content: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              widget.onRemove();
              setState(() {
                widget.initialValue = widget.initialValue - 1;
              });
            },
          ),
          Expanded(child: Text(widget.initialValue.toString())),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                widget.onAdd();
                setState(() {
                  widget.initialValue++;
                });
              }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Отмена изменений
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            widget.onCon();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
