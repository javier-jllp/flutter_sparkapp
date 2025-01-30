import 'package:flutter/material.dart';

class ListVideoScreen extends StatefulWidget {
  const ListVideoScreen({Key? key}) : super(key: key);

  @override
  State<ListVideoScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends State<ListVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ListVideoScreen'),
    );
  }
}
