import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback delete;
  const QuoteCard({
    required this.quote,
    required this.delete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quote.text,
              style: TextStyle(
                  fontSize: 18.0
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              quote.author,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 6.0,),
            TextButton.icon(
              onPressed: delete,
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              label: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}