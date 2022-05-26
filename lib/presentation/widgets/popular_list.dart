import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPopular extends StatefulWidget {
  const ListPopular({Key? key}) : super(key: key);

  @override
  State<ListPopular> createState() => _ListPopularState();
}

class _ListPopularState extends State<ListPopular> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        margin: const EdgeInsets.only(
          right: 12,
          top: 4,
          bottom: 4,
        ),
        child: SizedBox(
          width: 150,
          // height: 280,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/desa-adat-praijing.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kampung Naga',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF3252DF),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    index % 3 == 0
                        ? const Icon(
                            Icons.favorite,
                            size: 14,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_outline_rounded,
                            size: 14,
                            color: Colors.grey[800],
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 10,
                      color: Colors.grey[800],
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Tasikmalaya, Jawa Barat',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      size: 14,
                      color: Color(0xFFFFCC47),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '4.8 ',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                            ),
                          ),
                          TextSpan(
                            text: '(512 reviews)',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 8,
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
    );
  }
}
