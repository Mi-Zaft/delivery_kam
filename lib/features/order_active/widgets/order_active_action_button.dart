import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class OrderActiveActionButton extends StatelessWidget {
  String imagePath;
  String label;
  bool? isSkeletonizer;
  bool isEnable;
  Function()? onTap;
  OrderActiveActionButton(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.isEnable,
      this.onTap,
      this.isSkeletonizer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 105,
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 14)
            // .copyWith(top: 15)
            .copyWith(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromRGBO(195, 195, 195, 1),
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Skeletonizer(
                enabled: isSkeletonizer ?? false,
                child: Text(
                  label,
                )),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            if (isEnable == false)
              ColorFiltered(
                colorFilter: const ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0, // Red
                  0.2126, 0.7152, 0.0722, 0, 0, // Green
                  0.2126, 0.7152, 0.0722, 0, 0, // Blue
                  0, 0, 0, 1, 0, // Alpha
                ]),
                child: Image.asset(
                  imagePath,
                  height: 50,
                ),
              ),
            if (isEnable == true)
              Image.asset(
                imagePath,
                height: 45,
              ),
          ],
        ),
      ),
    );
  }
}
