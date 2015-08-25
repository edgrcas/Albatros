#!/bin/bash
FRONTEND_DIR="/var/www"

if [ -d "$FRONTEND_DIR" ]; then

    cd $FRONTEND_DIR

    if [ ! -d "node_modules" ]; then
        dependences=( browser-sync \
            connect-history-api-fallback \
            conventional-changelog \
            event-stream \
            gulp \
            gulp-autoprefixer \
            gulp-bump \
            gulp-changed \
            gulp-coffee  \
            gulp-complexity \
            gulp-connect \
            gulp-consolidate \
            gulp-css-url-versioner \
            gulp-cssshrink \
            gulp-debug \
            gulp-email \
            gulp-filter \
            gulp-iconfont \
            gulp-if \
            gulp-imagemin \
            gulp-jade \
            gulp-jshint \
            gulp-load-plugins \
            gulp-minify-css \
            gulp-plumber \
            gulp-recursive-folder \
            gulp-rename \
            del \
            vinyl-paths \
            gulp-size \
            gulp-sourcemaps \
            gulp-stylus \
            gulp-tag-version \
            gulp-uglify \
            gulp-uncss \
            gulp-util \
            gulp-zip \
            gulp.spritesmith \
            imagemin-gifsicle \
            imagemin-jpegtran \
            imagemin-optipng \
            imagemin-pngquant \
            jshint-stylish \
            lodash \
            node-notifier \
            phantomjssmith \
            gulp-concat \
            run-sequence
        )

        for i in "${dependences[@]}"
        do
            npm install --save-dev $i
        done

    fi

    # creando la configuracion local
    cp gulp/config.local.js.dist gulp/config.local.js
    cp gulp/jade.js.dist gulp/jade.js

    if [[ -f gulp/config.local.js  ]]; then
        echo "Su configuración local se ha instalado. (config.local.js)";
    fi

    if [[ -f gulp/jade.js  ]]; then
        echo "Su configuración local de jade se ha instalado. (jade.js)";
    fi

fi
