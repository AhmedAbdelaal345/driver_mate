import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddPhotoContainer extends StatelessWidget {
  const AddPhotoContainer({super.key, required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RectDottedBorderOptions(
        color: isSelected ? Colors.blue : Colors.grey,
        strokeWidth: 2,
        dashPattern: const [6, 4],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.image_outlined, color: Colors.blueGrey),
            SizedBox(width: 8),
            Text(
              "Add Photo",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
