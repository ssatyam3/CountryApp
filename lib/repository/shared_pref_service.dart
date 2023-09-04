import 'dart:convert';

import 'package:country/models/country/country.dart';
import 'package:country/providers/bookmark_provider.dart';
import 'package:country/providers/downloaded_files_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedPrefService {
  Future<void> getBookmarks(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getString('bookmarks') ?? '[]';
    final List<Map<String, dynamic>> list = List.from(jsonDecode(bookmarks));
    final countries = list.map((e) => Country.fromJson(e)).toList();
    context.read(bookMarkProvider).getBookmarksfromDevice(countries);
  }

  Future<void> saveBookmarks(List<Country> value) async {
    final stringList = value.map((e) => e.toJson(e)).toList();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('bookmarks', jsonEncode(stringList));
  }

  Future<void> getDownloads(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final downloads = prefs.getStringList('downloads') ?? [];
    context.read(downloadedFilesProvider).getDownloads(downloads);
  }

  Future<void> saveDownloads(List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('downloads', value);
  }
}
