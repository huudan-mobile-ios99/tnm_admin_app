import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textcustom({text,size,isBold, }) {
  return Text(text,
    style: GoogleFonts.inter(
    fontSize: size,fontWeight:isBold==true? FontWeight.w500:FontWeight.normal),);
}

Widget textcustomColor({text,size,isBold,color}) {
  return Text(text,style: GoogleFonts.inter(
    color:  color,
    fontSize: size,fontWeight:isBold==true? FontWeight.w500:FontWeight.normal),);
}


Widget textcustomCenter({text,size,isBold,TextAlign align =TextAlign.center }) {
  return Text(text,
    textAlign: align,
    style: GoogleFonts.inter(
    fontSize: size,fontWeight:isBold==true? FontWeight.w500:FontWeight.normal),);
}



Widget textcustomIcon({text,size,isBold,color,required icon}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon),const SizedBox(width: 4.0,),
      Text(text,style: GoogleFonts.poppins(fontSize: size,fontWeight:isBold==true? FontWeight.w500:FontWeight.normal),),
    ],
  );
}
