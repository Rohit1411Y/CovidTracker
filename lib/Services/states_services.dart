import 'dart:convert';

import 'package:covid_tracker/Models/CountryListModel.dart';
import 'package:covid_tracker/Services/Utils/app_Url.dart';
import 'package:http/http.dart' as http;


import '../Models/world_stats_modal.dart';
class StatesServices{
  Future<WorldStatsModal> fetchWorldStatesRecords() async{
    final http.Response response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return WorldStatsModal.fromJson(data);

    }
    else{
      throw Exception(response.statusCode.toString());
    }

  }
  Future<List<dynamic>> FetchCountriesList() async{
    final http.Response response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());

     return data;

    }
    else{
      throw Exception(response.statusCode.toString());
    }

  }
}

