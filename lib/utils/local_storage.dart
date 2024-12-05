import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Menyimpan daftar favorit
  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('favorite_list', favorites.join(','));
  }

  // Mengambil daftar favorit
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    String? favorites = prefs.getString('favorite_list');
    return favorites != null ? favorites.split(',') : [];
  }

  // Menghapus daftar favorit
  static Future<void> removeFavorite(String item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = await getFavorites();
    favorites.remove(item);
    prefs.setString('favorite_list', favorites.join(','));
  }

  // Menambahkan favorit
  static Future<void> addFavorite(String item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = await getFavorites();
    favorites.add(item);
    prefs.setString('favorite_list', favorites.join(','));
  }
}
