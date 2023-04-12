import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:requran/app/constants/theme.dart';
import 'package:requran/app/data/models/surah.dart';

import '../../../data/models/detail_surah.dart' as detail;
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${surah.name?.transliteration?.id}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => Get.dialog(
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Get.isDarkMode ? lightPrimary.withOpacity(0.3) : whiteColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Tafsir ${surah.name?.transliteration?.id}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${surah.tafsir?.id ?? 'Surah ini tidak memiliki Tafsir'}",
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              )
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                      colors: [
                        secondaryColor,
                        darkPrimary
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${surah.name?.transliteration?.id}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: whiteColor
                      ),
                    ),
                    SizedBox(height: 5),
                     Text(
                      "( ${surah.name?.translation?.id} )",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: whiteColor
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "${surah.numberOfVerses} ayat | ${surah.revelation?.id}",
                      style: TextStyle(
                        fontSize: 13,
                        color: whiteColor
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          if(!snapshot.hasData){
          return Center(
            child: Text("Tidak Ada Data"),
          );
          }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.verses?.length ?? 0,
                itemBuilder: (context, index) {
                  if(snapshot.data?.verses?.length == 0){
                    return SizedBox();
                  }
                  detail.Verse? ayat = snapshot.data?.verses?[index];
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
                              Container(
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
                                  child: Text("${index+1}"),
                                ),
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
                          "${ayat!.text.arab}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${ayat.text.transliteration?.en}",
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
                }
              );
            }
          ),
        ],
      ),
    );
  }
}
