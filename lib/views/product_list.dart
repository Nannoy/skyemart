import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductList extends StatefulWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Use a Map to track the expanded state of each item
  final Map<int, bool> _expandedStates = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];
        final isExpanded = _expandedStates[index] ?? false;

        return Card(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: product.imageUrl != null
                    ? Image.network(
                  'https://api.timbu.cloud/images/${product.imageUrl}',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                )
                    : null,
                title: Text(
                    product.name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Uploaded: ${product.dateCreated}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    if (product.price != null)
                      Text(
                          'Price: \$${product.price.toString()}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: () {
                    setState(() {
                      _expandedStates[index] = !isExpanded;
                    });
                  },
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (product.imageUrl != null)
                        Image.network(
                          'https://api.timbu.cloud/images/${product.imageUrl}',
                          fit: BoxFit.contain,
                        ),
                      SizedBox(height: 8.0),
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Price: \$${product.price.toString()}',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'
                        ),
                      ),
                      SizedBox(height: 8.0),
                      if (product.description != null)
                        Text(
                          product.description!,
                          style: TextStyle(
                              fontSize: 14,
                            fontFamily: 'Poppins'
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
