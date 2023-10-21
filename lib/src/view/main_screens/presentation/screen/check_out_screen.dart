
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:im_stepper/stepper.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/top_snack_bar.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/payment_card_bloc/payment_card_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/success_payment_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/user_info_screen.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_continue_button.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_current_card.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_one_date_item.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_one_info_item.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_segment_title_widget.dart';

import '../../../../core/common/constans/texts.dart';
import '../../../../core/widget/error_bloc.dart';
import '../../domain/entities/payment_card_entity.dart';
import '../widget/check_out_widgets/checkout_change_card.dart';
import '../widget/check_out_widgets/checkout_empty_card.dart';

class CheckOutScreen extends StatefulWidget {
  num total;
  int? activeStep;
  CheckOutScreen({super.key,required this.total,this.activeStep});
  
  

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}
class _CheckOutScreenState extends State<CheckOutScreen> {

  late int activeStep;
  int upperBound = 1;

  int curretnValue = 0;
  PaymentCardEntity? dataForSend;
  bool dataForSendBool = true;

  int indexx = 0;

  @override
  void initState() {
    super.initState();
    activeStep = widget.activeStep ?? 0;
    BlocProvider.of<PaymentCardBloc>(context).add(InitialPaymentCardEvent());
    BlocProvider.of<BackendDbBloc>(context).add(InitialBackendDBEvent());
  }


  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isDark = BlocProvider.of<ThemeCubit>(context,listen: false).isDark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme(context).backgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(icon:Icon(Icons.arrow_back,color:theme(context).primaryColor,),onPressed:()=> context.navigationBack(context)),
          title: Text('Checkout'.tr(),style: theme(context).textTheme.displayMedium!.copyWith(fontSize: 22,color: theme(context).focusColor),),
        ),
        body: Container(
                    color: theme(context).backgroundColor,
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //* stepper
                          IconStepper(
                            activeStepBorderColor: theme(context).backgroundColor,
                            activeStepColor: theme(context).backgroundColor,
                            lineColor: theme(context).focusColor,
                            stepColor: theme(context).backgroundColor,
                            lineLength: sizeW(context) * 0.5,
                            stepReachedAnimationDuration:const Duration(seconds: 1),
                            stepReachedAnimationEffect: Curves.ease,
                            lineDotRadius: 1.8,
                            stepRadius: 24,
                            scrollingDisabled: false,
                            icons: [
                              Icon(Icons.location_on,
                                  color: activeStep == 0
                                      ? theme(context).primaryColor
                                      : theme(context).focusColor.withOpacity(0.6)),
                              Icon(Icons.payment,
                                  color: activeStep == 1
                                      ? theme(context).primaryColor
                                      : theme(context).focusColor.withOpacity(0.6)),
                            ],
                            enableNextPreviousButtons: false,
                            activeStep: activeStep,
                            onStepReached: (index) => setState(() {activeStep = index;})
                          ),
    
                          const Divider(),
    
                          activeStep == 0
                            //! first Screen
                            ? BlocConsumer<BackendDbBloc, BackendDbState>(
                               listener: (context, state) {
                                state is LoadingBackendDBState 
                                    ? LoadingDialogs.show(context)
                                    : LoadingDialogs.hide(context);
                              },
                              builder: (context, state) {
                              print('checkout ++++++++++ $state');
                              if (state is LoadingBackendDBState)return loading(context);
                              if (state is SuccessBackendDBState) {
                                  Map<String,dynamic> data = state.userInfoData;
                                  return Column(
                                    children: [
                                      //?info
                                      CheckoutSegmentTitleWidget(null,Icons.person, 'Information'.tr()),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: theme(context).canvasColor,
                                            borderRadius:BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 6,
                                                  color:isDark ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.5),offset:const Offset(0, 2))
                                            ]),
                                        width: sizeW(context) * 0.9,
                                        height: sizeH(context) * 0.29,
                                        child: Column(
                                          mainAxisAlignment:MainAxisAlignment.center,

                                          children: [
                                            //! if want to change info of user 
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: sizeW(context)*0.05,vertical: sizeH(context)*0.01),
                                              alignment: Alignment.topLeft,
                                              child: Tooltip(
                                                message:'for change information pleace dobule click on field'.tr(),
                                                textStyle: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).backgroundColor),
                                                decoration: BoxDecoration(
                                                    color: theme(context).primaryColor,
                                                    borderRadius:BorderRadius.circular(15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: theme(context)
                                                              .focusColor
                                                              .withOpacity(0.4),
                                                          blurRadius: 7)
                                                    ]),
                                                child:Icon(Icons.info_outline,color: theme(context).primaryColor,),
                                              ),
                                            ),
                                            
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              crossAxisAlignment:CrossAxisAlignment.center,
                                              children: [
                                                checkoutOneInfoItem(
                                                    context,
                                                    sizeW(context) * 0.39,
                                                    data['name'] ?? '',
                                                    'Name',
                                                    controller,
                                                    'name',
                                                    false,
                                                    widget.total
                                                    ),
                                                sizeBoxW( 10),
                                                checkoutOneInfoItem(
                                                    context,
                                                    sizeW(context) * 0.39,
                                                    data['family'] ?? '',
                                                    'Family',
                                                    controller,
                                                    'family',
                                                    false,
                                                    widget.total),
                                              ],
                                            ),
                                            sizeBoxH(20),
                                            checkoutOneInfoItem(
                                                context,
                                                sizeW(context) * 0.84,
                                                data['address'] ?? '',
                                                'Address',  
                                                controller,
                                                'address',
                                                 true,
                                                    widget.total),
                                          ],
                                        ),
                                      ),
                                      
                                      //? date
                                      CheckoutSegmentTitleWidget(null, Icons.date_range, 'Date'.tr()),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: theme(context).canvasColor,
                                            borderRadius:BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 6,
                                                  color:isDark ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.4),
                                                  offset:const Offset(0, 2))
                                            ]),
                                        width: sizeW(context) * 0.9,
                                        height: sizeH(context) * 0.12,
                                        child: Column(
                                          children: [
                                            sizeBoxH(sizeH(context)*0.02),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                CheckoutOneDateItem(
                                                   title: 'Date',
                                                   width: sizeH(context) * 0.2,
                                                   isHour: false),
                                                sizeBoxW(10),
                                                CheckoutOneDateItem(
                                                   title:'Hour',
                                                   width:sizeW(context) * 0.2,
                                                   isHour:true),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      //? button
                                      CheckoutContinueButton(
                                          total: widget.total,
                                          onpress: () {if (activeStep < upperBound) setState(() {activeStep++;});},
                                          marginFromTop: sizeH(context)*0.07,
                                          )
                                    ],
                                  );}
                              if (state is FailBackendDBState)return const ErrorBlocWidget();
                              return Container();
                            })

                            //! second Screen
                            : SingleChildScrollView(
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // * discount and card
                                    Container(
                                      width: sizeW(context) * 0.9,
                                      height: sizeH(context) * 0.5,
                                      decoration: BoxDecoration(
                                          color: theme(context).canvasColor,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 6,
                                                color:isDark ? theme(context).canvasColor:theme(context).focusColor.withOpacity(0.5),
                                                offset:const Offset(0, 2))
                                          ]),
                                      child: Column(
                                        children: [
                                          sizeBoxH(sizeH(context) * 0.01,),
                                          BlocBuilder<PaymentCardBloc, PaymentCardState>(
                                            builder: (context, state) {
                                              BlocProvider.of<PaymentCardBloc>(context).add(InitialPaymentCardEvent());
                                              if (state is LoadingPaymentCardState )return loading(context);
                                              if (state is SuccessPaymentCardState) {
                                                    List<PaymentCardEntity> data = state.data;

                                                    return data.isEmpty
                                                      ? CheckoutEmptyCard(total:widget.total,)
                                                      : SizedBox(
                                                        height: sizeH(context)*0.25,
                                                        child:ListView.builder(
                                                          itemCount: data.length,
                                                          scrollDirection: Axis.horizontal,
                                                          itemBuilder:(context, index) =>Stack(
                                                            children: [
                                                              GestureDetector(
                                                                onDoubleTap: () => context.read<PaymentCardBloc>().add(DeleteFromPaymenctCardEvent(index)),
                                                                child: CreditCardWidget(
                                                                  textStyle: theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).backgroundColor,fontSize: 18,),
                                                                  glassmorphismConfig: Glassmorphism(
                                                                    blurX: 0.0,
                                                                    blurY: 0.0,
                                                                    gradient: LinearGradient(
                                                                      colors: <Color>[
                                                                        theme(context).primaryColor,
                                                                        theme(context).primaryColor,
                                                                        theme(context).colorScheme.secondary,
                                                                        ],
                                                                      begin: const Alignment(-1, -4),
                                                                      end: const Alignment(1, 4),
                                                                    ),
                                                                  ),
                                                                  height: sizeH(context) * 0.3,
                                                                  width: sizeW(context)*0.75,
                                                                  chipColor: theme(context).primaryColorDark,
                                                                  cardNumber: data[index].number ?? '0000000000000000',
                                                                  expiryDate: data[index].date ?? '0000',
                                                                  cardHolderName: data[index].holder ?? '',
                                                                  cvvCode: data[index].cvv ?? '0000',
                                                                  showBackView: false,
                                                                  obscureCardNumber: true,
                                                                  obscureCardCvv: true,
                                                                  isHolderNameVisible: true,
                                                                  cardBgColor: theme(context).backgroundColor,
                                                                  isSwipeGestureEnabled: true,
                                                                  onCreditCardWidgetChange:(CreditCardBrand creditCardBrand) {},
                                                                ),
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets.only(
                                                                    left:isEnglish(context) ? sizeW(context)*0.66 : 0,
                                                                    right:isEnglish(context) ? 0 : sizeW(context)*0.66,
                                                                    top:sizeH(context)*0.18
                                                                  ),
                                                                  decoration: BoxDecoration(color: theme(context).backgroundColor,borderRadius: BorderRadius.circular(10)),
                                                                  width: sizeH(context) * 0.055,
                                                                  height: sizeH(context) * 0.045,
                                                                  child: IconButton(
                                                                      // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const CheckoutChangeCard())),
                                                                      onPressed: () => context.navigation(context, CheckoutChangeCard(total: widget.total,)),
                                                                      icon: Icon(Icons.add,color: theme(context).focusColor,)),
                                                                ),
                                                              InkWell(
                                                                onTap: (){
                                                                  setState(() {
                                                                    indexx = index;
                                                                    dataForSend = data[index];
                                                                    dataForSendBool = true;
                                                                  });
                                                                }, 
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: CircleAvatar(
                                                                    backgroundColor: indexx == index ? theme(context).primaryColor : theme(context).backgroundColor,
                                                                    radius: 17,
                                                                    child: CircleAvatar(
                                                                      radius: 15,
                                                                      backgroundColor: theme(context).backgroundColor,
                                                                      child: CircleAvatar(
                                                                        radius: 13,
                                                                        backgroundColor: indexx == index ? theme(context).primaryColor : theme(context).backgroundColor,
                                                                      ),
                                                                    ),
                                                                    ),
                                                                ))
                                                              // Padding(
                                                              //   padding: const EdgeInsets.all(10.0),
                                                              //   child: CircleAvatar(
                                                              //     radius: sizeW(context)*0.04,
                                                              //     backgroundColor: theme(context).backgroundColor,
                                                              //     child: Transform.scale(
                                                              //       scale: sizeW(context)*0.005,
                                                              //       child: Radio(
                                                              //         fillColor: dataForSendBool 
                                                              //           ? MaterialStateColor.resolveWith((states) => theme(context).colorScheme.secondary)
                                                              //           : MaterialStateColor.resolveWith((states) => theme(context).backgroundColor),
                                                              //         value: index, 
                                                              //         groupValue: curretnValue, 
                                                              //         onChanged: (value) {
                                                              //           setState(() {
                                                              //             curretnValue = value!;
                                                              //             dataForSendBool = true;
                                                              //             dataForSend = data[value];
                                                              //           });
                                                              //         },
                                                              //         ),
                                                              //     ),
                                                              //   ),
                                                              // )
                                                            ],
                                                          ))
                                                      );
                                              }
                                              if (state is FailPaymentCardState) return const ErrorBlocWidget();
                                              return Container();
                                            },
                                           ),
                                          
                                          const Spacer(),

                                          //? discount
                                          Padding(
                                            padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.03),
                                            child: Column(
                                              children:[
                                              CheckoutSegmentTitleWidget(null, Icons.discount, 'offer Code'.tr()),
                                              Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    FocusScope.of(context).unfocus();
                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                    if (controller.text == offer) {
                                                      setState(() {
                                                        widget.total = widget.total - 5;
                                                        showSnackBarOnTop(context,'Discount applied'.tr());
                                                      });} 
                                                    else {showSnackBarOnTop(context,'your code is wrong'.tr());}
                                                    controller.clear();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: theme(context).primaryColor,
                                                      elevation: 0,
                                                      minimumSize: Size(
                                                        sizeW(context) * 0.07,
                                                        sizeH(context) * 0.06,
                                                      ),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                                  child: const Icon(Icons.add),
                                                ),
                                                sizeBoxW(8),
                                                Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                                                  width: sizeW(context) * 0.65,
                                                  height: sizeH(context) * 0.062,
                                                  child: Center(
                                                    child: TextFormField(
                                                      style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: 13),
                                                      controller: controller,
                                                      maxLines: 1,
                                                      textInputAction: TextInputAction.done,
                                                      decoration: InputDecoration(
                                                          focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              borderSide: BorderSide.none),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              borderSide: BorderSide.none),
                                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                                          border: InputBorder.none,
                                                          fillColor: theme(context).dialogBackgroundColor,
                                                          filled: true,
                                                          hintText: 'your code...'.tr(),
                                                          hintStyle: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: 13)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ]),
                                          )
                                        ],
                                      ),
                                    ),
                                    sizeBoxH(sizeH(context) * 0.035,),

                                    // * button
                                    BlocBuilder<PaymentCardBloc,PaymentCardState>(
                                      builder: (context, state) {
                                        if(state is LoadingPaymentCardState)null;
                                        if(state is SuccessPaymentCardState){
                                        
                                        return CheckoutContinueButton(
                                          total: widget.total,
                                          onpress: () {
                                            state.data.isEmpty  
                                            ? showSnackBarOnTop(context,'Please add a card'.tr())
                                            : dataForSendBool 
                                              ? context.navigation(context,SuccessPaymentScreen(data: dataForSend!,))
                                              : showSnackBarOnTop(context,'Please select a card'.tr());
                                            },
                                            marginFromTop: sizeH(context)*0.1,
                                        );
                                        };
                                        if(state is FailPaymentCardState)null;
                                        return Container();
                                      }
                                    )
                                  ],
                                ),
                              ),
                          ),
                        ],
                      ),
                    ))
        ),
    );
  } 
  
      
}