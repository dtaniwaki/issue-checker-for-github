#! /bin/bash
rm -r app/*
cp -r src/*.html src/js src/images src/manifest.json app/
grunt sass
