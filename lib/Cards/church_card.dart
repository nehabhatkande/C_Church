import 'package:cchurch/largepage/add_booking.dart';
import 'package:cchurch/largepage/recommended_church.dart';
import 'package:cchurch/mainpage/save_booking.dart';
import 'package:cchurch/models/ch_model.dart';
import 'package:cchurch/userfolder/Ubookingpage.dart';
import 'package:cchurch/utils/colors.dart';
import 'package:cchurch/utils/dimensions.dart';
import 'package:cchurch/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cchurch/globals.dart' as glb;
import 'package:get/get.dart';

class Ch_card extends StatefulWidget {
  const Ch_card({super.key, required this.dm});
  final ch_model dm;
  @override
  State<Ch_card> createState() => _Ch_cardState();
}

class _Ch_cardState extends State<Ch_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          glb.church.ch_id = widget.dm.ch_id;
          glb.church.ch_Nm = widget.dm.ch_nm;
          glb.church.imglnk = widget.dm.ch_img;
          glb.church.desc = widget.dm.desc;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => RecommendedChurch()),
          // );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 132, 201, 189),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Container(
                height: 150,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(widget.dm.ch_img),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 25),
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.dm.ch_nm,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          glb.church.ch_id = widget.dm.ch_id;
                          glb.church.imglnk = widget.dm.ch_img;
                          glb.church.ch_Nm = widget.dm.ch_nm;
                          glb.church.desc = widget.dm.desc;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UBookingPage(
                              pg: 'sepcific',
                            );
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                        ),
                        child: Text(
                          'My Booking',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          glb.church.ch_id = widget.dm.ch_id;
                          glb.church.imglnk = widget.dm.ch_img;
                          glb.church.ch_Nm = widget.dm.ch_nm;
                          glb.church.desc = widget.dm.desc;

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RecommendedChurch();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                        ),
                        child: Text(
                          'New Booking',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
