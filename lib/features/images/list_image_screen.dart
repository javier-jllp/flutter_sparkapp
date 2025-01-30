import 'package:flutter/material.dart';

class ListImageScreen extends StatefulWidget {
  const ListImageScreen({Key? key}) : super(key: key);

  @override
  State<ListImageScreen> createState() => _ListImageScreenState();
}

class _ListImageScreenState extends State<ListImageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ListImageScreen'),
    );
  }
}
