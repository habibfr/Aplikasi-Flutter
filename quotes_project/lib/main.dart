import 'package:flutter/material.dart';
import 'quote.dart';

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

  List<Quote> quotes = [
    Quote(text: "belajar flutter di net ninja", author: "habib"),
    Quote(text: "sekarang tahun 2023 bulan mei", author: "nino"),
    Quote(text: "nonton anime adalah yang terbaik", author: "nakano")
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
        children: quotes.map((quote) => Text('${quote.text} - ${quote.author}')).toList(),
      ),
    );
  }
}
