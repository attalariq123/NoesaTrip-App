import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noesatrip_app/data/models/destination.dart';
import 'package:noesatrip_app/data/providers/destination_data.dart';
import 'package:noesatrip_app/presentation/screens/destination_overview_page.dart';
import 'package:noesatrip_app/presentation/screens/profile_page.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    final destinationData = Provider.of<DestinationData>(context).favoriteItems;
    return Scaffold(
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: destinationData.length,
        itemBuilder: (context, index) =>
            ListWishlist(item: destinationData[index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 200,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
      ),
    );
  }
}

class ListWishlist extends StatefulWidget {
  const ListWishlist({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Destination item;

  @override
  State<ListWishlist> createState() => _ListWishlistState();
}

class _ListWishlistState extends State<ListWishlist> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DestinationOverviewPage(item: item),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: SizedBox(
          // width: 150,
          // height: 280,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(item.imagePath!),
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
                    Expanded(
                      child: Text(
                        '${item.name}',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF3252DF),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      // onTap: () {
                      //   setState(() {
                      //     isFavorite = !isFavorite;
                      //     // print(isFavorite);
                      //   });
                      // },
                      child: item.isFavorite!
                          ? const Icon(
                              Icons.favorite,
                              size: 16,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_outline_rounded,
                              size: 16,
                              color: Colors.grey[800],
                            ),
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
                    Expanded(
                      child: Text(
                        '${item.city}',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
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
                            text: '${item.overallRating} ',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                            ),
                          ),
                          TextSpan(
                            text: '(${item.totalReview} reviews)',
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
