import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/amiibo.dart';
import '../shared/favorite_data.dart'; // Import daftar favorit global
import 'detail_screen.dart';
import 'favorite_screen.dart'; // Import FavoriteScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Index untuk navigasi antar tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Nintendo Amiibo' : 'Favorites',
        ),
        centerTitle: true, // Menempatkan teks di tengah
      ),
      body: _currentIndex == 0
          ? AmiiboListScreen(
              onFavoritesUpdated: _updateFavorites, // Kirim callback
            )
          : FavoriteScreen(
              onFavoritesUpdated: _updateFavorites, // Kirim callback
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Ganti tab saat ditekan
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }

  void _updateFavorites() {
    setState(() {
      // Memperbarui tampilan setelah daftar favorit berubah
    });
  }
}

class AmiiboListScreen extends StatefulWidget {
  final VoidCallback onFavoritesUpdated; // Callback untuk pembaruan favorit

  const AmiiboListScreen({Key? key, required this.onFavoritesUpdated})
      : super(key: key);

  @override
  State<AmiiboListScreen> createState() => _AmiiboListScreenState();
}

class _AmiiboListScreenState extends State<AmiiboListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Amiibo>>(
      future: ApiService.getAmiiboList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        final amiiboList = snapshot.data!;
        return ListView.builder(
          itemCount: amiiboList.length,
          itemBuilder: (context, index) {
            final amiibo = amiiboList[index];
            final isFavorite = favoriteList.contains(amiibo);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation:
                  4, // Controls the shadow depth (higher = more pronounced shadow)
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(12), // Add padding inside the tile
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
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? Colors.red
                        : null, // Change color when favorited
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        favoriteList.remove(amiibo);
                      } else {
                        favoriteList.add(amiibo);
                      }
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isFavorite
                              ? 'Removed from favorites'
                              : 'Added to favorites',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    widget.onFavoritesUpdated(); // Call callback
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
        );
      },
    );
  }
}
