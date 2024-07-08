import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String description;

  ExpandableCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.network(widget.imageUrl),
            title: Text(widget.name),
            subtitle: Text(widget.price),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Column(
              children: <Widget>[
                Image.network(widget.imageUrl),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.price,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.description),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
