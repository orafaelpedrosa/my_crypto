import 'package:flutter/material.dart';

class NoFavoritesWidget extends StatelessWidget {
  const NoFavoritesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(30),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Icon(
              Icons.star_rate_rounded,
              size: 100,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Nenhuma favorita!',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 15),
          Text(
            'Adicione uma criptomoeda a sua lista de favoritas clicando no botão de estrela na tela de detalhes.',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).cardColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
