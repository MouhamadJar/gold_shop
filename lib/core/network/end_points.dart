import '../storage_handler/storage_handler.dart';

class EndPoints {
 // visitor
 static String aboutUs = '/api/policy/about';
 static String privacy = '/api/policy/privacy';
 static String getAllCategories = '/api/categories';
 static String getAllSubCategories = '/api/categories/sub/';
 static String categoryADVS = '/api/advertisements/';
 static String subCategoryADVS = '/api/advertisements/sub/';
 static String allProducts = '/api/products/all/';
 static String productByCity = '/api/products/city/';
 static String sort = '/api/products/search/sort';
 static String filter = '/api/products/search/filter';
 static String getCity = '/api/address/city';

 //---------------------------------------------------------------------------------------------------
 //app user

 //app auth
 static String login = '/api/user/login';
 static String register = '/api/user/register';
 static String logout = '/api/user/logout';

 //app products

//app products discounts
 static String discountStore = '/api/app/discounts/13';
 static String discountUpdate = '/api/app/discounts/update/11';
 static String discountDelete = '/api/app/discounts/11';

//stores
 static String storesIndex = '/api/app/stores';
 static String storeIndexCity = '/api/app/stores?city=mazeh';


 static String store = '/api/app/products';
 static String restoreOrResell = '/api/app/products/restore/14';
 static String show = '/api/app/products/';
 static String update = '/api/app/products/14';
 static String delete = '/api/app/products/13';

//app problems
 static String problemStore = '/api/app/problems';

//app profile
static String updateProfile = '/api/app/profile/${StorageHandler().userId}';
static String showProfile = '/api/app/profile/${StorageHandler().userId}';
static String deleteAccount = '/api/app/profile/174';

//app contact us
static String contactUsStore = '/api/app/contact';

//app orders
static String onHold = '/api/app/orders/on/hold/14';
static String sale = '/api/app/orders/sale/14';

//app profile lists
static String profileListsSalesOnHold = '/api/app/lists/sales/on/hold';
static String profileListsPurchasesOnHold = '/api/app/lists/purchases/on/hold';
static String profileListsMyProducts = '/api/app/lists/my/products';
static String profileListsSalesReservations = '/api/app/lists/sales/reserved';
static String profileListsReservedPurchases = '/api/app/lists/purchases/reserved';
static String profileListsSales = '/api/app/lists/sales';
static String profileListsPurchases = '/api/app/lists/my/purchases';
static String profileListsShowProduct = '/api/app/products/list/14';
static String profileSalesList = '/api/app/lists/profile/sales';
static String profilePurchasesList = '/api/app/lists/profile/my/purchases';
static String profileMyProductsList = '/api/app/lists/profile/my/products';

//app sort & filter my product
static String sortMyProduct = '/api/app/lists/search/sort?created_at=1&list_type=0';
static String filterMyProduct = '/api/app/lists/search/filter?category_id=1&subcategory_id=2&from_price=20000&to_price=800000&list_type=0';

//app sort & filter purchases
static String sortPurchases = '/api/app/lists/search/sort/purchases?created_at=0&list_type=1';
static String filterPurchases = '/api/app/lists/search/filter/purchases?category_id=1&subcategory_id=2&from_price=2000&to_price=800000&list_type=0';

//app sort & filter sales
static String sortSales = '/api/app/lists/search/sort/sales?price=1&list_type=0';
static String filterSales = '/api/app/lists/search/filter/sales?category_id=1&subcategory_id=2&from_created_at=2023-12-05&to_created_at=2024-12-12&list_type=0';

//app rate
static String rateByBuyer ='/api/app/rate/buyer/14';
static String rateBySeller ='/api/app/rate/seller/14';

//-------------------------------------------------------------------------------------------------------
//app store

//app Store auth
static String storeLogin= '/api/store/login';
static String storeSignup= '/api/store/register';
static String storeLogout= '/api/app/store/logout';

//app store profile
static String updateStoreProfile='/api/app/store/profile/1';
static String showStoreProfile='/api/app/store/profile/1';
static String deleteStoreAccount='/api/app/store/profile/58';

//app store contact us
static String storeContactUs ='/api/app/store/contact';

//app store his service
static String hisServiceShowProduct= '/api/app/store/product/show?code=vm15';
static String hisServiceCheck= '/api/app/store/order/15';
}