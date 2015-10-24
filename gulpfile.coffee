#$          = do require "gulp-load-plugins"
#webpack    = $.webpack
webpackStream    = require "webpack-stream"
webpack    = require "webpack"

source     = require "vinyl-source-stream"
buffer     = require "vinyl-buffer"
browserSync = require "browser-sync"
runSequence = require "run-sequence"
path       = require "path"

glob       = require "glob"
del        = require "del"

gulp       = require "gulp"
notify     = require "gulp-notify"
rename     = require "gulp-rename"
plumber    = require "gulp-plumber" # エラーによるwatch実行中断防止
concat     = require "gulp-concat"
bower      = require "gulp-bower"
bowerFiles = require "main-bower-files"
bowerWebpackPlugin = require "bower-webpack-plugin"
uglify     = require "gulp-uglify"
minifyCSS  = require "gulp-minify-css"
compass    = require "gulp-compass"
sass       = require "gulp-sass" #sass       = require "gulp-ruby-sass"
jade       = require "gulp-jade"

paths =
  srcFiles: glob.sync("./app/*.js")
  build: "./public/"
  jsBuildFile: "app.js"
  nodeModules: "./node_modules"
  bowerComponents: "./bower_components"

gulp.task "server", ->
  browserSync.init ["./public/**/*"],
    browser: "Google Chrome"
    server:
      baseDir: "./public"  

gulp.task "reload", ->
  browserSync.reload

gulp.task "js", ->
  gulp.src(paths.nodeModules + "/react/dist/react.min.js")
    .pipe gulp.dest "./public/"  

  gulp.src "./app/"
  #.pipe webpackStream require "./webpack.config.coffee"
  .pipe webpackStream {
    progress: true
    entry: 
      #app: "./app/initialize.coffee"
      app: "./app/initialize.js"
    output: # 出力先の設定
      filename: paths.jsBuildFile
    resolve: # ファイル名の解決を設定
      root: [path.join(__dirname, "./")]
      moduleDirectories: ["node_modules", "bower_components"]
      extensions: ["", ".js", ".coffee", ".jsx"]
      #extensions: ["", ".js", ".coffee", ".webpack.js", ".web.js"]
    externals: {
      # http://www.twopipe.com/front-end/2014/12/22/react-webpack-env.html
      # Reactをnpmからでなくグローバルから取得する
      # この設定がないとcompileが遅くなる
      #'react': 'React'
    },
    module: # 他にもhtmlやcssを読み込む必要がある場合はここへ追記
      loaders: [
        # react
        { test: /\.jade$/, loader: 'react-jade-loader' },
        { test: /\.jsx$/, loader: 'jsx-loader' },
        { test: /\.coffee$/, loader: "coffee-loader" },

        { test: /is_js/, loader: "imports?define=>undefined" },
        { test: /cssuseragent/, loader: "exports?cssua" },
        # { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
      ]
    plugins: [ # webpack用の各プラグイン
      # bower.jsonにあるパッケージをrequire出来るように
      new bowerWebpackPlugin(),
      new webpack.optimize.AggressiveMergingPlugin(),
      new webpack.optimize.DedupePlugin(),
      new webpack.ProvidePlugin
        $: "jquery"
        _: "lodash"
    ]
  }
  .pipe plumber()
  #.pipe uglify()
  .pipe gulp.dest paths.build

gulp.task "jade", ->
  gulp
    .src "./*.jade"
    .pipe plumber()
    .pipe jade(pretty: true)
    .pipe gulp.dest paths.build

gulp.task "css", ->
  #gulp.src "./app/styles/mobile.scss"
  #  .pipe sass()
  #  .pipe gulp.dest "./public"

  #gulp.src "./app/styles/**/*.scss"
  gulp.src "./app/styles/app.scss"
    .pipe plumber()
    .pipe(compass(
      config_file: "./compass/config.rb"
      bundle_exec: true
      comments: false
      cache: false
      http: "./public"
      css: "./tmp/css"
      sass: "./app/styles/"
    ))
    .pipe gulp.dest "./public"

gulp.task "asset", ->
  gulp.src(paths.nodeModules + "/font-awesome/fonts/**.*")
    .pipe gulp.dest "./public/fonts/font-awesome"
  
gulp.task "clean-bower", ->
  del.sync("./bower_components/*")
gulp.task "clean-node", ->
  del.sync("./node_modules/*")  

gulp.task "lib", ->
  return bower()
    .pipe gulp.src(bowerFiles("**/*.js"))
    .pipe plumber()
    .pipe concat("lib.js")
    .pipe gulp.dest paths.build

gulp.task "watch", ["build", "server"], ->
  gulp.watch "app/**/*.js", ["js"]
  gulp.watch "app/**/*.jsx", ["js"]
  gulp.watch "app/**/*.jade", ["js"]
  gulp.watch "app/**/*.coffee", ["js"]
  gulp.watch "app/styles/**/*.scss", ["css", "asset"]
  gulp.watch "app/**/*.jade", ["jade"]
  #gulp.watch "bower_components/**/*.js", ["lib"]

gulp.task "clean", ->
  del.sync("./public/*")

gulp.task "build", ->
  return runSequence(
    "clean"
    "js"
    "css"
    "jade"
    #"lib"
    #"asset"
  )  
  #["bower", "js", "css", "jade"]
gulp.task "default", ["build"]



