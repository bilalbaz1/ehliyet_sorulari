import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'islem.dart';

void main() => runApp(ehliyet());

class ehliyet extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // tasarimini degistirmek icin paket onerim https://pub.dev/packages/smooth_page_indicator
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text('Ehliyet Soruları 2020'),
          ),
          backgroundColor: Colors.black54,
        ),
        body: EhliyetSayfasi(),
      ),
    );
  }
}

class Sorular {
  int soruNo;
  String cevap;
  Sorular({this.cevap, this.soruNo});
}

class EhliyetSayfasi extends StatefulWidget {
  @override
  _EhliyetSayfasiState createState() => _EhliyetSayfasiState();
}

class _EhliyetSayfasiState extends State<EhliyetSayfasi> {
  List<int> cevaplananSorular = List();

  String dogruYanit;
  String yanlisYanit;
  int soruCevaplandi;
  bool cevaplandi;

  int puan = 0;

  @override
  Widget build(BuildContext context) {
    return PageIndicatorContainer(
      length: sorulistesi.length,
      align: IndicatorAlign.top,
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      indicatorColor: Colors.indigo,
      indicatorSelectorColor: Colors.greenAccent,
      child: PageView.builder(
        itemCount: sorulistesi.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 60),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "resim/soru${sorulistesi[index].soruNo}.jpg",
                  fit: BoxFit.cover,
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                        child: RaisedButton(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: soruCevaplandi ==
                                      sorulistesi[index]
                                          .soruNo //cevaplanan soru ile for dongusunde donen soru ayni ise 1. if e girer
                                  ? dogruYanit ==
                                          "A" // 1. if de dogruYanit hangi şık ise yeşil olacak, yani dogrusu A mı diye baktik
                                      ? Colors.green // A ise Yesil
                                      : yanlisYanit ==
                                              "A" // dogru yanit A değil. peki yanlis cevap yani bizim isaretlediğimiz A olabilir mi, bakiyoruz yanlisYanit eşit mi A ya?
                                          ? Colors.red
                                          : null // eğer yanlisYanit A ya esitse kirmizi yansin. eşit degilse null olsun. Süper bizim tikladiğimiz bu değil B, C veya D olabilir onlara da aynisini yapiyoruz.
                                  : null, // cevaplanan soru bu for dongusunde degil
                            ),
                          ),
                          onPressed: () => _tiklandi(
                              "A",
                              sorulistesi[index]
                                  .soruNo), // tikladiğimiz şık ve soru numarasi _tiklandi fonksyonuna gidiyor.
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: RaisedButton(
                          child: Text(
                            'B',
                            style: TextStyle(
                                color: soruCevaplandi ==
                                        sorulistesi[index].soruNo
                                    ? dogruYanit == "B"
                                        ? Colors.green
                                        : yanlisYanit == "B" ? Colors.red : null
                                    : null),
                          ),
                          onPressed: () =>
                              _tiklandi("B", sorulistesi[index].soruNo),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: RaisedButton(
                          child: Text(
                            'C',
                            style: TextStyle(
                                color: soruCevaplandi ==
                                        sorulistesi[index].soruNo
                                    ? dogruYanit == "C"
                                        ? Colors.green
                                        : yanlisYanit == "C" ? Colors.red : null
                                    : null),
                          ),
                          onPressed: () =>
                              _tiklandi("C", sorulistesi[index].soruNo),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: RaisedButton(
                          child: Text(
                            'D',
                            style: TextStyle(
                                color: soruCevaplandi ==
                                        sorulistesi[index].soruNo
                                    ? dogruYanit == "D"
                                        ? Colors.green
                                        : yanlisYanit == "D" ? Colors.red : null
                                    : null),
                          ),
                          onPressed: () =>
                              _tiklandi("D", sorulistesi[index].soruNo),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _tiklandi(String verilenCevap, int cevaplananSoruNo) {
      // soru listesi 0 dan basliyor ama biz soruları numaralandiri iken 1 den basladik. o yuzden 1 cikarttik
      // soruNo yu 0 dan baslatırsan -1 yazmana gerek yok
    for (var i = 0; i < cevaplananSorular.length; i++) {
      if (cevaplananSorular[i] == cevaplananSoruNo) {
        setState(() {
          cevaplandi = true;
        });
        return Fluttertoast.showToast(
            msg: "opss dostum - bu soruyu daha önce cevapladın!");
      } else if (cevaplananSorular[i] != cevaplananSoruNo) {
        setState(() {
          cevaplandi = false;
        });
      }
    }

    if (cevaplandi != true) {
      if (sorulistesi[cevaplananSoruNo - 1].cevap == verilenCevap) {
        debugPrint(" ** dogruuuuu");
        setState(() {
          puan = puan + 5;
          dogruYanit = verilenCevap;
          soruCevaplandi = cevaplananSoruNo;
          cevaplananSorular.add(cevaplananSoruNo);
          debugPrint(cevaplananSorular[0].toString());
        });
      } else {
        setState(() {
          debugPrint("oops yansil cevap verdinn");
          soruCevaplandi = cevaplananSoruNo;
          yanlisYanit = verilenCevap;
          dogruYanit = sorulistesi[cevaplananSoruNo - 1].cevap;
          cevaplananSorular.add(cevaplananSoruNo);
        });
      }
    }


    if (cevaplananSoruNo == sorulistesi.length) {
      sleep(const Duration(seconds: 1)); // 1sn bekle
      return Alert(
        context: context,
        type: puan > 70 ? AlertType.success : AlertType.error ,
        title: puan > 70 ? "Sınav Sonucunuz: Tebrikler" : "Sınav Sonucunuz: Başarısız",
        desc: "PUANINIZ : $puan",
        buttons: [
          DialogButton(
            child: Text(
              "TAMAM",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
}
