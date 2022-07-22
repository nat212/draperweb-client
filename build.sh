#!/bin/bash

DIST_DIR=dist
ANDROID_DIR=android

USAGE="Usage $0 <android>"

case $1 in
  "android")
    echo "Building for Android"
    flutter build appbundle --flavor prod
    mkdir -p $DIST_DIR/$ANDROID_DIR
    cp -r build/app/outputs/bundle/prodRelease/app-prod-release.aab "$DIST_DIR/$ANDROID_DIR/za.net.draper.draperweb.aab"
    ./debug-symbols.sh
    mv build/app/intermediates/merged_native_libs/prodRelease/out/lib/debug-symbols.zip "$DIST_DIR/$ANDROID_DIR/debug-symbols.zip"
    ;;
  "apk")
    echo "Building apk for android"
    flutter build apk --flavor prod
    cp build/app/outputs/apk/prod/release/app-prod-release.apk "$DIST_DIR/$ANDROID_DIR/za.net.draper.draperweb.apk"
    ;;
  "web")
    echo "Building for web"
    flutter build web --flavor prod
    ;;
  *)
    echo "$USAGE"
    exit 1
    ;;
esac
