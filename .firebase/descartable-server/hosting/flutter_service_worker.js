'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "11752094152058cda32519178e4deb42",
"assets/AssetManifest.json": "9f82771551a2d80a065175d24eb793d9",
"assets/assets/fonts/Montserrat-Regular.ttf": "ee6539921d713482b8ccd4d0d23961bb",
"assets/assets/fonts/Nunito-Bold.ttf": "c0844c990ecaaeb9f124758d38df4f3f",
"assets/assets/fonts/Nunito-Regular.ttf": "d8de52e6c5df1a987ef6b9126a70cfcc",
"assets/assets/fonts/Nunito-SemiBold.ttf": "876701bc4fbf6166f07f152691b15159",
"assets/assets/fonts/Poppins-Medium.ttf": "f61a4eb27371b7453bf5b12ab3648b9e",
"assets/assets/fonts/Poppins-Regular.ttf": "8b6af8e5e8324edfd77af8b3b35d7f9c",
"assets/assets/fonts/poppins_semibold.ttf": "f018d93c4bd9b0bbdfb82ae61ebf8da4",
"assets/assets/fonts/TitilliumWeb-SemiBold.ttf": "ce96d75e97d58b7396e1431557bb02a0",
"assets/assets/image/comman/appLogo.svg": "7a010fefb5ff75fdcea9ba71adda7475",
"assets/assets/image/comman/bg.svg": "13933ff893e8e66e55536b548bc6fee1",
"assets/assets/image/comman/bg1.png": "dbdcd0901e05e9e648b196dd64b222ba",
"assets/assets/image/comman/changePasswordBenner.svg": "0f4332ccd7e7c1ad7d6bde4fe97482a3",
"assets/assets/image/comman/drawerIcon.svg": "e192f7d5022b9ee3758307c43565d3f5",
"assets/assets/image/comman/Frame%252058.svg": "bd6cfef4e53e26ea2dd0d8db7329c7e0",
"assets/assets/image/comman/personImage.png": "f0c5673a117e519d77e97d39b8b63a58",
"assets/assets/image/comman/phoneVerifyBenner.png": "244af9dc97d2cfbcfedbd73ab498c0d5",
"assets/assets/image/comman/profilePic.png": "26a7494082565e91969bd124d23ccf5b",
"assets/assets/image/comman/securityBenner.svg": "615a80bf45a2441838e6cd74249f4b0a",
"assets/assets/image/comman/smartphone.svg": "459168c7d5b57f6cba7746b25dc84e84",
"assets/assets/image/comman/wellDoneBenner.svg": "03027132f1a0dbafe663a38ff5bb6abc",
"assets/assets/image/drawer/bell.svg": "8f3f71b2c9c39ca281c479ee12ebe9fe",
"assets/assets/image/drawer/calculator.svg": "b87745ac70576616fb6c9ad721b72c84",
"assets/assets/image/drawer/gold.svg": "ccecf19893ed8ae95401e57b61717d30",
"assets/assets/image/drawer/homeIcon.svg": "7394c3fcb4917e13c5cab3899b5d4b92",
"assets/assets/image/drawer/ipo.svg": "b1c36e2f5d9a74345377fe0168e75fbf",
"assets/assets/image/drawer/logOut.svg": "e77b22111487c15dbb83cecc8f1415ac",
"assets/assets/image/drawer/matualFund.svg": "e0d56edf4895a789e48000fa2c9dcd2e",
"assets/assets/image/drawer/research.svg": "4d6646ffab9f8955c37efc9a2740f7e4",
"assets/assets/image/forget_password/arrowremove.svg": "c72dfda0420288931ade9b7cb48d570a",
"assets/assets/image/home/2arrow.svg": "64781c240c7b1ae83cd7ee1dc5fd22f0",
"assets/assets/image/home/A-Z.svg": "5551e769baf0d0649e28821d56cb4793",
"assets/assets/image/home/arrowDownRight.svg": "57bc03525c1d87055198f25295969997",
"assets/assets/image/home/AXISBANK.png": "88933d0a43fc55d08d5713001826d7a6",
"assets/assets/image/home/bellhome.svg": "5ffd2a02458b2b82fbb5ed30f6b584a2",
"assets/assets/image/home/downIcon.svg": "f82cdbcebf75c218f5af2d58f1d8c1a9",
"assets/assets/image/home/fund.svg": "f2f17c909f5f48c4a2237ff950bf4edf",
"assets/assets/image/home/graph1.svg": "d1678f414cc439fff11dd7b87eafb361",
"assets/assets/image/home/graph1Dark.svg": "4ec71db8d76b8c29a9145ce88b0cd8d9",
"assets/assets/image/home/graph2.svg": "7f76e8cf6bd4a764dd86b04495c5b396",
"assets/assets/image/home/graph2Light.svg": "fd2b85f22c32b9a425c0515b244c3663",
"assets/assets/image/home/graph3.svg": "4efc254a7f9d3dc37eac44d87fc041ff",
"assets/assets/image/home/HDFCBANK.png": "92005223e9159bab1cb1cd2a72c43adc",
"assets/assets/image/home/ICICIBANK.png": "a7ea0b92b20af59a977f65ad4a82887f",
"assets/assets/image/home/oders.svg": "a0e91eb731e8bbe525cd29d6a030d325",
"assets/assets/image/home/PARLE.png": "374bce0bf9eb5c89449001d96e9687a2",
"assets/assets/image/home/portFolio.svg": "c3baeff7cb502d19b1d95dc19db8349c",
"assets/assets/image/home/RELIANCE.png": "8951107c94ddb5245a46ad2f98a4cf3f",
"assets/assets/image/home/rupee.svg": "eb4306f235b34f33f347152e8d8852b9",
"assets/assets/image/home/sort.svg": "ed5f0b538e051e5628172ba69a4bb140",
"assets/assets/image/home/Sunpharma.png": "4e2a92acd3b6c6d80ec2c6e1800d86d7",
"assets/assets/image/home/user.svg": "10cf0249c69e5c2ee4ca0a6160853fd1",
"assets/assets/image/home/watchList.svg": "338475a5b07141d60e7f556babe60837",
"assets/assets/image/home/YESBANK.png": "06120807aca7c6421e78b406dacb1059",
"assets/assets/image/login/forgetPinBenner.svg": "0ee283803c71912999b964b678d1f209",
"assets/assets/image/login/lockicon.svg": "905968f8d5070c954da889f84d36d129",
"assets/assets/image/login/loginBenner.svg": "376739c84a0ea1b0cf88e44e4e9c7897",
"assets/assets/image/notification/stockDown.svg": "bdd3a521710ca2962d0d126e912696e3",
"assets/assets/image/notification/stockUp.svg": "7990bfa2b3fba1330018696d8071b5e6",
"assets/assets/image/order/benner1oderscreen.svg": "bbca4028ef9777c6d6228081e9d2f809",
"assets/assets/image/signup/signUPBenner.svg": "702a6df3269202df622271973ba49b63",
"assets/assets/image/signup/user.svg": "9d6bd1c5e07a8c13c3774211efbcc631",
"assets/FontManifest.json": "802feab92fff0ebb4c9fc198db832250",
"assets/fonts/MaterialIcons-Regular.otf": "c5674a2d51ffda712fadccb50e8ac619",
"assets/NOTICES": "48c40503c03d590fbfbbfc6fadfc8061",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "93f0abd5663e1678835625f272f2a358",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "a988e1ef98a9f35912646f02d898bf7f",
"/": "a988e1ef98a9f35912646f02d898bf7f",
"main.dart.js": "f9f69bfa5978fa1c31c6a4a85ad36304",
"manifest.json": "c6d8fa55d7120eca942f9ad2f0135e87",
"version.json": "82dcf16740eaf51996ad34c83233ca44"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
