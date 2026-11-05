Browser-based embed check (finds videos YouTube refuses to play on other sites).
1. node -e to write window.IDS (array of video ids) into _ids.js next to these files
2. serve the folder from any http origin, open _videotest.html, wait until window.DONE equals window.IDS.length
3. anything in window.RES that is not "ok" (err150/err100 = blocked/removed) should be set to false in seed/data/embed-ok.json, then npm run seed:build
(The seed build also removes those videos from the database.)
