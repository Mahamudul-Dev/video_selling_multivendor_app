// ignore_for_file: constant_identifier_names

const APP_NAME = 'MyCellVids';

// Facebook Developer Credentials
const FACEBOOK_APP_ID = "300818426154864";
const FACEBOOK_APP_CLIENT_ID = "fb300818426154864";
const FACEBOOK_CLIENT_TOKEN = "51f825d8ec719b40f44e1648ddb96d2c";



const String BASE_URL = 'http://203.161.62.117:5656';

// Authentication endpoints
const String REGISTER_API = '/api/v1/user/register';
const String LOGIN_API = '/api/v1/user/login';

// User profile endpoints
const String USER_API = '/api/v1/user/';
const String UPDATE_PROFILE_API = "/api/v1/user/update/";

// Products endpoints
const String SEARCH_PRODUCTS = '/api/v1/product/search?searchItem=';
const String PRODUCTS = '/api/v1/product/';
const String FILTER_PRODUCT = '/api/v1/product/allProducts?filter=';

// Cart Endpoints
const String CART = '/api/v1/cart/';
const String ADD_CART = '/api/v1/cart/addItemToCart';

// Favourite Endpoints
const String ADD_FAVOURITE_API = '/api/v1/favourite/addItemToFavourite'; // need to pass product id in body
const String FAVOURITE_API = '/api/v1/favourite/'; // can be use as delete & get favourite

// Wishlist Endpoints
const String WISHLIST_API = '/api/v1/wishlist/';
const String ADD_WISHLIST_API = '/api/v1/wishlist/addItemToWishlist';

