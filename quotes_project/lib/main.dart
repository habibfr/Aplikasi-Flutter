import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: QuotesList(),
    )
  );
}


class QuotesList extends StatefulWidget {
  const QuotesList({Key? key}) : super(key: key);

  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {

  List<String> quotes = [
    'hello my name is habib',
    'belajar flutter di net ninja',
    'sekarang adalah tahun 2023 bulan mei'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes Awasome"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: quotes.map((quote) => Text(quote)).toList(),
      ),
    );
  }
}
