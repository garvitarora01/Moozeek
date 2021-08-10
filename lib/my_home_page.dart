import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicapp/AppTabs.dart';
import 'package:musicapp/Audio_Page.dart';
import 'app_colors.dart' as AppColors;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool like = false;
  List songs = [];
  List newly = [];
  List bollywood = [];
  List hollywood = [];
  late ScrollController _scrollController;
  late TabController _tabController;
  // ignore: non_constant_identifier_names
  void ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/songs.json")
        .then((s) {
      setState(() {
        songs = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/newly_added.json")
        .then((s) {
      setState(() {
        newly = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/bollywood.json")
        .then((s) {
      setState(() {
        bollywood = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/hollywood.json")
        .then((s) {
      setState(() {
        hollywood = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      size: MediaQuery.of(context).size.width * 0.075,
                      color: Color(0xFFF3EFF5),
                    ),
                    Row(
                      children: [
                        Icon(Icons.search,
                            size: MediaQuery.of(context).size.width * 0.075,
                            color: Color(0xFFF3EFF5)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.005,
                        ),
                        Icon(
                          Icons.notifications,
                          size: MediaQuery.of(context).size.width * 0.075,
                          color: Color(0xFFF3EFF5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.01,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.02),
                    child: Text(
                      'Songs for You',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        color: Color(0xFFF3EFF5),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: songs.length,
                            itemBuilder: (_, i) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                height: MediaQuery.of(context).size.width * 0.4,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02,
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.04),
                                  image: DecorationImage(
                                    image: AssetImage(songs[i]["images"]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        toolbarHeight:
                            MediaQuery.of(context).size.height * 0.02,
                        pinned: true,
                        backgroundColor: Colors.black, //Color(0xFF474A48),
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height * 0.09),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: TabBar(
                                indicatorPadding: const EdgeInsets.all(0),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding: const EdgeInsets.only(right: 10),
                                controller: _tabController,
                                isScrollable: true,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        blurRadius: 7,
                                        offset: Offset(-5, 0),
                                      )
                                    ]),
                                tabs: [
                                  AppTabs(Color(0xFF7A8450), "Newly Added"),
                                  AppTabs(Color(0xFF66B3BA), "Hollywood"),
                                  AppTabs(Color(0xFF8EB19D), "Bollywood"),
                                ]),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: newly.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AudioPage(
                                            audioData: newly, index: i)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 0,
                                    bottom: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF909590),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  newly[i]["images"]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    size: 22,
                                                    color: AppColors.starColor),
                                                Text(
                                                  newly[i]["rating"],
                                                  style: TextStyle(
                                                      color: Color(0xFFF7F9F9),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(newly[i]["title"],
                                                    style: GoogleFonts.openSans(
                                                        color:
                                                            Color(0xFFF3EFF5),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(
                                                  newly[i]["text"],
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .subtitleText,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: hollywood.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AudioPage(
                                            audioData: hollywood, index: i)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 0,
                                    bottom: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF909590),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  hollywood[i]["images"]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    size: 22,
                                                    color: AppColors.starColor),
                                                Text(
                                                  hollywood[i]["rating"],
                                                  style: TextStyle(
                                                      color: Color(0xFFF7F9F9),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(hollywood[i]["title"],
                                                    style: GoogleFonts.openSans(
                                                        color:
                                                            Color(0xFFF3EFF5),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(
                                                  hollywood[i]["text"],
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .subtitleText,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: bollywood.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AudioPage(
                                            audioData: bollywood, index: i)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    right: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 0,
                                    bottom: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF909590),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  bollywood[i]["images"]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    size: 22,
                                                    color: AppColors.starColor),
                                                Text(
                                                  bollywood[i]["rating"],
                                                  style: TextStyle(
                                                      color: Color(0xFFF7F9F9),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(bollywood[i]["title"],
                                                    style: GoogleFonts.openSans(
                                                        color:
                                                            Color(0xFFF3EFF5),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(
                                                  bollywood[i]["text"],
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .subtitleText,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
