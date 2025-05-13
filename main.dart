import 'package:flutter/material.dart'; import 'screens/home_screen.dart';

void main() { runApp(PawnShopApp()); }

class PawnShopApp extends StatelessWidget { @override Widget build(BuildContext context) { return MaterialApp( title: 'Ranjith Pawn Shop', debugShowCheckedModeBanner: false, theme: ThemeData( primarySwatch: Colors.amber, scaffoldBackgroundColor: Colors.grey[100], ), home: HomeScreen(), ); } }
