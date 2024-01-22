//! backend api
const String kBackendUri = 'https://cloud.appwrite.io/v1';
const String kBackendKey = '';

const String kBackendBucketId = '';

const String kBackendDatabaseId = '';
const String kBackendCollectionId ='';





//! onboarding

const String onboardingTitle1 = 'just in time!';
const String onboardingTitle2 = 'Easy Payment';
const String onboardingTitle3 = 'The most diverse';
const String onboardingsubTitle1 ='Right now you can see amazing offers and discounts and make an easier choice';
const String onboardingsubTitle2 ='With the possibility of online payment, you can save time and make your purchases very easily';
const String onboardingsubTitle3 ='A store with the most variety of clothes so that you can find anything you want. Dont you believe it?';
const List<String> onboardingTitles = [
  onboardingTitle1,
  onboardingTitle2,
  onboardingTitle3
];
const List<String> onboardingsubTitles = [
  onboardingsubTitle1,
  onboardingsubTitle2,
  onboardingsubTitle3
];

//! auth
const String kAuthMainTitle = 'Sossis';
const String kAuthLoginTitle = 'Welcome Back';
const String kAuthSignupTitle = 'Get Started now';
const String kAuthLoginSubtitle = 'Enter your Details below';
const String kAuthSignUpSubtitle = 'with an account manage your shopping';
const String kAuthEmail = 'Email Address';
const String kAuthPassword = 'Password';
const String kAuthSignup = 'Sign up';
const String kAuthLogin = 'Login';
const String kAuthForgotPassword = 'Forgot your password?';
const String kAuthLoginFoother = 'Dont have an account?';
const String kAuthSignUPFoother = 'Already have account?';
const String kAuthLoginFootherButton = 'Get Started';

//! api
const String apiUri = 'https://m8mamad2.iran.liara.run/api/';
const String kproducts = 'products';
const String kcloths = 'cloths';
const String kfurniture = 'furniture';
const String kglass = 'glass';
const String khat = 'hat';
const String kshoes = 'shoes';
const String kwatch = 'watch';

//! category
const List<String> kCategoryText = [
  'shoes',
  'watch',
  'hat',
  'glasses',
  'furniture',
  'clothes',
];
const List<String> kCategoryEndPoint = [
  kshoes,
  kwatch,
  khat,
  kglass,
  kfurniture,
  kcloths
];


//! profile
const List<String> kProfileTitle =['Favorite',
// 'Chat',
'edit Profile','Language'];
const List<String> kDrawerTitle = ['Profile','Search','Favorite',
// 'need more help?',
'Contacts','Send Error','Rate us'];


//! home categoty
const List<String> kHomeCategoryTitle = ['shoes','watch','hat','glasses','furniture','clothes',];
const List<String> kHomeCategoryEndPoints = [kshoes,kwatch,khat,kglass,kfurniture,kcloths];

const String offer = '1010';

//! user info
const List<String> kUserUpdateValue =['name','family','address','phoneNumber','homeNumber'];
const List<String> kUserInfoGetValue =['name','family','address','phoneNumber','homeNumber',];
const List<String> kUserInfoTitle =['Name','Family','Address','Phone Number','Home Number',];

//! contacts

const List<String> contactsTitle = ['name','email','age','number',];
const List<String> kValidatorType =['name','email','age','number',];

const List<String> kErrorBloc = [
  'check your connection to Internet',
  'close the app and open it again',
  'The problem could be from the server side',
  'please try again later'
  ];
