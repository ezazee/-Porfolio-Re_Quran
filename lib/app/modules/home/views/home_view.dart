import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:requran/app/constants/theme.dart';
import 'package:requran/app/data/models/surah.dart';
import 'package:requran/app/data/models/juz.dart' as juz;
import 'package:requran/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(Get.isDarkMode){
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re - Qur\'an'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed(Routes.SEARCH), 
            icon: Icon(Icons.search)
          ),
        ],
        leading: IconButton(
            onPressed: (){
              Get.isDarkMode ? Get.changeTheme(appLight) : Get.changeTheme(appDark); 
              controller.isDark.toggle();
            }, 
            icon: Icon(Icons.color_lens)
          ),
      ),

      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum Ukhty & Akhy",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 7),
              Text(
                "Selamat dan Semangat Membaca Qur'an",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
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
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: Stack(
                        children: [ 
                          Positioned(
                            bottom: -50,
                            right: 0,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  "assets/image/quran.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.menu_book_rounded, color: whiteColor,),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Terakhir Membaca",
                                      style: TextStyle(
                                        color: whiteColor
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "Al Fatihah",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Juz 1 | Ayat 3",
                                  style: TextStyle(
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                tabs: [
                  Tab(
                    text: "Surah",
                  ),
                  Tab(
                    text: "Juz",
                  ),
                  Tab(
                    text: "Bookmark",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                            },
                            leading: Obx(()=>Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                image: DecorationImage
                                  (image: AssetImage( controller.isDark.isTrue ? "assets/image/octagonal2.png" : "assets/image/octagonal.png"),
                                ),
                              ),
                              child: Center(child: Text("${surah.number}")
                              ),
                            ),
                            ),
                            title: Text("${surah.name?.transliteration?.id}"),
                            subtitle: Text("${surah.numberOfVerses} ayat || ${surah.revelation?.id}", style: TextStyle( color: Colors.grey[500] ),),
                            trailing: Text("${surah.name?.short}"),
                            );
                          },
                        );
                      }
                    ),
                  FutureBuilder<List<juz.Juz>>(
                    future: controller.getAllJuz(),
                    builder: (context, snapshot){
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      juz.Juz detailJuz = snapshot.data![index];

                      String nameStart = detailJuz.juzStartInfo?.split(" - ").first ?? "";
                      String nameEnd = detailJuz.juzEndInfo?.split(" - ").first ?? "";

                      List<Surah> rawAllSurahInJuz = [];
                      List<Surah> allSurahInJuz = [];

                      for (Surah item in controller.allSurah) {
                        rawAllSurahInJuz.add(item);
                        if (item.name!.transliteration!.id == nameEnd) {
                          break;
                        }
                      }

                      for (Surah item in rawAllSurahInJuz.reversed.toList()) {
                        allSurahInJuz.add(item);
                        if (item.name!.transliteration!.id == nameStart) {
                          break;
                        }
                      }

                      return ListTile(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                "juz": detailJuz,
                                "surah": allSurahInJuz.reversed.toList(),
                              });
                            },
                            leading: Obx(()=>Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                image: DecorationImage
                                  (image: AssetImage( controller.isDark.isTrue ? "assets/image/octagonal.png" : "assets/image/octagonal.png"),
                                ),
                              ),
                              child: Center(child: Text("${index+1}")
                              ),
                            ),
                            ),
                            title: Text("Juz ${index+1}"),
                            isThreeLine: true,
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mulai dari ${detailJuz.juzStartInfo}", style: TextStyle(color: Colors.grey[500]),),
                                Text("Sampai ${detailJuz.juzEndInfo}", style: TextStyle(color: Colors.grey[500]),),
                              ],
                            ),
                            );
                    },
                  );
                    },
                  ),
                  Text("data"),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
