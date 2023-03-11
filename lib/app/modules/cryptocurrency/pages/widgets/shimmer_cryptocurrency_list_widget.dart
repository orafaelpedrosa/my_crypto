import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCryptocurrencyListWidget extends StatefulWidget {
  const ShimmerCryptocurrencyListWidget({Key? key}) : super(key: key);

  @override
  State<ShimmerCryptocurrencyListWidget> createState() =>
      _ShimmerCryptocurrencyListWidgetState();
}

class _ShimmerCryptocurrencyListWidgetState
    extends State<ShimmerCryptocurrencyListWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.25),
      highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Container(
        margin:
            const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                height: 60,
                width: 60,
              ),
              title: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    height: 17.5,
                    width: 50,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    height: 17.5,
                    width: 80,
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      height: 17.5,
                      width: 17.5,
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      height: 17.5,
                      width: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
