import 'package:flutter/material.dart';

class DeliveryMainCustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final Function(bool) onChanged;

  const DeliveryMainCustomCheckbox(
      {super.key, required this.isChecked, required this.onChanged});

  @override
  DeliveryMainCustomCheckboxState createState() =>
      DeliveryMainCustomCheckboxState();
}

class DeliveryMainCustomCheckboxState
    extends State<DeliveryMainCustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isChecked);
      },
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: const Color.fromRGBO(122, 122, 122, 1),
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.isChecked
            ? const Icon(
                Icons.check,
                size: 14.0,
                color: Color.fromRGBO(122, 122, 122, 1),
              )
            : null,
      ),
    );
  }
}
