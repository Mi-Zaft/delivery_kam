import 'package:delivery_kam/features/main/widgets/delivery_main_custom_checkbox.dart';
import 'package:flutter/material.dart';

class DeliveryMainCustomCheckboxListTile extends StatefulWidget {
  final bool isChecked;
  final Function(bool) onChanged;
  final String? label;

  final double columnHorizontalPadding = 24.0; // Отступы по бокам

  const DeliveryMainCustomCheckboxListTile(
      {super.key, required this.isChecked, required this.onChanged, this.label});

  @override
  DeliveryMainCustomCheckboxListTileState createState() =>
      DeliveryMainCustomCheckboxListTileState();
}

class DeliveryMainCustomCheckboxListTileState
    extends State<DeliveryMainCustomCheckboxListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.columnHorizontalPadding),
      child: Row(
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
                        widget.onChanged.call(!widget.isChecked);
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
      ),
    );
  }
}
