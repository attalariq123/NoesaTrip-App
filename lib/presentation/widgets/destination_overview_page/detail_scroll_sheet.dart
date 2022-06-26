import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noesatrip_app/data/models/destination.dart';
import 'package:noesatrip_app/data/providers/auth.dart';
import 'package:noesatrip_app/data/providers/destination_data.dart';
import 'package:provider/provider.dart';
import 'review_list.dart';

class DetailScrollSheet extends StatelessWidget {
  const DetailScrollSheet({Key? key, required this.item}) : super(key: key);

  final Destination item;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: const [
        0.6,
      ],
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ScrollViewContent(item: item),
        );
      },
    );
  }
}

class ScrollViewContent extends StatelessWidget {
  const ScrollViewContent({Key? key, required this.item}) : super(key: key);

  final Destination item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.all(0),
      child: InnerContent(item: item),
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  const CustomDraggingHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class InnerContent extends StatefulWidget {
  const InnerContent({Key? key, required this.item}) : super(key: key);
  final Destination item;

  @override
  State<InnerContent> createState() => _InnerContentState();
}

class _InnerContentState extends State<InnerContent> {
  bool isFavorite = true;
  final formatterPrice =
      NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final Destination item = widget.item;
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 20,
        right: 20,
        bottom: 60,
      ),
      child: Column(
        children: <Widget>[
          const CustomDraggingHandle(),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF3252DF),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        size: 14,
                        color: Colors.grey[800],
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        item.city,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    item.toggleFovoriteStatus(authData.userId, authData.token);
                  });
                  Provider.of<DestinationData>(context, listen: false)
                      .fetchDestination();
                },
                child: item.isFavorite
                    ? const Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_outline_rounded,
                        size: 30,
                        color: Colors.grey[800],
                      ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                formatterPrice.format(int.parse(item.price)),
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.star_rate_rounded,
                    size: 30,
                    color: Color(0xFFFFCC47),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${item.overallRating} ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: '(${item.totalReview} review)',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  item.description,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Facilities',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'See All',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF3252DF),
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              for (var i = 0; i < 3; i++) const ListReview(),
            ],
          ),
        ],
      ),
    );
  }
}
