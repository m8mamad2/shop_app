// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:project3/src/config/localization/is_english.dart';
// import 'package:project3/src/config/theme/theme.dart';
// import 'package:project3/src/core/extension/navigae_extension.dart';
// import 'package:project3/src/core/widget/loading.dart';
// import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';
// import 'package:project3/src/view/main_screens/presentation/blocs/payment_card_bloc/payment_card_bloc.dart';
// import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_empty_card.dart';

// import '../../../../../config/theme/cubit_changer/theme_cubit.dart';
// import '../../../../../core/common/constans/size.dart';
// import 'checkout_change_card.dart';


// class CheckoutCurrentCard extends StatefulWidget {
//   final num total;
//   const CheckoutCurrentCard({super.key,required this.total});

//   @override
//   State<CheckoutCurrentCard> createState() => _CheckoutCurrentCardState();
// }

// class _CheckoutCurrentCardState extends State<CheckoutCurrentCard> {
//   int curretnValue = 0;
//   late PaymentCardEntity dataForSend;

//   @override
//   void initState() {
//     BlocProvider.of<PaymentCardBloc>(context).add(InitialPaymentCardEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//       return BlocBuilder<PaymentCardBloc, PaymentCardState>(
//       builder: (context, state) {
//         BlocProvider.of<PaymentCardBloc>(context).add(InitialPaymentCardEvent());
//         if (state is LoadingPaymentCardState )return loading(context);
//         if (state is SuccessPaymentCardState) {
//               List<PaymentCardEntity> data = state.data;

//               return data.isEmpty
//                 ? CheckoutEmptyCard(total:widget.total ,)
//                 : SizedBox(
//                   height: sizeH(context)*0.25,
//                   child:ListView.builder(
//                     itemCount: data.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder:(context, index) =>Dismissible(
//                       direction: DismissDirection.vertical,
//                       background:  Padding(
//                                   padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                                     alignment: isEnglish(context)? Alignment.centerLeft: Alignment.centerRight,
//                                     decoration: BoxDecoration(color:theme(context).primaryColor,borderRadius: BorderRadius.circular(20)),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             Icon(Icons.delete,color: theme(context).backgroundColor,),
//                                             const Spacer(),
//                                             Icon(Icons.delete,color: theme(context).backgroundColor),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ),
//                                 ),
//                       key: UniqueKey(),
//                       onDismissed: (direction) => BlocProvider.of<PaymentCardBloc>(context).add(DeleteFromPaymenctCardEvent(index)),
//                       child: 
//                       Stack(
//                         children: [
//                           CreditCardWidget(
//                             textStyle: theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).backgroundColor,fontSize: 18,),
//                             glassmorphismConfig: Glassmorphism(
//                               blurX: 0.0,
//                               blurY: 0.0,
//                               gradient: LinearGradient(
//                                 colors: <Color>[
//                                   theme(context).primaryColor,
//                                   theme(context).primaryColor,
//                                   theme(context).colorScheme.secondary,
//                                   ],
//                                 begin: const Alignment(-1, -4),
//                                 end: const Alignment(1, 4),
//                               ),
//                             ),
//                             height: sizeH(context) * 0.3,
//                             width: sizeW(context)*0.75,
//                             chipColor: theme(context).primaryColorDark,
//                             cardNumber: data[index].number ?? '0000000000000000',
//                             expiryDate: data[index].date ?? '0000',
//                             cardHolderName: data[index].holder ?? '',
//                             cvvCode: data[index].cvv ?? '0000',
//                             showBackView: false,
//                             obscureCardNumber: true,
//                             obscureCardCvv: true,
//                             isHolderNameVisible: true,
//                             cardBgColor: theme(context).backgroundColor,
//                             isSwipeGestureEnabled: true,
//                             onCreditCardWidgetChange:(CreditCardBrand creditCardBrand) {},
//                           ),
//                           Container(
//                               margin: EdgeInsets.only(
//                                 left:isEnglish(context) ? sizeW(context)*0.66 : 0,
//                                 right:isEnglish(context) ? 0 : sizeW(context)*0.66,
//                                 top:sizeH(context)*0.18
//                               ),
//                               decoration: BoxDecoration(color: theme(context).backgroundColor,borderRadius: BorderRadius.circular(10)),
//                               width: sizeH(context) * 0.055,
//                               height: sizeH(context) * 0.045,
//                               child: IconButton(
//                                   // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const CheckoutChangeCard())),
//                                   onPressed: () => context.navigation(context, CheckoutChangeCard(total: widget.total,)),
//                                   icon: Icon(Icons.add,color: theme(context).focusColor,)),
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: CircleAvatar(
//                               radius: sizeW(context)*0.04,
//                               backgroundColor: theme(context).backgroundColor,
//                               child: Radio(
//                                 fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
//                                 focusColor: Colors.orange,
//                                 value: index, 
//                                 groupValue: curretnValue, 
//                                 onChanged: (value) {
//                                   setState(() {
//                                     curretnValue = value!;
//                                     dataForSend = data[value];
//                                   });
//                                 },
//                                 ),
//                             ),
//                           )
//                         ],
//                       )
                      


//                       ))
//                 );
//         }
//         if (state is FailPaymentCardState) return Text(state.error.toString());
//         return Container();
//       },
//     );
  
//   }
// }
