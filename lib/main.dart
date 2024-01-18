import 'package:flutter/material.dart';
import 'package:flutter_project/src/features/core/screens/book/booking_page.dart';
import 'package:flutter_project/src/features/core/screens/hotel/hotel_page.dart';
import 'package:flutter_project/src/features/core/screens/paid/paid_page.dart';
import 'package:flutter_project/src/features/core/screens/room/room_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HotelPage(),
        '/second': (context) => const RoomPage(),
        '/third': (context) => const BookingPage(),
        '/fourth' : (context) => const PaidPage(),
      },
    );
  }
}
