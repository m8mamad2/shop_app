import 'package:flutter/material.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/colors.dart';

IconData kVisibleAuthIcon = Icons.visibility_outlined;
IconData kVisibleFalseAuthIcon = Icons.visibility_off_outlined;

//! profile
List<IconData> kProfileIcons =[
  Icons.favorite,
  // Icons.chat,
  Icons.edit,
  Icons.language
];

//! drawer
List<IconData> kDrawerIcons = [
  Icons.person_outline,
  Icons.search_outlined,
  Icons.favorite_outline,
  // Icons.chat_outlined,
  Icons.contacts_outlined,
  Icons.error_outline,
  Icons.star_outline,
];


//! home category
final Image kLightClothesIcon = Image.asset('assets/icons/category/icons8-clothes-64.png',height: 25,color: kLightBlackColor,);
final Image kLightFurnitureIcon = Image.asset('assets/icons/category/icons8-furniture-64.png',height: 25,color: kLightBlackColor);
final Image kLightNewIcon = Image.asset('assets/icons/category/icons8-new-50.png',height: 25,color: kLightBlackColor);
final Image kLightShoesIcon = Image.asset('assets/icons/category/icons8-shoes-64.png',height: 35,color: kLightBlackColor);
final Image kLightWatchIcon = Image.asset('assets/icons/category/icons8-watches-front-view-64.png',height: 25,color: kLightBlackColor);
final Image kLightHatIcon =Image.asset('assets/icons/category/icons8-protective-glasses-30.png',height: 25,color: kLightBlackColor);
final Image kLightGlassesIcon =Image.asset('assets/icons/category/icons8-top-hat-30.png',height: 25,color: kLightBlackColor);

final Image kDarkClothesIcon = Image.asset('assets/icons/category/icons8-clothes-64.png',height: 25,color:kLightDarkBlueColor ,);
final Image kDarkFurnitureIcon = Image.asset('assets/icons/category/icons8-furniture-64.png',height: 25,color:kLightDarkBlueColor);
final Image kDarkNewIcon = Image.asset('assets/icons/category/icons8-new-50.png',height: 25,color:kLightDarkBlueColor);
final Image kDarkShoesIcon = Image.asset('assets/icons/category/icons8-shoes-64.png',height: 35,color:kLightDarkBlueColor);
final Image kDarkWatchIcon = Image.asset('assets/icons/category/icons8-watches-front-view-64.png',height: 25,color:kLightDarkBlueColor);
final Image kDarkHatIcon =Image.asset('assets/icons/category/icons8-protective-glasses-30.png',height: 25,color:kLightDarkBlueColor);
final Image kDarkGlassesIcon =Image.asset('assets/icons/category/icons8-top-hat-30.png',height: 25,color:kLightDarkBlueColor);

final List<Image> kHomeLightCategoryIcons = [kLightShoesIcon,kLightWatchIcon,kLightHatIcon,kLightGlassesIcon,kLightFurnitureIcon,kLightClothesIcon];
final List<Image> kHomeDarkCategoryIcons = [kDarkShoesIcon,kDarkWatchIcon,kDarkHatIcon,kDarkGlassesIcon,kDarkFurnitureIcon,kDarkClothesIcon];

//! cart
const IconData kAddIcon = Icons.add;
const IconData kRemoveIcon = Icons.remove;


// Icon kArrowIcon(BuildContext context,Color color) => isEnglish(context) ? Icon(Icons.arrow_back,color: color,) : Icon(Icons.arrow_back,color: color);
Icon kArrowIcon(BuildContext context,Color color) => Icon(Icons.arrow_back,color: color,) ;

const List<IconData> kAddContactsIcon = [
  Icons.person,
  Icons.email,
  Icons.boy_rounded,
  Icons.numbers,
  
];