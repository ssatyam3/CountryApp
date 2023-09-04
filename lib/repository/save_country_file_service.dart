//@dart=2.9
import 'dart:io';

import 'package:country/models/country/country.dart';
import 'package:country/models/failures/download_failure.dart';
import 'package:country/providers/downloaded_files_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveFileService {
  Future<Either<DownloadFailure, Unit>> saveFile(
      {@required Country country, BuildContext context}) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
      String tempPath = tempDir.path;
      if (await File('$tempPath/${country.name}.txt').exists()) {
        return left(DownloadFailure('File already exists'));
      } else {
        final file = await File('$tempPath/${country.name}.txt').create();
        file.writeAsString(str(country));
        context.read(downloadedFilesProvider).addFile(country.name);
      }
      return right(unit);
    } catch (e) {
      print(e);
      return left(DownloadFailure(e.toString()));
    }
  }

  Future<void> delete(String name, BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
    String tempPath = tempDir.path;
    final file = File('$tempPath/$name.txt');
    await file.delete();
    context.read(downloadedFilesProvider).delete(name);
  }
}

String str(Country c) {
  return 'Country: ${c.name}\nCapital: ${c.capital}\nRegion: ${c.region}\nSub-region: ${c.subregion}\nLatitude: ${c.latlng[0]}\nLongitude: ${c.latlng[1]}\nPopulation: ${c.population}\nArea: ${c.area}\nCountry codes: ${c.cca2 + '/' + c.cca3}\nCalling codes: ${c.callingCodes.join('/')}\nBorder countries: ${c.borders.join('/')}\nTime-zones: ${c.timezones.join(' / ')}\nCurrencies: ${List.from(c.currencies.map((e) => e['symbol'] + ' ' + e['name'])).join(' / ')}';
}
