        // child: ListTile(
        //   onTap: onTap,
        //   leading: ClipOval(
        //     child: SizedBox.fromSize(
        //       size: Size(40, 40),
        //       child: Image.network(
        //         coin.image!,
        //         fit: BoxFit.cover,
        //         loadingBuilder: (context, child, loadingProgress) {
        //           if (loadingProgress == null) {
        //             return child;
        //           } else {
        //             return Center(
        //               child: CircularProgressIndicator(),
        //             );
        //           }
        //         },
        //       ),
        //     ),
        //   ),
        //   title: Text(
        //     coin.name!,
        //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        //           color: Theme.of(context).colorScheme.secondary,
        //           fontWeight: FontWeight.bold,
        //         ),
        //   ),
        //   subtitle: Row(
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.only(left: 5, right: 5),
        //         decoration: BoxDecoration(
        //           color:
        //               Theme.of(context).colorScheme.secondary.withOpacity(0.05),
        //           borderRadius: BorderRadius.circular(5),
        //         ),
        //         child: Center(
        //           child: Text(
        //             coin.marketCapRank.toString(),
        //             style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        //                   color: Theme.of(context).colorScheme.secondary,
        //                 ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 5),
        //       Text(
        //         coin.symbol!.toUpperCase(),
        //         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        //               color: Theme.of(context).colorScheme.tertiary,
        //             ),
        //       ),
        //     ],
        //   ),
        //   trailing: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //           Text(
        //             Utils.formatNumber(coin.currentPrice!.toDouble()),
        //             style: Theme.of(context).textTheme.displaySmall!.copyWith(
        //                   color: Theme.of(context).colorScheme.secondary,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //           ),
        //           Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               coin.priceChangePercentage24h.toString().contains('-')
        //                   ? Icon(
        //                       Icons.arrow_downward_outlined,
        //                       color: Colors.red,
        //                       size: 15,
        //                     )
        //                   : Icon(
        //                       Icons.arrow_upward_outlined,
        //                       color: Colors.green,
        //                       size: 15,
        //                     ),
        //               SizedBox(width: 5),
        //               Text(
        //                 coin.priceChangePercentage24h.toString().contains('-')
        //                     ? '${coin.priceChangePercentage24h!.toStringAsFixed(2)}%'
        //                     : '+' +
        //                         '${coin.priceChangePercentage24h!.toStringAsFixed(2)}%',
        //                 style:
        //                     Theme.of(context).textTheme.headlineSmall!.copyWith(
        //                           color: coin.priceChangePercentage24h
        //                                   .toString()
        //                                   .contains('-')
        //                               ? Colors.red
        //                               : Colors.green,
        //                         ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),