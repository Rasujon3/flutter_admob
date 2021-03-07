import 'package:flutter/material.dart';
import 'package:flutter_admob/admob_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> allRows;
  List<Object> itemList;

  @override
  void initState() {
    super.initState();
    allRows = [];

    for (int i = 1; i <= 20; i++) {
      allRows.add("Row $i");
    }
    itemList = List.from(allRows);
    for (int i = itemList.length - 5; i >= 1; i -= 5) {
      itemList.insert(i, AdMobService.createBannerAd()..load());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Admob'),
        elevation: 0,
      ),
      // bottomNavigationBar: Container(
      //   height: 50.0,
      //   child: AdWidget(
      //     key: UniqueKey(),
      //     ad: AdMobService.createBannerAd()..load(),
      //   ),
      // ),
      backgroundColor: Colors.grey,
      body: ListView.builder(
        addAutomaticKeepAlives: true,
        itemBuilder: (context, i) {
          if (itemList[i] is String) {
            return new ListTile(
              title: Text(itemList[i].toString()),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  AdMobService.showInterstitialAd();
                },
              ),
            );
          } else {
            final Container adContainer = Container(
              alignment: Alignment.center,
              child: AdWidget(key: UniqueKey(), ad: itemList[i] as BannerAd),
              height: 50,
            );
            return adContainer;
          }
        },
        itemCount: itemList.length,
      ),
    );
  }
}
