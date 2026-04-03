const fs = require("fs");
const path = require("path");

const root = path.join(__dirname, "..");
const url = process.env.SUPABASE_URL || "";
const key = process.env.SUPABASE_ANON_KEY || "";

fs.writeFileSync(
  path.join(root, "config.js"),
  `window.__SUPABASE_URL=${JSON.stringify(url)};\nwindow.__SUPABASE_ANON_KEY=${JSON.stringify(key)};\n`
);
