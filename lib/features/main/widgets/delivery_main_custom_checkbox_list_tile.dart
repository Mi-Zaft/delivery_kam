import 'package:delivery_kam/features/main/widgets/delivery_main_custom_checkbox.dart';
import 'package:flutter/material.dart';

class DeliveryMainCustomCheckboxListTile extends StatefulWidget {
  bool isChecked;
  final Function(bool) onChanged;
  final String? label;

  DeliveryMainCustomCheckboxListTile(
      {required this.isChecked, required this.onChanged, this.label});

  @override
  _DeliveryMainCustomCheckboxListTileState createState() =>
      _DeliveryMainCustomCheckboxListTileState();
}

class _DeliveryMainCustomCheckboxListTileState
    extends State<DeliveryMainCustomCheckboxListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DeliveryMainCustomCheckbox(
          isChecked: widget.isChecked,
          onChanged: widget.onChanged,
        ),
        if (widget.label != null)
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Material(
                child: InkResponse(
                  child: InkWell(
                    onTap: () {
                      widget.onChanged?.call(!widget.isChecked);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 9.0,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          widget.label!,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Color.fromRGBO(122, 122, 122, 1),
                            fontFamily: "GT-Eesti-Pro-Display",
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
      ],
    );
  }
}
