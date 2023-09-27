import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/search_bar_coin_widget.dart';
import 'package:mycrypto/app/shared/widgets/button/button_primary_widget.dart';

class EmptyWalletWidget extends StatefulWidget {
  const EmptyWalletWidget({Key? key}) : super(key: key);

  @override
  State<EmptyWalletWidget> createState() => _EmptyWalletWidgetState();
}

class _EmptyWalletWidgetState extends State<EmptyWalletWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/app/wallet/image.svg',
            height: 150,
            colorFilter: ColorFilter.mode(
              Colors.red,
              BlendMode.srcIn,
            ),

            // placeholderBuilder: (context) => Container(
            //   height: 50,
            //   width: 50,
            //   child: const CircularProgressIndicator(),
            // ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sua carteira está vazia!',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Adicione criptomoedas para acompanhar seus investimentos.',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ButtonPrimaryWidget(
            text: 'Adicionar criptomoeda',
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarCoinWidget(),
              );
            },
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
