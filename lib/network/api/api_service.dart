import 'package:flutter/foundation.dart';

const BASE_URL = kReleaseMode
    ? "https://api.wim-bms.com/apimimos/index.php"
    : "https://api.wim-bms.com/apimimos/index.php";

const BASE_URL_API = "$BASE_URL/api";

const URL_PULL_MATERIAL_PR = "$BASE_URL_API/Material/materialFL";
const URL_PULL_CUSTOMER_PR = "$BASE_URL_API/Customer/customerbyvisitday";
const URL_PULL_LOOKUP_PR = "$BASE_URL_API/Umum/lookup";
const URL_PULL_INTRODEAL_PR = "$BASE_URL_API/Material/introDealTFbyUseridbyTgl";
const URL_PULL_BRAND_COMPETITOR_PR = "$BASE_URL_API/Frontliner/brandcompetitor";
const URL_PULL_MATERIAL_PRICE_PR = "$BASE_URL_API/Material/hargamaterialTFbyUseridbytgl";
