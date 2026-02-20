import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'flavors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = Flavor.prod;

  runApp(ProviderScope(child: const App()));
}
