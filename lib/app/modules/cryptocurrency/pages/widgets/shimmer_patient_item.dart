import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPatientItem extends StatefulWidget {
  const ShimmerPatientItem({Key? key}) : super(key: key);

  @override
  State<ShimmerPatientItem> createState() => _ShimmerPatientItemState();
}

class _ShimmerPatientItemState extends State<ShimmerPatientItem> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        child: ListTile(
          leading: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            height: 60,
            width: 60,
          ),
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 15,
            width: double.infinity,
          ),
          subtitle: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 15,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
