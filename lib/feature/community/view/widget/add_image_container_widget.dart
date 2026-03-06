import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddPhotoContainer extends StatelessWidget {
  const AddPhotoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RectDottedBorderOptions(),
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
