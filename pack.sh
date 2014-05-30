#! /bin/bash
rm app.zip
rm -fr app/*
cp -r src/*.html src/js src/images src/manifest.json app/
grunt sass
zip -r app.zip app
