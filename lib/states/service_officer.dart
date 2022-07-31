import 'package:dio/dio.dart';
import 'package:earthkpru/models/list_link_model.dart';
import 'package:earthkpru/states/authen.dart';
import 'package:earthkpru/utility/my_constant.dart';
import 'package:earthkpru/utility/my_dialog.dart';
import 'package:earthkpru/widgets/show_icon_button.dart';
import 'package:earthkpru/widgets/show_image.dart';
import 'package:earthkpru/widgets/show_image_internet.dart';
import 'package:earthkpru/widgets/show_progress.dart';
import 'package:earthkpru/widgets/show_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceOfficer extends StatefulWidget {
  const ServiceOfficer({Key? key}) : super(key: key);

  @override
  State<ServiceOfficer> createState() => _ServiceOfficerState();
}

class _ServiceOfficerState extends State<ServiceOfficer> {
  var pathImages = <String>[
    'images/icon1.png',
    'images/icon2.png',
    'images/icon3.png',
    'images/icon4.png',
    'images/icon5.png',
    'images/icon6.png',
    'images/icon1.png',
    'images/icon2.png',
  ];

  var titles = <String>[
    'หัวข้อที่ 1',
    'หัวข้อที่ 2',
    'หัวข้อที่ 3',
    'หัวข้อที่ 4',
    'หัวข้อที่ 5',
    'หัวข้อที่ 6',
    'หัวข้อที่ 7',
    'หัวข้อที่ 8',
  ];

  var listLinkModels = <ListLinkModel>[];

  @override
  void initState() {
    super.initState();
    readlistLinkData();
  }

  Future<void> readlistLinkData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    String urlAPI = 'https://mua.kpru.ac.th/FrontEnd_Mobile/listlink';

    await dio.get(urlAPI).then((value) {
      // print("value ===> $value");

      var result = value.data['data']['data'];
      for (var element in result) {
        ListLinkModel listLinkModel = ListLinkModel.fromMap(element);
        // print('listLinkModel ===> ${listLinkModel.toMap()}');
        listLinkModels.add(listLinkModel);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: MyConstant().linearGradiant(),
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: ShowText(
                  text: 'รายการ',
                  textStyle: MyConstant().h2WhiteStyle(),
                ),
              ),
              manuGridview(),
              Container(
                margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: ShowText(
                  text: 'List Link',
                  textStyle: MyConstant().h2Style(),
                ),
              ),
              Divider(
                color: MyConstant.dark,
              ),
              listLinkModels.isEmpty
                  ? const ShowProgress()
                  : listViewListLink(constraints),
            ],
          ),
        ),
      ),
    );
  }

  ListView listViewListLink(BoxConstraints constraints) {
    return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: listLinkModels.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              width: constraints.maxWidth - 110,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShowText(
                                    text: listLinkModels[index].name,
                                    textStyle: MyConstant().h3ActiveStyle(),
                                  ),
                                  ShowText(text: listLinkModels[index].link)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              width: 100,
                              height: 100,
                              child: ShowImageInternet(
                                  urlImage: listLinkModels[index].image),
                            ),
                          ],
                        ),
                        Divider(
                          color: MyConstant.dark,
                        ),
                      ],
                    ),
                  );
  }

  GridView manuGridview() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: pathImages.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          MyDialog(context: context).normalDialog(
              title: titles[index], subTitle: 'You Click ${titles[index]}');
        },
        child: Card(
          color: MyConstant.button.withOpacity(0.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ShowImage(
                  path: pathImages[index],
                ),
              ),
              ShowText(
                text: titles[index],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        ShowIconButton(
          color: Colors.white,
          iconData: Icons.exit_to_app,
          pressFunc: () {
            MyDialog(context: context).normalDialog(
                pressFunc: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear().then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Authen(),
                        ),
                        (route) => false);
                  });
                },
                label: 'SignOut',
                title: 'SignOut ?',
                subTitle: 'คุณต้องการจะ SignOut ?');
          },
        )
      ],
      centerTitle: true,
      backgroundColor: MyConstant.bgColor,
      title: ShowText(
        text: 'Officer',
        textStyle: MyConstant().h2WhiteStyle(),
      ),
    );
  }
}
