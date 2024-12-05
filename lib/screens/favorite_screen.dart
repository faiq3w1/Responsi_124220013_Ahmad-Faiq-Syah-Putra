import 'package:flutter/material.dart';
import '../shared/favorite_data.dart'; // Import daftar favorit global
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final VoidCallback onFavoritesUpdated;

  const FavoriteScreen({Key? key, required this.onFavoritesUpdated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoriteList.isEmpty
          ? const Center(
              child: Text('No favorites yet.'),
            )
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final amiibo = favoriteList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4, // Adds a shadow effect to the card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8), // Rounded corners for image
                      child: Image.network(
                        amiibo.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      amiibo.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      amiibo.gameSeries,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        favoriteList.remove(amiibo); // Remove from favorites
                        onFavoritesUpdated(); // Trigger UI update

                        // Show a SnackBar to indicate the item was removed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${amiibo.name} removed from favorites'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(amiibo: amiibo),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
