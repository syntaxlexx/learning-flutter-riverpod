import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final int rows;
  const Loading({Key? key, this.rows = 1}) : super(key: key);
  final bool isDarkMode = false;
  final double height = 60 + 16 + 20; // 60=round, 16=separator, 20=margin-b0ttom

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: height * rows,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (_, i) {
          final delay = (i * 300);
          return Row(
            children: [
              FadeShimmer.round(
                size: 60,
                fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
                millisecondsDelay: delay,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeShimmer(
                    height: 8,
                    width: size.width * 0.7 - 60 - 20,
                    radius: 4,
                    millisecondsDelay: delay,
                    fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  FadeShimmer(
                    height: 8,
                    millisecondsDelay: delay,
                    width: 170,
                    radius: 4,
                    fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
                  ),
                ],
              )
            ],
          );
        },
        itemCount: rows,
        separatorBuilder: (_, __) => const SizedBox(
          height: 16,
        ),
      ),
    );
  }
}
