import 'package:flutter/material.dart';
import 'presentation/seat_selection_grid.dart'; // Update the import path based on your project structure

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SeatSelectionGrid(),
      ),
    );
  }
}
