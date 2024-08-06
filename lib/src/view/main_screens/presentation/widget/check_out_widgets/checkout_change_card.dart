import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/payment_card_bloc/payment_card_bloc.dart';


class CheckoutChangeCard extends StatefulWidget {
  final num total;
  const CheckoutChangeCard({super.key,required this.total});

  @override
  State<CheckoutChangeCard> createState() => _CheckoutChangeCardState();
}
class _CheckoutChangeCardState extends State<CheckoutChangeCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width:1.0,
        
      ),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  TextStyle lableStyle = theme(context).textTheme.titleMedium!.copyWith(color: theme(context).focusColor,fontSize: 14);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme(context).canvasColor,
          toolbarHeight: sizeH(context)*0.1,
          centerTitle: true,
          title: Text('Change card'.tr(),style: theme(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: theme(context).focusColor),),
          leading: IconButton(onPressed: ()=> context.navigationBack(context),icon:Icon(Icons.arrow_back,color: theme(context).primaryColor,),)),
        body: Container(
          color: theme(context).canvasColor,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                sizeBoxH(30),
                CreditCardWidget(
                  textStyle: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).backgroundColor),
                  glassmorphismConfig: Glassmorphism(
                                  blurX: 1.0,
                                  blurY: 1.0,
                                  gradient:  
                                  LinearGradient(
                                      begin:Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: <Color>[
                                        theme(context).primaryColor,
                                        theme(context).primaryColor,
                                        theme(context).colorScheme.secondary,
                                      ],
                                    ),
                                ),
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  frontCardBorder: Border.all(color: Colors.grey),
                  backCardBorder: Border.all(color: Colors.grey),
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.black45,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          inputConfiguration: InputConfiguration(
                            expiryDateDecoration: InputDecoration(
                              hintStyle: TextStyle(color: theme(context).focusColor),
                              labelStyle: lableStyle,
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Expired Date'.tr(),
                              hintText: 'XX/XX',
                            ),
                            cardHolderDecoration:  InputDecoration(
                              hintStyle: const TextStyle(color: Colors.black),
                              labelStyle: lableStyle,
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Card Holder'.tr(),
                            ),
                            cvvCodeDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.black),
                              labelStyle: lableStyle,
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'CVV',
                              hintText: '',
                            ),
                            cardNumberDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                              ),
                              labelText: 'Number'.tr(),
                              labelStyle: lableStyle,
                              focusedBorder: border,
                              enabledBorder: border,
                          ),
                          ),

                          // themeColor: theme(context).focusColor,
                          // textColor: theme(context).focusColor,
                          // cardNumberDecoration: 
                          // expiryDateDecoration: 
                          // cvvCodeDecoration: 
                          // cardHolderDecoration:
                          
                          onCreditCardModelChange: (creditCardModel) {
                            setState(() {
                              cardNumber = creditCardModel.cardNumber;
                              expiryDate = creditCardModel.expiryDate;
                              cardHolderName = creditCardModel.cardHolderName;
                              cvvCode = creditCardModel.cvvCode;
                              isCvvFocused = creditCardModel.isCvvFocused;
                            });
                          },
                        ),
                        sizeBoxH(sizeH(context)*0.1),
                        GestureDetector(
                          onTap: () {
                            PaymentCardEntity payMentModel = PaymentCardEntity(
                                number: cardNumber,
                                date:expiryDate,
                                cvv:cvvCode,
                                holder:cardHolderName,);
                            BlocProvider.of<PaymentCardBloc>(context).add(AddToPaymenctCardEvent(payMentModel));
                            context.navigationBack(context);
                            // context.navigation(context,CheckOutScreen(total: widget.total,activeStep: 1,));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient:  LinearGradient(
                                colors: <Color>[
                                  theme(context).primaryColor,
                                  theme(context).primaryColor,
                                  theme(context).primaryColor.withOpacity(0.7),
                                  ],
                                begin: const Alignment(-1, -4),
                                end: const Alignment(1, 4),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child:  Text(
                              'Validate'.tr(),
                              style:theme(context).textTheme.titleMedium!.copyWith(color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).focusColor : theme(context).backgroundColor,fontSize: 14)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

