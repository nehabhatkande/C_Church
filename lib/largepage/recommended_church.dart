import 'package:cchurch/globals.dart';
import 'package:cchurch/home/map_page.dart';
import 'package:cchurch/largepage/add_booking.dart';
import 'package:cchurch/utils/colors.dart';
import 'package:cchurch/utils/dimensions.dart';
import 'package:cchurch/widgets/app_icon.dart';
import 'package:cchurch/widgets/big_text.dart';
import 'package:cchurch/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedChurch extends StatelessWidget {
  const RecommendedChurch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                color: Colors.white,
                child: Center(
                    child:
                        // BigText(size: Dimensions.font26, text: church.ch_Nm)
                        Text(church.ch_Nm, style: TextStyle(fontSize: 20),)
                        ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.buttonbackgroundColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                church.imglnk,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: church.desc),
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) {
                //       return MapBookingPage();
                //     }));
                //   },
                //   child: AppIcon(
                //     iconSize: Dimensions.iconSize24,
                //     iconColor: Colors.white,
                //     icon: Icons.location_on,
                //     BackgroundColor: AppColors.mainColor,
                //   ),
                // ),
                SizedBox(height: 100,),
                SizedBox(
                  height: 50.0, 
                  width: 200.0, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddBookingPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                    ),
                    child: Text(
                      'Book Here',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
