// Self-unregistering service worker.
//
// Earlier deploys shipped Flutter's generated offline-first service worker, so
// every browser that has opened this app still has one registered. The build
// now runs with --pwa-strategy=none, which generates no service worker at all
// — and a registered worker does not disappear just because the server stopped
// shipping one. It keeps intercepting fetches and serving its own cache, so
// operators would go on seeing the old app no matter how many times we deploy.
//
// This file occupies the same URL the old worker lives at. Browsers re-fetch
// the worker script on navigation and byte-compare it, so the next visit
// installs this one, which then tears itself down and drops every cache it
// finds. After that the app is served straight from the network.
//
// Keep this file until the fleet has cycled through at least one visit. It is
// idempotent and harmless to leave in place.

self.addEventListener('install', function (event) {
  // Take over from the outgoing worker immediately rather than waiting for
  // every tab holding the old one to close.
  event.waitUntil(self.skipWaiting());
});

self.addEventListener('activate', function (event) {
  event.waitUntil(
    (async function () {
      try {
        const names = await caches.keys();
        await Promise.all(names.map(function (n) { return caches.delete(n); }));
      } catch (e) {
        // A failed cache purge must not block the unregister below.
      }

      try {
        await self.registration.unregister();
      } catch (e) {
        // Nothing useful to do; the next navigation retries.
      }

      // Reload open tabs so they pick up the network copy in this visit
      // instead of the next one.
      try {
        const clients = await self.clients.matchAll({ type: 'window' });
        for (const client of clients) {
          client.navigate(client.url);
        }
      } catch (e) {
        // Navigation is best-effort.
      }
    })()
  );
});

// While this worker is alive it must never answer from cache.
self.addEventListener('fetch', function (event) {
  event.respondWith(fetch(event.request));
});
