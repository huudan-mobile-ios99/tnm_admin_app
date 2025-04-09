import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:video_player/video_player.dart';

class HomeJPPage extends StatefulWidget {
  final String dropValue;
  final int machineNumber;
  final String  jpNameSpace;
  final String jpName;
  final int lastestValue;
  final double width;
  final double widthJP;
  final double height;
  final String asset;
  final String dateTime;
  final String title;
  final double borderRadius;
  final double textSize;
  const HomeJPPage(
  {super.key,
  required this.dropValue,
    required this.jpNameSpace,
    required this.dateTime,
    required this.machineNumber,
    required this.borderRadius,
    required this.jpName,
    required this.widthJP,
    required this.width,
    required this.lastestValue,
    required this.height,
    required this.asset,
    required this.title,
    required this.textSize,
  });

  @override
  State<HomeJPPage> createState() => _HomeJPPageState();
}

class _HomeJPPageState extends State<HomeJPPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Load video from assets
    _controller = VideoPlayerController.asset('asset/effect3.mp4')
      ..setLooping(true) // Loop the video
      ..setVolume(0.0)
      ..initialize().then((_) {
        // Play video after initialization
        _controller.play();
        setState(() {}); // Refresh to display video
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return
    Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            _controller.value.isInitialized ?

             Opacity(
              opacity: 0.99,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(MyString.padding16), // Rounded corners
                child: SizedBox(
                width: widget.width,
                height: widget.height ,
                  child: Transform.scale(
                    scale: 2,
                    child: VideoPlayer(
                      _controller
                    ),
                  ),
                ),
              ),
            ) : Container(),
            DelayedJpDropBoxBody(
              dropValue: widget.dropValue,
              dateTime:widget.dateTime,
              machineNumber: widget.machineNumber,
              jpName: widget.jpName,
              width: widget.widthJP,
              height: widget.height,
              asset: widget.asset,
              title: widget.title,
              textSize: widget.textSize,
              borderRadius: widget.borderRadius,
            ),
          ],
        ),
        //  Center(
        //        child: JackpotDropBoxPage(
        //         width: effectWidth,
        //         height: widget.height * SizeConfig.jackpotHeightRation,
        //      ),),
      ],
    );
  }
}







Widget DelayedJpDropBoxBody({
  required String dropValue,
  required int machineNumber,
  required String jpName,
  required double width,
  required double height,
  required String asset,
  required String dateTime,
  required String title,
  required double textSize,
  required double borderRadius,
}) {
  return Container(
  //  margin: const EdgeInsets.symmetric(horizontal: MyString.padding12),
    // padding: const EdgeInsets.symmetric(horizontal: MyString.padding12),
    decoration: BoxDecoration(
      // color:MyColor.black_text_opa2,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: MyColor.white,
            fontSize: MyString.padding24,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(asset),
              fit: BoxFit.contain,
            ),
          ),
          child: Text(
            '\$$dropValue',
            style: TextStyle(
              color: MyColor.yellow_bg,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "#$machineNumber",
              style: const TextStyle(
                color: MyColor.white,
                fontSize: MyString.padding32,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              dateTime,
              style: const TextStyle(
                color: MyColor.white,
                fontSize: MyString.padding16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}



