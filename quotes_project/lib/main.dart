import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

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
    Quote(text: "nonton anime adalah yang terbaik", author: "Nakano")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes Awasome"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            quotes.add(Quote(text: "nonton anime adalah yang terbaik", author: "Nakano"));
            quotes.add(Quote(text: "belajar flutter di net ninja", author: "habib"));
          });
        },
        child: Icon(
          Icons.add
        ),
      ),
      body: Column(
        children: quotes.map((quote) => QuoteCard(
          quote: quote,
          delete: (){
            setState(() {
              quotes.remove(quote);
            });
          },
        )).toList(),
      ),
    );
  }
}

