import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
                color: Theme.of(context).primaryTextTheme.headline6?.color),
            SizedBox(
              height: (10),
            ),
            Text(
              "Carregando...",
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline6?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
