import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  Map<String, dynamic>? hotelData;

  List<String> imagePaths = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpwqjuG0-kLF3vCSsnjJAUahUCxblZwGaqsw&usqp=CAU",
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_H0IyXXeeYOACUWHoLHMXKILapT-5GR84CA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNc7XQ6LpZjz6T0yQUM6E7IdqSx59MHnLVVA&usqp=CAU',
  ];

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'ru_RU', symbol: '₽');
    return formatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    fetchHotelData();
  }

  Future<void> fetchHotelData() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/75000507-da9a-43f8-a618-df698ea7176d'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        hotelData = data;
      });
    } else {
      throw Exception('Failed to load hotel data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF4F3F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: Text(
          "Отель",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: height * 0.028),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hotelData == null
                ? const Padding(
                    padding: EdgeInsets.only(top: 348.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SizedBox(
                    height: height * 0.769,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.26,
                                  child: Swiper(
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover, imageUrl: hotelData!['image_urls'][index],
                                          errorWidget: (context, url, error) => Image.network("https://cdn-icons-png.flaticon.com/128/3875/3875172.png"),
                                        ),
                                      );
                                    },
                                    autoplay: true,
                                    itemCount: hotelData!['image_urls'].length,
                                    scrollDirection: Axis.horizontal,
                                    pagination: SwiperPagination(
                                      alignment: Alignment.bottomCenter,
                                      builder: DotSwiperPaginationBuilder(
                                        color: const Color(0xffffffff),
                                        activeColor: const Color(0xff000000),
                                        size: height * 0.010,
                                        activeSize: height * 0.014,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.012,
                                      vertical: height * 0.008),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: const Color(0xffFFC700)
                                          .withOpacity(0.20)),
                                  child: Text(
                                    "⭐️ ${hotelData!["rating"]} ${hotelData!["rating_name"]}",
                                    style: GoogleFonts.inter(
                                        color: const Color(0xffFFA800),
                                        fontSize: height * 0.018),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  hotelData!['name'],
                                  style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.025),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  hotelData!["adress"],
                                  style: TextStyle(
                                      color: const Color(0xff0D72FF),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.015),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "от ${_formatCurrency(hotelData!["minimal_price"])}",
                                      style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w700,
                                          fontSize: height * 0.028),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        hotelData!["price_for_it"],
                                        style: TextStyle(
                                            color: const Color(0xff828796),
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.018),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 18),
                            decoration: const BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Об отеле",
                                  style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.025),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  // Adjust the spacing between containers
                                  runSpacing: 8.0,
                                  // Adjust the spacing between lines
                                  children: hotelData!['about_the_hotel']
                                          ['peculiarities']
                                      .map<Widget>((peculiarity) {
                                    return Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 6.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xffF4F3F8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 6),
                                        child: Text(
                                          peculiarity,
                                          // Replace with your actual data
                                          style: TextStyle(
                                            color: const Color(0xff828796),
                                            fontSize: height * 0.016,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  hotelData!["about_the_hotel"]["description"],
                                  style: TextStyle(
                                      color: const Color(0xff000000)
                                          .withOpacity(0.90),
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * 0.017),
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF4F3F8)
                                          .withOpacity(0.7),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 22.0,
                                            right: 22,
                                            top: 16,
                                            bottom: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.account_balance,
                                              size: height * 0.035,
                                            ),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Удобства",
                                                  style: GoogleFonts.inter(
                                                      fontSize: height * 0.022,
                                                      color: const Color(
                                                          0xff2C3035)),
                                                ),
                                                Text(
                                                  "Самое необходимое",
                                                  style: GoogleFonts.inter(
                                                      fontSize: height * 0.019,
                                                      color: const Color(
                                                          0xff828796)),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: height * 0.020,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: 333,
                                          child: Divider(
                                            color: const Color(0xff828796)
                                                .withOpacity(0.15),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 22.0,
                                            right: 22,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.account_balance,
                                                size: height * 0.035),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Что включено",
                                                  style: GoogleFonts.inter(
                                                      fontSize: height * 0.022,
                                                      color: const Color(
                                                          0xff2C3035)),
                                                ),
                                                Text(
                                                  "Самое необходимое",
                                                  style: GoogleFonts.inter(
                                                      fontSize: height * 0.019,
                                                      color: const Color(
                                                          0xff828796)),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: height * 0.020,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: 333,
                                          child: Divider(
                                            color: const Color(0xff828796)
                                                .withOpacity(0.15),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 22.0,
                                            right: 22,
                                            top: 5,
                                            bottom: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.account_balance,
                                                size: height * 0.035),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Что не включено",
                                                  style: GoogleFonts.inter(
                                                      fontSize: height * 0.022,
                                                      color: const Color(
                                                          0xff2C3035)),
                                                ),
                                                Text(
                                                  "Самое необходимое",
                                                  style: GoogleFonts.inter(
                                                      fontSize: height * 0.019,
                                                      color: const Color(
                                                          0xff828796)),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: height * 0.020,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: height * 0.060,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff0D72FF),
                  ),
                  child: Center(
                      child: Text(
                    "К выбору номера",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: const Color(0xffFFFFFF),
                        fontSize: height * 0.019,
                        fontWeight: FontWeight.w400),
                  )),
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
}
