import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Map<String, dynamic>? hotelData;
  bool isExpanded = false;
  bool isExpanded1 = false;
  List<Tourist> tourists = [];
  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    isExpandedList = List.generate(tourists.length, (index) => false);
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'ru_RU', symbol: '₽');
    return formatter.format(amount);
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff'),
      );

      if (response.statusCode == 200) {
        setState(() {
          hotelData = json.decode(response.body);
        });
      } else {
        print('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final TextEditingController controller = TextEditingController(text: '+7');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _srokController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF4F3F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: Text(
          "Бронирование",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: height * 0.024),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height * 0.024,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            hotelData == null
                ? const Padding(
                    padding: EdgeInsets.only(top: 350.0),
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: height * 0.760,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 13),
                            decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.012,
                                      vertical: height * 0.008),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: const Color(0xffFFC700)
                                          .withOpacity(0.20)),
                                  child: Text(
                                    "⭐️ ${hotelData?["horating"] ?? ''} ${hotelData?["rating_name"] ?? ''}",
                                    style: GoogleFonts.inter(
                                        color: const Color(0xffFFA800),
                                        fontSize: height * 0.018),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  hotelData?["hotel_name"] ?? '',
                                  style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.025),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  hotelData?["hotel_adress"] ?? '',
                                  style: TextStyle(
                                      color: const Color(0xff0D72FF),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.015),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 13),
                            decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: height * 0.20,
                                      child: const Text(
                                        "Вылет из",
                                        style:
                                            TextStyle(color: Color(0xff828796)),
                                      ),
                                    ),
                                    Text(
                                      hotelData?["departure"] ?? "",
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: height * 0.20,
                                        child: const Text(
                                          "Страна, город",
                                          style: TextStyle(
                                              color: Color(0xff828796)),
                                        )),
                                    Text(
                                      hotelData?["arrival_country" ?? ""],
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: height * 0.20,
                                        child: const Text(
                                          "Даты",
                                          style: TextStyle(
                                            color: Color(0xff828796),
                                          ),
                                        )),
                                    Text(
                                      "${hotelData?["tour_date_start" ?? '']} - ${hotelData?["tour_date_stop" ?? '']}",
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: height * 0.20,
                                        child: const Text(
                                          "Кол-во ночей",
                                          style: TextStyle(
                                              color: Color(0xff828796)),
                                        )),
                                    Text(
                                      "${hotelData?["number_of_nights" ?? '']} ночей",
                                      style: const TextStyle(
                                          color: Color(0xff000000)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: height * 0.20,
                                        child: const Text(
                                          "Отель",
                                          style: TextStyle(
                                              color: Color(0xff828796)),
                                        )),
                                    const Text(
                                      "Steigenberger Makadi",
                                      style:
                                          TextStyle(color: Color(0xff000000)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: height * 0.20,
                                        child: const Text(
                                          "Номер",
                                          style: TextStyle(
                                              color: Color(0xff828796)),
                                        )),
                                    SizedBox(
                                        width: height * 0.22,
                                        child: Text(
                                          hotelData?["room" ?? ''],
                                          style: const TextStyle(
                                              color: Color(0xff000000)),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: height * 0.20,
                                        child: const Text(
                                          "Питание",
                                          style: TextStyle(
                                              color: Color(0xff828796)),
                                        )),
                                    Text(
                                      hotelData?["nutrition" ?? ""],
                                      style: const TextStyle(
                                          color: Color(0xff000000)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 13),
                            decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Информация о покупателе",
                                  style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.025),
                                ),
                                SizedBox(
                                  height: height * 0.018,
                                ),
                                Container(
                                  height: height * 0.090,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Color(0xffF6F6F9)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 5.0),
                                        child: Text(
                                          "Номер телефона",
                                          style: TextStyle(
                                              color: const Color(0xffA9ABB7),
                                              fontSize: height * 0.019),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.007,
                                      ),
                                      SizedBox(
                                        height: height * 0.045,
                                        child: TextFormField(
                                          inputFormatters: [
                                            TextInputMask(
                                              mask: '\\+9 (999) 999-99-99',
                                              placeholder: '* ',
                                              maxPlaceHolders: 13,
                                            )
                                          ],
                                          controller: controller,
                                          keyboardType: TextInputType.number,
                                          cursorHeight: height * 0.022,
                                          decoration: const InputDecoration(
                                            hintText:
                                                '+7  _ _  _ _ _  _ _  _ _ ',
                                            filled: true,
                                            fillColor: Color(0xffF6F6F9),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.014,
                                ),
                                Container(
                                  height: height * 0.090,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Color(0xffF6F6F9)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 5.0),
                                        child: Text(
                                          "Почта",
                                          style: TextStyle(
                                              color: const Color(0xffA9ABB7),
                                              fontSize: height * 0.019),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.007,
                                      ),
                                      SizedBox(
                                        height: height * 0.045,
                                        child: TextFormField(
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          cursorHeight: height * 0.022,
                                          decoration: const InputDecoration(
                                            hintText: 'example@gmail.com',
                                            filled: true,
                                            fillColor: Color(0xffF6F6F9),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.014,
                                ),
                                Text(
                                  "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту",
                                  style: TextStyle(
                                      color: const Color(0xff828796),
                                      fontSize: height * 0.018),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(isExpanded ? 12.0 : 12.0),
                            child: ExpansionTile(
                              collapsedBackgroundColor: Color(0xffFFFFFF),
                              backgroundColor: Color(0xffFFFFFF),
                              title: Text(
                                "Первый турист ",
                                style: TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.024),
                              ),
                              // You can customize the title
                              initiallyExpanded: isExpanded,
                              trailing: Container(
                                height: height * 0.045,
                                width: height * 0.045,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    color: const Color(0xff0D72FF)
                                        .withOpacity(0.10)),
                                child: Center(
                                  child: Icon(
                                    isExpanded
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    size: height * 0.035,
                                    color: const Color(0xff0D72FF),
                                  ),
                                ),
                              ),
                              onExpansionChanged: (bool expanded) {
                                setState(() {
                                  isExpanded = expanded;
                                });
                              },
                              children: [
                                // Content inside the ExpansionTile when expanded
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 13),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF),
                                      border: Border.all(
                                          color: Colors.transparent)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height * 0.090,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffF6F6F9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 5.0),
                                              child: Text(
                                                "Имя",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffA9ABB7),
                                                    fontSize: height * 0.019),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.007,
                                            ),
                                            SizedBox(
                                              height: height * 0.045,
                                              child: TextFormField(
                                                controller: _nameController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                cursorHeight: height * 0.022,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Иван',
                                                  filled: true,
                                                  fillColor: Color(0xffF6F6F9),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.013,
                                      ),
                                      Container(
                                        height: height * 0.090,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffF6F6F9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 5.0),
                                              child: Text(
                                                "Фамилия",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffA9ABB7),
                                                    fontSize: height * 0.019),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.007,
                                            ),
                                            SizedBox(
                                              height: height * 0.045,
                                              child: TextFormField(
                                                controller: _surnameController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                cursorHeight: height * 0.022,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Иванов',
                                                  filled: true,
                                                  fillColor: Color(0xffF6F6F9),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.013,
                                      ),
                                      Container(
                                        height: height * 0.090,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffF6F6F9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 5.0),
                                              child: Text(
                                                "Дата рождения",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffA9ABB7),
                                                    fontSize: height * 0.019),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.007,
                                            ),
                                            SizedBox(
                                              height: height * 0.045,
                                              child: TextFormField(
                                                controller: _birthDayController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                cursorHeight: height * 0.022,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: '16/05/2004',
                                                  filled: true,
                                                  fillColor: Color(0xffF6F6F9),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.013,
                                      ),
                                      Container(
                                        height: height * 0.090,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffF6F6F9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 5.0),
                                              child: Text(
                                                "Гражданство",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffA9ABB7),
                                                    fontSize: height * 0.019),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.007,
                                            ),
                                            SizedBox(
                                              height: height * 0.045,
                                              child: TextFormField(
                                                controller: _countryController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                cursorHeight: height * 0.022,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Uzbekistan',
                                                  filled: true,
                                                  fillColor: Color(0xffF6F6F9),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.013,
                                      ),
                                      Container(
                                        height: height * 0.090,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffF6F6F9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 5.0),
                                              child: Text(
                                                "Номер загранпаспорта",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffA9ABB7),
                                                    fontSize: height * 0.019),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.007,
                                            ),
                                            SizedBox(
                                              height: height * 0.045,
                                              child: TextFormField(
                                                controller: _passportController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                cursorHeight: height * 0.022,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'AB2345678',
                                                  filled: true,
                                                  fillColor: Color(0xffF6F6F9),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.013,
                                      ),
                                      Container(
                                        height: height * 0.090,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color(0xffF6F6F9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 5.0),
                                              child: Text(
                                                "Срок действия загранпаспорта",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffA9ABB7),
                                                    fontSize: height * 0.019),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.007,
                                            ),
                                            SizedBox(
                                              height: height * 0.045,
                                              child: TextFormField(
                                                controller: _srokController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                cursorHeight: height * 0.022,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: '22/05/26',
                                                  filled: true,
                                                  fillColor: Color(0xffF6F6F9),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          for (var i = 1; i < tourists.length; i++)
                            Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      i == tourists.length - 1 ? 10.0 : 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    isExpanded ? 12.0 : 12.0),
                                child: ExpansionTile(
                                  collapsedBackgroundColor: Color(0xffFFFFFF),
                                  backgroundColor: Color(0xffFFFFFF),
                                  title: Text(
                                    "Tourist ${i + 1}",
                                    style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.024,
                                    ),
                                  ),
                                  initiallyExpanded: isExpanded,
                                  trailing: Container(
                                    height: height * 0.045,
                                    width: height * 0.045,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      color:
                                          Color(0xff0D72FF).withOpacity(0.10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        (isExpanded1)
                                            ? Icons.expand_less
                                            : Icons.expand_more,
                                        size: height * 0.035,
                                        color: Color(0xff0D72FF),
                                      ),
                                    ),
                                  ),
                                  onExpansionChanged: (bool expanded1) {
                                    setState(() {
                                      isExpanded1 = expanded1;
                                    });
                                  },
                                  children: [
                                    // Content inside the ExpansionTile when expanded
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 13),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFFFFFF),
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: height * 0.090,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                color: Color(0xffF6F6F9)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5.0),
                                                  child: Text(
                                                    "Имя",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xffA9ABB7),
                                                        fontSize:
                                                            height * 0.019),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.007,
                                                ),
                                                SizedBox(
                                                  height: height * 0.045,
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                      text: tourists[i].name,
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    cursorHeight:
                                                        height * 0.022,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: 'Иван',
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xffF6F6F9),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.013,
                                          ),
                                          Container(
                                            height: height * 0.090,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                color: Color(0xffF6F6F9)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5.0),
                                                  child: Text(
                                                    "Фамилия",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xffA9ABB7),
                                                        fontSize:
                                                            height * 0.019),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.007,
                                                ),
                                                SizedBox(
                                                  height: height * 0.045,
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                      text: tourists[i].surname,
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    cursorHeight:
                                                        height * 0.022,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: 'Иванов',
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xffF6F6F9),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.013,
                                          ),
                                          Container(
                                            height: height * 0.090,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                color: Color(0xffF6F6F9)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5.0),
                                                  child: Text(
                                                    "Дата рождения",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xffA9ABB7),
                                                        fontSize:
                                                            height * 0.019),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.007,
                                                ),
                                                SizedBox(
                                                  height: height * 0.045,
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                      text:
                                                          tourists[i].birthDay,
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    cursorHeight:
                                                        height * 0.022,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: '16/05/2004',
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xffF6F6F9),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.013,
                                          ),
                                          Container(
                                            height: height * 0.090,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                color: Color(0xffF6F6F9)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5.0),
                                                  child: Text(
                                                    "Гражданство",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xffA9ABB7),
                                                        fontSize:
                                                            height * 0.019),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.007,
                                                ),
                                                SizedBox(
                                                  height: height * 0.045,
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                            text: tourists[i]
                                                                .country),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    cursorHeight:
                                                        height * 0.022,
                                                    decoration: InputDecoration(
                                                      hintText: "Uzbekistan",
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xffF6F6F9),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.013,
                                          ),
                                          Container(
                                            height: height * 0.090,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                color: Color(0xffF6F6F9)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5.0),
                                                  child: Text(
                                                    "Номер загранпаспорта",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xffA9ABB7),
                                                        fontSize:
                                                            height * 0.019),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.007,
                                                ),
                                                SizedBox(
                                                  height: height * 0.045,
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                      text:
                                                          tourists[i].passport,
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    cursorHeight:
                                                        height * 0.022,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: 'AB2345678',
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xffF6F6F9),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.013,
                                          ),
                                          Container(
                                            height: height * 0.090,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                color: Color(0xffF6F6F9)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0, top: 5.0),
                                                  child: Text(
                                                    "Срок действия загранпаспорта",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xffA9ABB7),
                                                        fontSize:
                                                            height * 0.019),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.007,
                                                ),
                                                SizedBox(
                                                  height: height * 0.045,
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                      text: tourists[i].srok,
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    cursorHeight:
                                                        height * 0.022,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: '22/05/26',
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xffF6F6F9),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                tourists.add(Tourist(
                                  name: '',
                                  surname: '',
                                  birthDay: '',
                                  country: '',
                                  passport: '',
                                  srok: '',
                                ));
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 13),
                              decoration: const BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Добавить туриста",
                                        style: TextStyle(
                                            color: const Color(0xff000000),
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.024),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          height: height * 0.040,
                                          width: height * 0.040,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              color: Color(0xff0D72FF)),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              size: height * 0.035,
                                              color: const Color(0xffFFFFFF),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 13),
                            decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Тур",
                                      style:
                                          TextStyle(color: Color(0xff828796)),
                                    ),
                                    const Spacer(),
                                    Text(
                                      _formatCurrency(186600),
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Топливный сбор",
                                      style:
                                          TextStyle(color: Color(0xff828796)),
                                    ),
                                    const Spacer(),
                                    Text(
                                      _formatCurrency(
                                          hotelData?["fuel_charge"] ?? ''),
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Сервисный сбор",
                                      style: TextStyle(
                                        color: Color(0xff828796),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      _formatCurrency(
                                          hotelData?["service_charge"] ?? ''),
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "К оплате",
                                      style:
                                          TextStyle(color: Color(0xff828796)),
                                    ),
                                    const Spacer(),
                                    Text(
                                      _formatCurrency(
                                          hotelData?["tour_price"] ?? ''),
                                      style: const TextStyle(
                                          color: Color(0xff0D72FF)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            const Spacer(),
            const SizedBox(
              height: 7.0,
            ),
            InkWell(
              onTap: () {
                // Check if all controllers are not empty
                if (_areAllControllersValid()) {
                  Navigator.pushNamed(context, '/fourth');
                } else {
                  _showErrorSnackbar();
                }
                print(controller.text.length);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: height * 0.060,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: _areAllControllersValid()
                        ? const Color(0xff0D72FF)
                        : const Color(0xff0D72FF).withOpacity(
                            0.5), // Change color based on the condition
                  ),
                  child: Center(
                    child: Text(
                      _formatCurrency(hotelData?["tour_price"] ?? 0),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xffFFFFFF),
                        fontSize: height * 0.019,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }

  // Helper method to check if all controllers are not empty
  bool _areAllControllersValid() {
    return _isValidEmail(_emailController.text) &&
        (controller.text.length == 18) &&
        controller.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _surnameController.text.isNotEmpty &&
        _birthDayController.text.isNotEmpty &&
        _countryController.text.isNotEmpty &&
        _passportController.text.isNotEmpty &&
        _srokController.text.isNotEmpty;
  }

  bool _isValidEmail(String email) {
    // A basic email format validation using regex
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

// Helper method to show a Snackbar with an error message for each empty field
  void _showErrorSnackbar() {
    // final snackBar = SnackBar(
    //   content: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       if (_nameController.text.isEmpty) Text('Name cannot be empty'),
    //       if (_srokController.text.isEmpty) Text('SROK cannot be empty'),
    //       if (_surnameController.text.isEmpty) Text('Surname cannot be empty'),
    //       if (_birthDayController.text.isEmpty) Text('Birthday cannot be empty'),
    //       if (_countryController.text.isEmpty) Text('Country cannot be empty'),
    //       if (_passportController.text.isEmpty) Text('Passport cannot be empty'),
    //       if (_emailController.text.isEmpty) Text('Email cannot be empty'),
    //     ],
    //   ),
    //   backgroundColor: const Color(0xffEB5757),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

    String errorMessages = '';

    // Check if the email is not valid
    if (_emailController.text.isEmpty ||
        !_isValidEmail(_emailController.text)) {
      errorMessages += 'Email is not valid\n';
    }

// Check if the phone number is not valid (you can replace the regex pattern with your desired phone number validation)

    if (controller.text.length == 16) {
      errorMessages += 'Phone number is not valid\n';
    }

    if (_nameController.text.isEmpty) {
      errorMessages += 'Name cannot be empty\n';
    }

    if (_surnameController.text.isEmpty) {
      errorMessages += 'Surname cannot be empty\n';
    }

    if (_birthDayController.text.isEmpty) {
      errorMessages += 'Birthday cannot be empty\n';
    }

    if (_countryController.text.isEmpty) {
      errorMessages += 'Country cannot be empty\n';
    }

    if (_passportController.text.isEmpty) {
      errorMessages += 'Passport cannot be empty\n';
    }

    if (_srokController.text.isEmpty) {
      errorMessages += 'Expire date cannot be empty\n';
    }

    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Important❗️',
        message: errorMessages,
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class Tourist {
  String name;
  String surname;
  String birthDay;
  String country;
  String passport;
  String srok;

  Tourist({
    required this.name,
    required this.surname,
    required this.birthDay,
    required this.country,
    required this.passport,
    required this.srok,
  });
}
