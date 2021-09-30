import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<LoadingScreen> {
  final AssetProvider assetProvider =
      AssetFlare(bundle: rootBundle, name: 'assets/flare/logo.flr');

  @override
  void initState() {
    _warmupAnimations(assetProvider).then(
        (value) => Navigator.pushReplacementNamed(context, 'LoginScreen'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
      image: const AssetImage('assets/images/bug.png'),
      fit: BoxFit.fitHeight,
      alignment: Alignment.topCenter,
    )));
  }
}

Future<void> loadSettings() async {
  await Future.delayed(Duration(seconds: 2));
}

Future<void> _warmupAnimations(assetProvider) async {
  await cachedActor(assetProvider);
}
