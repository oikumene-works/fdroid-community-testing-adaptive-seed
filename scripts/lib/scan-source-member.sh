#!/usr/bin/env bash
set -euo pipefail

member="${TAR_FILENAME:-}"
case "$member" in
    */app/src/main/*.kt | */app/src/main/*.kts | */app/src/main/*.java | \
        */app/src/main/*.xml | */app/src/main/*.gradle | \
        */app/src/main/*.properties | */app/src/main/*.toml | \
        */android/src/*.kt | */android/src/*.kts | */android/src/*.java | \
        */android/src/*.xml | */android/*.gradle | */android/*.properties | \
        */lib/*.dart | */src/*.ts | */src/*.tsx | */src/*.js | */src/*.jsx | \
        */package.json | */capacitor.config.ts | */capacitor.config.js | \
        */pubspec.yaml | */pubspec.lock | */build.gradle | */build.gradle.kts | \
        */settings.gradle | */settings.gradle.kts) ;;
    *) cat >/dev/null; exit 0 ;;
esac

path="${member#*/}"
pattern='ACTION_VIEW|ACTION_CREATE_DOCUMENT|ACTION_OPEN_DOCUMENT|ACTION_GET_CONTENT|ACTION_SEND|CustomTabsIntent|Share[.]share|Browser[.]open|Filesystem[.]|FileProvider|registerPlugin|window[.]open|location[.]href|fetch[(]|XMLHttpRequest|WebSocket|CapacitorHttp|@capacitor(-community)?/|<uses-permission|<queries|<activity|<service|<receiver|<provider|<intent-filter|android:exported|android:permission|(^|[^[:alnum:]_])(https?://|market://|mailto:|tel:)'
rg -n -I -e "$pattern" - \
    | sed -e "s|^|${path}:|" \
        -e '/schemas[.]android[.]com/d' \
        -e '/www[.]w3[.]org/d' || true
