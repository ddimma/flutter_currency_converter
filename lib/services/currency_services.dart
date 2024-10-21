import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:currency_converter/constants/constants.dart';
import 'package:currency_converter/models/Currency.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/utils/api_result.dart';
import 'package:http/http.dart' as http;
import 'package:currency_converter/models/all_currencies_response.dart';

class CurrencyServices {
  Future<ApiResult<List<Currency>>> getCurrencies() async {
    try {
      List<Currency> currencies = [
        // Add your desired currency data here
        Currency(shortName: 'USD', name: 'United States Dollar'),
        Currency(shortName: 'EUR', name: 'Euro'),
        Currency(shortName: 'GBP', name: 'British Pound Sterling'),
        Currency(shortName: 'MDL', name: 'Leu Moldovenesc'),
        // ... add more currencies as needed
      ];
      return ApiResult.success(currencies);
    } on SocketException {
      return ApiResult.failure("No internet connection");
    } on Exception catch (e) {
      return ApiResult.failure("An error occurred $e");
    }
  }

  Future<ApiResult<RatesModel>> getUSDToAnyExchangeRates() async {
  try {
    // Hard-coded response
    final hardCodedRates = RatesModel(
      rates: {
        'EUR': 0.9,
        'GBP': 0.8,
        'USD': 1,
        'MDL': 17,
        // Add more currencies as needed
      },
    );
    return ApiResult.success(hardCodedRates);
  } catch (e) {
    return ApiResult.failure("An error occurred $e");
  }
}
  // Future<ApiResult<RatesModel>> getUSDToAnyExchangeRates() async {
  //   try {
  //     var response = await http.get(Uri.https(baseUrl, "/api/latest.json", {
  //       'prettyprint': 'false',
  //       'show_alternative': 'false',
  //       'show_inactive': 'false',
  //       'app_id': 'a64906f3a2964ab7b471a777a30e07d8'
  //     }));
  //     if (response.statusCode >= 200 && response.statusCode <= 299) {
  //       log(response.body);
  //       return ApiResult.success(
  //           RatesModel.fromJson(jsonDecode(response.body)));
  //     } else {
  //       return ApiResult.failure(
  //           response.reasonPhrase ?? 'Something went wrong');
  //     }
  //   } on SocketException {
  //     return ApiResult.failure("No internet connection");
  //   } on Exception catch (e) {
  //     return ApiResult.failure("An error occurred $e");
  //   }
  // }

  Future<ApiResult<double>> convertUSDToAny(Currency currency) async {
  // Replace the API call with a static conversion based on the hardcoded data
  if (currency.shortName == 'USD') {
    return ApiResult.success(1.0); // Convert USD to USD (1:1)
  } else if (currency.shortName == 'EUR') {
    return ApiResult.success(0.95); // Example conversion rate for EUR
  } else if (currency.shortName == 'GBP') {
    return ApiResult.success(0.85); // Example conversion rate for GBP
  } else if (currency.shortName == 'MDL') {
    return ApiResult.success(20.0); // Example conversion rate for MDL
  } else {
    return ApiResult.failure("Unsupported currency");
  }
}
}
