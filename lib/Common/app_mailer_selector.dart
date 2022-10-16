import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

class AppMailerSelector {
  static Future<void> open(BuildContext context) async {
    // Android: Will open mail app or show native picker.
    // iOS: Will open mail app if single mail app found.
    var result = await OpenMailApp.openMailApp(nativePickerTitle: 'Séléctionnez une application email');

    // If no mail apps found, show error
    if (!result.didOpen && !result.canOpen) {
      showNoMailAppsDialog(context);

      // iOS: if multiple mail apps found, show dialog to select.
      // There is no native intent/default app system in iOS so
      // you have to do it yourself.
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            title: 'Choisissez l\'application email à ouvrir',
            mailApps: result.options,
          );
        },
      );
    }
  }

  static void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ouverture de l'application Email",
              textAlign: TextAlign.center),
          content: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: SizedBox(
              height: 230,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Nous n'avons détecter aucune application Email installée sur votre équippement. \n\n" +
                      "Veuillez installer une application email: Gmail, Outlook, Yahoo,...etc.\n\n" +
                      " Vous pouvez aussi utiliser votre navigateur pour accéder à votre boite email.",
                  style: TextStyle(color: Colors.grey.shade900),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
