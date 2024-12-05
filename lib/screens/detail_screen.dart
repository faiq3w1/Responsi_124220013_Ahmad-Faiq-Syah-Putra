import 'package:flutter/material.dart';
import '../models/amiibo.dart';
import '../shared/favorite_data.dart';

class DetailScreen extends StatefulWidget {
  final Amiibo amiibo;

  const DetailScreen({Key? key, required this.amiibo}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteList.contains(widget.amiibo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amiibo Details"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  favoriteList.remove(widget.amiibo);
                } else {
                  favoriteList.add(widget.amiibo);
                }
                isFavorite = !isFavorite;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite
                        ? 'Added to favorites'
                        : 'Removed from favorites',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image Section
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.amiibo.imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title Section
              Text(
                widget.amiibo.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Details Section wrapped in a Card
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Game Series and Amiibo Series
                      _buildKeyValueRow(
                          'Amiibo Series:', widget.amiibo.amiiboSeries),
                      _buildKeyValueRow('Character:', widget.amiibo.character),
                      _buildKeyValueRow(
                          'Game Series:', widget.amiibo.gameSeries),
                      _buildKeyValueRow('Type:', widget.amiibo.type),
                      _buildKeyValueRow('Head:', widget.amiibo.head),
                      _buildKeyValueRow('Tail:', widget.amiibo.tail),
                      const SizedBox(height: 16),

                      // Release Dates Section
                      const Text(
                        'Release Dates',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Divider(),
                      _buildKeyValueRow(
                          'Australia:', widget.amiibo.releaseDates['au']),
                      _buildKeyValueRow(
                          'Europe:', widget.amiibo.releaseDates['eu']),
                      _buildKeyValueRow(
                          'Japan:', widget.amiibo.releaseDates['jp']),
                      _buildKeyValueRow(
                          'North America:', widget.amiibo.releaseDates['na']),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              key,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? 'N/A',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
