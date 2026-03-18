#!/usr/bin/env bash
set -e

REPO_DIR="/tmp/tree-sitter-swift"
PARSER_DIR="$HOME/.config/nvim/parser"
QUERY_DIR="$HOME/.config/nvim/queries/swift"

echo "[swift-parser] Cloning tree-sitter-swift..."
rm -rf "$REPO_DIR"
git clone --depth 1 https://github.com/alex-pinkus/tree-sitter-swift "$REPO_DIR"

echo "[swift-parser] Generating parser..."
cd "$REPO_DIR"
tree-sitter generate

echo "[swift-parser] Compiling..."
clang -shared -fPIC -o swift.so -I src src/parser.c src/scanner.c

echo "[swift-parser] Installing parser..."
mkdir -p "$PARSER_DIR"
cp swift.so "$PARSER_DIR/swift.so"

echo "[swift-parser] Installing queries..."
mkdir -p "$QUERY_DIR"
cp queries/highlights.scm "$QUERY_DIR/highlights.scm"
cp queries/indents.scm    "$QUERY_DIR/indents.scm"
cp queries/folds.scm      "$QUERY_DIR/folds.scm"
cp queries/injections.scm "$QUERY_DIR/injections.scm"
cp queries/locals.scm     "$QUERY_DIR/locals.scm"

echo "[swift-parser] Done."
