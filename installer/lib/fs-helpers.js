import fs from 'node:fs/promises';
import path from 'node:path';

/**
 * Copy `src` to `dest`, first backing up `dest` to `dest.bak` if it exists.
 *
 * @param {string} src
 * @param {string} dest
 * @param {{ dryRun?: boolean }} [opts]
 */
export async function backupAndCopy(src, dest, opts = {}) {
  if (opts.dryRun) {
    console.log(`[dry-run] Would backup and copy: ${src} -> ${dest} (backup: ${dest}.bak)`);
    return;
  }

  if (await fileExists(dest)) {
    await fs.copyFile(dest, `${dest}.bak`);
  }

  await fs.copyFile(src, dest);
}

/**
 * Append `content` to `filePath` unless `marker` is already present.
 * Creates the file (and parent dirs) if it does not exist.
 *
 * @param {string} filePath
 * @param {string} marker  - Substring that indicates content is already applied.
 * @param {string} content - Text to append when marker is absent.
 * @param {{ dryRun?: boolean }} [opts]
 */
export async function appendIfAbsent(filePath, marker, content, opts = {}) {
  let existing = '';
  try {
    existing = await fs.readFile(filePath, 'utf8');
  } catch (err) {
    if (err.code !== 'ENOENT') throw err;
  }

  if (existing.includes(marker)) return;

  if (opts.dryRun) {
    console.log(`[dry-run] Would append to ${filePath}:\n${content}`);
    return;
  }

  await fs.mkdir(path.dirname(filePath), { recursive: true });
  await fs.appendFile(filePath, content, 'utf8');
}

/**
 * Read `filePath` as JSON, set `key` to `value`, and write back with 2-space indent.
 * If the file does not exist, starts from an empty object.
 *
 * @param {string} filePath
 * @param {string} key    - Dot-notation not supported; top-level key only.
 * @param {unknown} value
 * @param {{ dryRun?: boolean }} [opts]
 */
export async function patchJson(filePath, key, value, opts = {}) {
  let data = {};
  try {
    const raw = await fs.readFile(filePath, 'utf8');
    data = JSON.parse(raw);
  } catch (err) {
    if (err.code !== 'ENOENT') throw err;
  }

  data[key] = value;

  if (opts.dryRun) {
    console.log(`[dry-run] Would patch ${filePath}: set "${key}" = ${JSON.stringify(value)}`);
    return;
  }

  await fs.mkdir(path.dirname(filePath), { recursive: true });
  await fs.writeFile(filePath, JSON.stringify(data, null, 2) + '\n', 'utf8');
}

/**
 * Return `true` if `filePath` is accessible, `false` otherwise.
 *
 * @param {string} filePath
 * @returns {Promise<boolean>}
 */
export async function fileExists(filePath) {
  try {
    await fs.access(filePath);
    return true;
  } catch {
    return false;
  }
}
