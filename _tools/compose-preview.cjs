// Composes Mod/About/Preview.png from Art/Preview-before-icon.png plus the ModIcon cut out of its
// background, in the bottom-left corner, tilted +15deg (left corner rule, PUBLISHING.md, 2026-09-29).
//
// The cut-out is a flood fill from the border inward: only pixels connected to the frame and
// near-black turn transparent, so the icon's own dark details are never touched (no global
// threshold). Re-runnable: it always starts from Preview-before-icon.png, so icons never stack.
//
// Needs sharp on the Node path (`npm i -g sharp`). Run from the repo root:
//   node _tools/compose-preview.cjs
const sharp = require('sharp');
const path = require('path');
const root = path.resolve(__dirname, '..');

const ICON_SIZE = 150;   // px, before the tilt
const TILT = 15;         // degrees, clockwise; +15 in a left corner, -15 in a right one
const BLEED = 22;        // px the tilted icon runs past the left and bottom edges

async function cutout(src) {
  const { data, info } = await sharp(src).ensureAlpha().raw().toBuffer({ resolveWithObject: true });
  const { width: w, height: h, channels: c } = info;
  const isBg = i => data[i] < 12 && data[i + 1] < 12 && data[i + 2] < 12;
  const seen = new Uint8Array(w * h);
  const stack = [];
  for (let x = 0; x < w; x++) { stack.push([x, 0], [x, h - 1]); }
  for (let y = 0; y < h; y++) { stack.push([0, y], [w - 1, y]); }
  while (stack.length) {
    const [x, y] = stack.pop();
    if (x < 0 || y < 0 || x >= w || y >= h) continue;
    const p = y * w + x;
    if (seen[p] || !isBg(p * c)) continue;
    seen[p] = 1;
    data[p * c + 3] = 0;
    stack.push([x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]);
  }
  let removed = 0;
  for (let p = 0; p < w * h; p++) if (seen[p]) removed++;
  console.log(`cut-out: removed ${removed} of ${w * h} pixels (${(100 * removed / (w * h)).toFixed(1)}%)`);
  return sharp(data, { raw: { width: w, height: h, channels: c } }).png().toBuffer();
}

(async () => {
  const cut = await cutout(path.join(root, 'Mod/About/ModIcon.png'));
  await sharp(cut).toFile(path.join(root, '.build/ModIcon-cutout.png')).catch(() => {});
  const icon = await sharp(cut)
    .resize(ICON_SIZE, ICON_SIZE, { kernel: 'lanczos3' })
    .rotate(TILT, { background: { r: 0, g: 0, b: 0, alpha: 0 } })
    .png().toBuffer({ resolveWithObject: true });
  const shadow = await sharp(icon.data)
    .ensureAlpha().tint({ r: 0, g: 0, b: 0 }).blur(7).png().toBuffer();

  const base = path.join(root, 'Art/Preview-before-icon.png');
  const { width: W, height: H } = await sharp(base).metadata();
  const rw = icon.info.width, rh = icon.info.height;
  const left = -BLEED, top = H - rh + BLEED;

  // sharp cannot place a layer at a negative offset: crop the part that falls inside the frame.
  const cropLeft = Math.max(0, -left), cropTop = Math.max(0, -top);
  const cropW = Math.min(rw - cropLeft, W - Math.max(0, left));
  const cropH = Math.min(rh - cropTop, H - Math.max(0, top));
  const crop = b => sharp(b).extract({ left: cropLeft, top: cropTop, width: cropW, height: cropH }).png().toBuffer();
  const place = { left: Math.max(0, left), top: Math.max(0, top) };

  const out = path.join(root, 'Mod/About/Preview.png');
  await sharp(base)
    .composite([
      { input: await crop(shadow), left: place.left, top: place.top, blend: 'over' },
      { input: await crop(icon.data), ...place },
    ])
    .png({ compressionLevel: 9 })
    .toFile(out);
  const meta = await sharp(out).metadata();
  console.log(`wrote ${out} (${meta.width}x${meta.height})`);
})();
