import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/room_model.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<dynamic>? rooms;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://run.mocky.io/v3/85db21b4-32a7-4032-bb80-694bb596a445'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        rooms = jsonData['rooms'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'ru_RU', symbol: '₽');
    return formatter.format(amount);
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
          "Steigenberger Makadi",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: unnecessary_null_comparison
          rooms != null
              ? SizedBox(
                  height: height * 0.875,
                  child: ListView.builder(
                    itemCount: rooms!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final room = rooms![index];
                      return Container(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 17,
                            ),
                            SizedBox(
                              height: height * 0.26,
                              child: Swiper(
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the radius as needed
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover, imageUrl: room['image_urls'][index],
                                      errorWidget: (context, url, error) => Image.network("https://cdn-icons-png.flaticon.com/128/3875/3875172.png"),
                                    ),
                                  );
                                },
                                autoplay: true,
                                itemCount: room["image_urls"].length,
                                scrollDirection: Axis.horizontal,
                                pagination: SwiperPagination(
                                    alignment: Alignment.bottomCenter,
                                    builder: DotSwiperPaginationBuilder(
                                        color: const Color(0xffffffff),
                                        activeColor: const Color(0xff000000),
                                        size: height * 0.010,
                                        activeSize: height * 0.014)),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              room['name'],
                              style: TextStyle(
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.027),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              spacing: 8.0, // Adjust the spacing between containers
                              runSpacing: 8.0, // Adjust the spacing between lines
                              children: room['peculiarities'].map<Widget>((peculiarity) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Color(0xffF4F3F8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                                    child: Text(
                                      peculiarity, // Replace with your actual data
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
                            Container(
                              width: height * 0.27,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color:
                                    const Color(0xff0D72FF).withOpacity(0.10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Подробнее о номере",
                                      style: TextStyle(
                                          color: const Color(0xff0D72FF),
                                          fontSize: height * 0.018,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: height * 0.020,
                                      color: const Color(0xff0D72FF),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatCurrency(room["price"]),
                                  style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                      fontSize: height * 0.030),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Text(
                                    room["price_per"],
                                    style: TextStyle(
                                        color: const Color(0xff828796),
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.018),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/third'),
                              child: Container(
                                height: height * 0.060,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const Padding(
                padding: EdgeInsets.only(top: 348.0),
                child: Center(
                    child: CircularProgressIndicator(),
                  ),
              ),
        ],
      ),
    );
  }
}
