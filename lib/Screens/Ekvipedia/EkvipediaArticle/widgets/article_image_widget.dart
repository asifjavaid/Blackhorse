import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  final String? imageURL;
  final String? description;
  const ArticleImage({super.key, this.imageURL, this.description});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: imageURL != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    "https:${imageURL!}",
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description ?? "",
          style: textTheme.labelMedium,
        )
      ],
    );
  }
}
