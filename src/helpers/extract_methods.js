const fs = require("fs");
const os = require("os");
const path = require("path");

async function walk(dir) {
  const paths = (await fs.promises.readdir(dir)).map((p) =>
    path.resolve(dir, p)
  );
  const dirs = new Set();
  for (let path of paths) {
    const stat = await fs.promises.stat(path);
    if (stat.isDirectory()) dirs.add(path);
  }

  for (let subdir of Array.from(dirs)) {
    (await walk(subdir)).forEach((p) => paths.push(p));
  }

  return paths;
}

const FUNCTION_PARSE_REGEX = /function ([\w:-]+)\(\)\s*\{\s*:\s*["]([^"]+)["]/g;

const scripts_path = path.resolve(path.join(__dirname, "..", "scripts"));
const repo_path = path.resolve(path.join(__dirname, "..", ".."));
const local_path = path.join(repo_path, ".local");
async function main() {
  const paths = (await walk(scripts_path)).filter((p) => p.endsWith(".sh"));
  let all_scripts = [];
  for (let p of paths) all_scripts.push(await fs.promises.readFile(p, "utf-8"));
  const all_scripts_text = all_scripts.join("\n").replace(/\\["]/g, "'");

  // extracting methods
  const regex = new RegExp(FUNCTION_PARSE_REGEX);
  let match = null;

  /**
   * @type {[{
   *  name:string,
   * help:string,
   * usage:string,
   * }]}
   */
  const methods = [];
  while ((match = regex.exec(all_scripts_text))) {
    const help = (match[2] || "").trim().split("USAGE:");
    methods.push({
      name: match[1],
      help: help[0],
      usage: help[1],
    });
  }

  let lines = [
    ["Name", "Description", "Usage"],
    ["---", "---", "---"],
  ];

  for (let method of methods) {
    lines.push([method.name, method.help, method.usage]);
  }

  const clean_md_table_Value = (val) =>
    (val || "").trim().replace("\n", "<br/>");
  lines = lines.map((l) => l.map((v) => clean_md_table_Value(v)));

  console.log(lines.map((l) => l.join(" | ")).join("\n"));
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
