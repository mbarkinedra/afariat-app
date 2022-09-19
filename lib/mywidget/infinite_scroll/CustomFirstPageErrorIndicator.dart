import 'package:flutter/cupertino.dart';
import 'CustomFirstPageExceptionIndicator.dart';

class CustomFirstPageErrorIndicator extends StatelessWidget {
  const CustomFirstPageErrorIndicator({
    this.onTryAgain,
    Key key,
  }) : super(key: key);

  final VoidCallback onTryAgain;

  Widget build(BuildContext context) => CustomFirstPageExceptionIndicator(
        title: 'Hum... Un problème inattendu',
        message: 'Il y a quelque chose qui ne marche pas comme prévu.\n'
            'Essayer de relancer l\'application ou de revenir un peu plus tard.',
        onTryAgain: onTryAgain,
      );
}
