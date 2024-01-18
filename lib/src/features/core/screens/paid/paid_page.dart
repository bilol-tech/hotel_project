import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/src/features/core/screens/hotel/hotel_page.dart';
import 'package:google_fonts/google_fonts.dart';

class PaidPage extends StatelessWidget {
  const PaidPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: Text(
          "Заказ оплачен",
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
            SizedBox(height: height * 0.150),
            Container(
              height: height * 0.120,
              width: height * 0.120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffF6F6F9),
              ),
              child: Center(
                  child: Text(
                "🎉",
                style: TextStyle(fontSize: height * 0.050),
              )),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Text(
              "Ваш заказ принят в работу",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500, fontSize: height * 0.030),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(
                "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: height * 0.020,
                      color: const Color(0xff828796),
                    ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: height * 0.060,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xff0D72FF),
                  ),
                  child: Center(
                    child: Text(
                      "Супер!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: const Color(0xffFFFFFF),
                          fontSize: height * 0.019,
                          fontWeight: FontWeight.w400),
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
}
