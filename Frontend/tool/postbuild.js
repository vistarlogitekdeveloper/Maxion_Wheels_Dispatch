// Post-build step for the web bundle.
//
//   node tool/postbuild.js
//
// Runs after `flutter build web`. Right now it installs the service-worker
// kill-switch, which cannot live in web/ because `flutter build` writes its
// own (empty, under --pwa-strategy=none) file to that exact path and would
// clobber ours.
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const out = path.join(root, 'build', 'web');

if (!fs.existsSync(out)) {
  console.error('postbuild: build/web not found — run the flutter build first');
  process.exit(1);
}

// --- service-worker kill-switch -------------------------------------------
// Earlier deploys shipped Flutter's offline-first worker, so browsers in the
// field still have one registered. --pwa-strategy=none emits a 0-byte file:
// that does replace the old worker, but it never calls skipWaiting() and never
// purges the old caches, so tabs already open keep being served stale assets.
// Overwrite it with a worker that actively tears itself down.
const src = path.join(__dirname, 'sw_killswitch.js');
const dest = path.join(out, 'flutter_service_worker.js');

const body = fs.readFileSync(src);
fs.writeFileSync(dest, body);
console.log(
  `postbuild: installed service-worker kill-switch (${body.length} bytes) -> ` +
  path.relative(root, dest)
);

// Fail loudly rather than shipping the empty placeholder by accident.
if (fs.statSync(dest).size === 0) {
  console.error('postbuild: kill-switch is empty after write');
  process.exit(1);
}
