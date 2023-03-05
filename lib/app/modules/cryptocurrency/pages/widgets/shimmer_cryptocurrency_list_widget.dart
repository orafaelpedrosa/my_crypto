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
      baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background.withOpacity(0.1),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.background,
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
