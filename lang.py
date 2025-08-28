#!/usr/bin/env python3
import os
from collections import defaultdict

ext_map = {
    '.py': 'Python',
    '.c': 'C',
    '.h': 'C Header',
    '.cpp': 'C++',
    '.hpp': 'C++ Header',
    '.rs': 'Rust',
    '.js': 'JavaScript',
    '.ts': 'TypeScript',
    '.java': 'Java',
    '.go': 'Go',
    '.sh': 'Shell',
    '.rb': 'Ruby',
    '.php': 'PHP',
    '.html': 'HTML',
    '.css': 'CSS',
    '.md': 'Markdown',
    '.json': 'JSON',
    '.yml': 'YAML',
    '.yaml': 'YAML',
    '.makefile': 'Makefile',
    'makefile': 'Makefile',
    '.mk': 'Makefile',
    '.odin': 'Odin',
    '.sml': 'SML',
    '.txt': 'Text',
    '.pl': 'Perl',
    '.lua': 'Lua',
    '.dart': 'Dart',
    '.scala': 'Scala',
    '.swift': 'Swift',
    '.asm': 'Assembly',
    '.s': 'Assembly',
    '.S': 'Dissassembly',
    '.bqn': 'BQN',
    '.vim': 'Vimscript',
}

def get_size(path):
    try:
        return os.path.getsize(path)
    except OSError:
        return 0

def scan_dir(base_path):
    global_lang_totals = defaultdict(int)
    folder_lang_totals = defaultdict(lambda: defaultdict(int))

    for root, _, files in os.walk(base_path):
        for f in files:
            ext = os.path.splitext(f)[1].lower()
            lang = ext_map.get(ext)
            if not lang and f.lower() in ['makefile', 'makefile.inc', 'makefile.win']:
                lang = 'Makefile'
            if not lang:
                continue

            path = os.path.join(root, f)
            size = get_size(path)
            global_lang_totals[lang] += size

            rel = os.path.relpath(root, base_path).split(os.sep)[0]
            folder_lang_totals[rel][lang] += size

    return global_lang_totals, folder_lang_totals

def main():
    base_path = os.path.expanduser('~/Coding')
    global_totals, folder_totals = scan_dir(base_path)

    if not global_totals:
        print("No matching source files found.")
        return

    print(f"Scanning directory: {base_path}\n")

    print("=== Global Totals ===")
    grand_total = sum(global_totals.values())
    for lang, size in sorted(global_totals.items(), key=lambda x: x[1], reverse=True):
        pct = (size / grand_total) * 100 if grand_total else 0
        print(f"{lang:12} {size:10} bytes  ({pct:5.2f}%)")
    print()

    print("=== Per-Folder Breakdown ===")
    for folder, langs in folder_totals.items():
        print(f"\nFolder: {folder}")
        for lang, size in sorted(langs.items(), key=lambda x: x[1], reverse=True):
            global_size = global_totals[lang]
            pct = (size / global_size) * 100 if global_size else 0
            print(f"  {lang:12} {size:10} bytes  ({pct:5.2f}% of all {lang})")

if __name__ == "__main__":
    main()

