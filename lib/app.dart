import 'package:charge_ev/UI/Pages/home_page.dart';
import 'package:charge_ev/providers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AppController>(context, listen: false).initialise(),
      builder: (context, snapshot) => const HomePage(),
    );
  }
}
