import '../storage_handler/storage_handler.dart';

class EndPoints {
  // visitor
  static String aboutUs = '/api/policy/about';
  static String privacy = '/api/policy/privacy';
  static String getAllCategories = '/api/categories';
  static String getAllSubCategories = '/api/categories/sub/';
  static String homeADVS = '/api/advertisements/home';
  static String categoryADVS = '/api/advertisements/';
  static String subCategoryADVS = '/api/advertisements/sub/';
  static String allProducts = '/api/products/all/';
  static String productByCity = '/api/products/city/';
  static String sort = '/api/products/search/sort';
  static String sorts({int? carat,int?price,int? weight})  {
    //all not null
    if (carat!=null&& price!= null && weight != null){
      return '/api/products/search/sort?carat=$carat&price=$price&wight=$weight';
    }

    //two not null
    else if(carat!=null && price!= null && weight == null){
      return '/api/products/search/sort?carat=$carat&price=$price';
    }
    else if(carat!=null && price == null && weight != null){
      return '/api/products/search/sort?carat=$carat&wight=$weight';
    }
    else if (carat==null && price!= null && weight != null){
      return '/api/products/search/sort?price=$price&wight=$weight';
    }

    //one not null
    else if (carat==null && price== null && weight != null){
      return '/api/products/search/sort?wight=$weight';
    }
    else if (carat==null && price!= null && weight == null){
      return '/api/products/search/sort?price=$price';
    }
    else if (carat!=null && price== null && weight == null){
      return '/api/products/search/sort?carat=$carat';
    }

    //all null
    return '';
  }
  static String filter = '/api/products/search/filter';
  static String getCity = '/api/address/city';
  static String getCaratPrices = '/api/bursa/gold/carat';
  static String getAllCaratPrices = '/api/bursa/gold/all/carat';
  static String oneCaratPrice = '/api/bursa/gold/one/carat?carat=18k';

  //---------------------------------------------------------------------------------------------------
  //app user

  //app auth
  static String login = '/api/user/login';
  static String loginMediatorShop = '/api/store/login';
  static String register = '/api/user/register';
  static String registerStore = '/api/store/register';
  static String logout = '/api/user/logout';

  //app products

//app products discounts
  static String discountStore = '/api/app/discounts/13';
  static String discountUpdate = '/api/app/discounts/update/11';
  static String discountDelete = '/api/app/discounts/11';
  static String appCommission = '/api/app/details/commission';

//stores
  static String storesIndex = '/api/app/stores';
  static String storeIndexCity = '/api/app/stores?city=mazeh';

  static String store = '/api/app/products';
  static String restoreOrResell = '/api/app/products/restore/14';
  static String show = '/api/app/products/';
  static String update = '/api/app/products/14';
  static String delete = '/api/app/products/';

//app problems
  static String problemStore = '/api/app/problems';
  static String problemTypes = '$problemStore/type';

//app profile
  static String updateProfile = '/api/app/profile/${StorageHandler().userId}';
  static String showProfile = '/api/app/profile/${StorageHandler().userId}';
  static String deleteAccount = '/api/app/profile/174';

//app contact us
  static String contactUsStore = '/api/app/contact';

//app orders
  static String onHold = '/api/app/orders/on/hold/';
  static String sale = '/api/app/orders/sale/14';
  static String paymentInfo = '/api/app/details/payment';
  static String bankInfo = '/api/app/details/bank';
  static String notificationImage = '/api/app/orders/horror/image/';

  //reports

  static String invoice = '/api/app/reports/bill/';

//app profile lists
  static String profileListsSalesOnHold = '/api/app/lists/sales/on/hold';
  static String profileListsPurchasesOnHold =
      '/api/app/lists/purchases/on/hold';
  static String profileListsMyProducts = '/api/app/lists/my/products';
  static String profileListsSalesReservations = '/api/app/lists/sales/reserved';
  static String profileListsReservedPurchases =
      '/api/app/lists/purchases/reserved';
  static String profileListsSales = '/api/app/lists/sales';
  static String profileListsPurchases = '/api/app/lists/my/purchases';
  static String profileListsShowProduct = '/api/app/products/list/';
  static String profileSalesList = '/api/app/lists/profile/sales';
  static String profilePurchasesList = '/api/app/lists/profile/my/purchases';
  static String profileMyProductsList = '/api/app/lists/profile/my/products';

//app sort & filter my product
  static String sortMyProductByPrice(int val) =>
      '/api/app/lists/search/sort?price=$val&list_type=0';

  static String sortMyProductByDate(int val) =>
      '/api/app/lists/search/sort?created_at=$val&list_type=0';

  static String filterMyProductByPrice(
          String subcategoryId, String categoryId, String from, String to) =>
      '/api/app/lists/search/filter?category_id=$categoryId&subcategory_id=$subcategoryId&from_price=$from&to_price=$to&list_type=0';

  static String filterMyProductByDate(
          String subcategoryId, String categoryId, String from, String to) =>
      '/api/app/lists/search/filter?category_id=$categoryId&subcategory_id=$subcategoryId&from_created_at=$from&to_created_at=$to&list_type=0';

//app sort & filter purchases
  static String sortMyPurchasesByPrice(int val) =>
      '/api/app/lists/search/sort/purchases?price=$val&list_type=0';

  static String sortMyPurchasesByDate(int val) =>
      '/api/app/lists/search/sort/purchases?created_at=$val&list_type=0';

  static String filterMyPurchaseByPrice(
      String subcategoryId, String categoryId, String from, String to) =>
      '/api/app/lists/search/filter/purchases?category_id=$categoryId&subcategory_id=$subcategoryId&from_price=$from&to_price=$to&list_type=0';

  static String filterMyPurchasesByDate(
      String subcategoryId, String categoryId, String from, String to) =>
      '/api/app/lists/search/filter/purchases?category_id=$categoryId&subcategory_id=$subcategoryId&from_created_at=$from&to_created_at=$to&list_type=0';

//app sort & filter sales
  static String sortMySellsByPrice(int val) =>
      '/api/app/lists/search/sort/sales?price=$val&list_type=0';

  static String sortMySellsByDate(int val) =>
      '/api/app/lists/search/sort/sales?created_at=$val&list_type=0';

  static String filterMySellsByPrice(
      String subcategoryId, String categoryId, String from, String to) =>
      '/api/app/lists/search/filter/sales?category_id=$categoryId&subcategory_id=$subcategoryId&from_price=$from&to_price=$to&list_type=0';

  static String filterMySellsByDate(
      String subcategoryId, String categoryId, String from, String to) =>
      '/api/app/lists/search/filter/sales?category_id=$categoryId&subcategory_id=$subcategoryId&from_created_at=$from&to_created_at=$to&list_type=0';

//app rate
  static String rateByBuyer = '/api/app/rate/buyer/';
  static String rateBySeller = '/api/app/rate/seller/';

//-------------------------------------------------------------------------------------------------------
//app store

//app Store auth
  static String storeLogin = '/api/store/login';
  static String storeSignup = '/api/store/register';
  static String storeLogout = '/api/app/store/logout';

//app store profile
  static String updateStoreProfile = '/api/app/store/profile/1';
  static String showStoreProfile = '/api/app/store/profile/1';
  static String deleteStoreAccount = '/api/app/store/profile/58';

//app store contact us
  static String storeContactUs = '/api/app/store/contact';

//app store his service
  static String hisServiceShowProduct = '/api/app/store/product/show?code=vm15';
  static String hisServiceCheck = '/api/app/store/order/15';

// app signature
  static String uploadSignature = '/api/app/store/signature';

}
