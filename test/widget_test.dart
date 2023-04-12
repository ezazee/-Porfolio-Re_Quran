import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:requran/app/data/models/detail_surah.dart';
import 'package:requran/app/data/models/surah.dart';

void main() async {
  // Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  // var res = await http.get(url);

  // List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

  // // print(data[113]);

  // // data dari api (raw data) -> model ( yang sudah disiapkan )
  // Surah surahAnnas = Surah.fromJson(data[113]);

  // // print(surahAnnas.toJson());

  //  Uri urlAnnas = Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  // var resAnnas = await http.get(urlAnnas);

  //  Map<String, dynamic> dataAnnas = (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];

  // // data dari api (raw data) -> model ( yang sudah disiapkan )
  // DetailSurah annas = DetailSurah.fromJson(dataAnnas);

  // print(annas.verses[0].text.arab);
}