import 'package:flutter/material.dart';

class SettingFields extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final String? title;

  const SettingFields({
    super.key,
    this.onTap,
    this.icon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: () {
          onTap!.call();
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                icon,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
