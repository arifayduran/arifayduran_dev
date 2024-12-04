'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "f393d3c16b631f36852323de8e583132",
"main.dart.js": "dcabda17901bd1c8f82ef0deea815120",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin": "b0076c0e3d6e53ddc4910f976c0b9af4",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/assets/images/business_smile_retuschiert_farbenangepasst.jpg": "1e79e5e57c912827f184331980551da5",
"assets/assets/animations/darklight-switch.riv": "2f753c90c79a6887a77d53d6530ec40f",
"assets/assets/animations/scroll_down_black.json": "1eea70dd40fd4e6f2c09434ed02f80ea",
"assets/assets/animations/scroll_down_white.json": "25de994969a0675b28dec8fbe38b9fb6",
"assets/assets/app_icons/tinted_android.png": "b1e2facfe6e5844e5c02d7b4c9547fdf",
"assets/assets/app_icons/android_foreground.svg": "28bdcce25fe1a4cacc88d2e9e9b41d70",
"assets/assets/app_icons/dark_transparent.png": "191ee049456b239327d8d98b87f0dc66",
"assets/assets/app_icons/android_background.png": "0f7b90303f2b50395e96e17d74d4a084",
"assets/assets/app_icons/tinted_ios_black.svg": "904f24cb96e841ed5ce3a56bf4ae39d5",
"assets/assets/app_icons/tinted_ios_black.png": "4a0d715065bd0938d1e8ff307ec4ef8e",
"assets/assets/app_icons/dark_transparent.svg": "ff5bb90a58ad9b21d9ef6f79d27f3ea6",
"assets/assets/app_icons/tinted_android.svg": "f0749dc2df8d46a6ff8137c63aeed4f1",
"assets/assets/app_icons/light_transparent.png": "69aee87c9dcf4a300f9ae470c9d7050a",
"assets/assets/app_icons/android_foreground.png": "cb83ed52935fc326e2138673179d236d",
"assets/assets/app_icons/main_light.png": "11b42074c3dd809a0df435ebf82df0b6",
"assets/assets/app_icons/android_background.svg": "79f912b5d34f144225ec4ee03c7a1462",
"assets/assets/app_icons/main_dark.png": "0b725eb2d3f43b562942e0723625ede1",
"assets/assets/app_icons/light_transparent.svg": "d1b94aedcbd435c867f5e9b7e45dce25",
"assets/assets/app_icons/main_dark.svg": "ea33339af268a3b5febafd6e1323e9eb",
"assets/assets/app_icons/main_light.svg": "403a1579d07654352304195e2df36f20",
"assets/NOTICES": "55b97db3795a501b7e0cb20ce08250dc",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "69da3713e4bd9c6f6480c28cc2901e22",
"assets/AssetManifest.bin.json": "0f630ea18172480b9ba29f3bbb9a1e01",
"index.html": "da96973a9cce17da1f2810ee08955ecb",
"/": "da96973a9cce17da1f2810ee08955ecb",
"manifest.json": "a5da8edc7feb2a0b15c25437c9614317",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"icons/Icon-maskable-192.png": "a52fb998656f987365cd2bf181bbac96",
"icons/Icon-192.png": "a52fb998656f987365cd2bf181bbac96",
"icons/Icon-512.png": "3007b13a79e79720d6729e4c667d8437",
"icons/Icon-maskable-512.png": "3007b13a79e79720d6729e4c667d8437",
"favicon.png": "10b90dd4b4d105d71eb2413b1a6ef982",
"version.json": "77cd2155404ad6929195a1ce50071277",
"flutter_bootstrap.js": "20d85195794bfa969b78b4150847f984"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
