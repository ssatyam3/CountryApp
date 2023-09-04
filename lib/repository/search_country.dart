//@dart=2.9

import 'dart:developer';

import 'package:country/constant/api_urls.dart';
import 'package:country/constant/langToCode.dart';
import 'package:country/models/country/country.dart';
import 'package:country/models/failures/search_failure.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SearchService {
  final _dio = Dio();
  //get countries by name
  Future<Either<SearchFailure, List<Country>>> getCountriesByName(
      {@required String name}) async {
    try {
      final response = await _dio.get(
        searchByNameUrl + '$name',
      );
      final List<Map<String, dynamic>> data = List.from(response.data);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      return right(countries);
    } on DioError catch (e) {
      print(e);
      return left(SearchFailure('Something went wrong'));
    }
  }

  //get countries by code
  Future<Either<SearchFailure, List<Country>>> getCountriesByCode(
      {@required String code}) async {
    try {
      final response = await _dio.get(
        searchByCodeUrl + '$code',
      );
      final List<Map<String, dynamic>> data = List.from([response.data]);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      return right(countries);
    } on DioError catch (e) {
      print(e);
      return left(SearchFailure('Something went wrong'));
    }
  }

  //get countries by currency
  // Future<Either<SearchFailure, List<Country>>> getCountriesByCurrency(
  //     {@required String currency}) async {
  //   print(searchByCurrencyUrl + '$currency');
  //   try {
  //     final response = await _dio.get(
  //       searchByCurrencyUrl + '$currency',
  //     );
  //     final List<Map<String, dynamic>> data = List.from(response.data);
  //     final countries = data.map((e) => Country.fromJson(e)).toList();
  //     return right(countries);
  //   } on DioError catch (e) {
  //     print(e);
  //     return left(SearchFailure('Something went wrong'));
  //   }
  // }

  //get country by language
  Future<Either<SearchFailure, List<Country>>> getCountriesByLanguage(
      {@required String lang}) async {
    lang.toLowerCase();
    final code = isoLangs.entries
        .firstWhere((element) => element.value.toLowerCase() == lang);
    try {
      final response = await _dio.get(
        searchByLanguageUrl + '${code.key}',
      );
      final List<Map<String, dynamic>> data = List.from(response.data);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      return right(countries);
    } on DioError catch (e) {
      print(e);
      return left(SearchFailure('Something went wrong'));
    }
  }

  //get country by region
  Future<Either<SearchFailure, List<Country>>> getCountriesByRegion(
      {@required String region}) async {
    try {
      final response = await _dio.get(
        searchByRegionUrl + '$region',
      );
      log(response.statusMessage);
      final List<Map<String, dynamic>> data = List.from(response.data);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      return right(countries);
    } on DioError catch (e) {
      print(e);
      return left(SearchFailure('Something went wrong'));
    }
  }

  //get country by capital
  Future<Either<SearchFailure, List<Country>>> getCountriesByCapital(
      {@required String capital}) async {
    try {
      final response = await _dio.get(
        searchByCapitalUrl + '$capital',
      );
      final List<Map<String, dynamic>> data = List.from(response.data);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      return right(countries);
    } on DioError catch (e) {
      print(e);
      return left(SearchFailure('Something went wrong'));
    }
  }
}
