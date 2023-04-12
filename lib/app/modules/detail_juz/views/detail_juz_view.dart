import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:requran/app/constants/theme.dart';
import 'package:requran/app/data/models/juz.dart' as juz;
import 'package:requran/app/data/models/surah.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahInThisjuz = Get.arguments["surah"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${detailJuz.juz}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: detailJuz.verses?.length ?? 0,
        itemBuilder: (context, index) {
          if (detailJuz.verses == null  || detailJuz.verses?.length == 0) {
            return Center(
              child: Text("tidak ada data"),
            );
          }
          juz.Verses ayat = detailJuz.verses![index];
          if (index != 0) {  
            if (ayat.number?.inSurah == 1) {
              controller.index++;
            }
          }
          return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightPrimary.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                            ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          Get.isDarkMode ? "assets/image/octagonal2.png" : "assets/image/octagonal.png"
                                        )
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("${ayat.number?.inSurah}"),
                                    ),
                                  ),
                                  Text(
                                    "${allSurahInThisjuz[controller.index].name?.transliteration?.id}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_add_outlined),),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "${ayat.text?.arab}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${ayat.text?.transliteration?.en}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 27),
                      Text(
                        "${ayat.translation?.id}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  );
        },
      )
    );
  }
}
