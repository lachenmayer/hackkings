var gulp        = require('gulp'),
    gutil       = require('gulp-util'),
    coffee      = require('gulp-coffee'),
    stylus      = require('gulp-stylus'),
    bower       = require('gulp-bower'),
    browserify  = require('gulp-browserify'),
    uglify      = require('gulp-uglify'),
    jade        = require('gulp-jade'),
    concat      = require('gulp-concat'),
    livereload  = require('gulp-livereload'),
    tinylr      = require('tiny-lr'),
    express     = require('express'),
    app         = express(),
    path        = require('path'),
    server      = tinylr();


// --- Basic Tasks ---
gulp.task('css', function() {
  return gulp.src('src/css/*.styl')
    .pipe(stylus({ set: ['compress']}))
    .pipe(gulp.dest('bin/css'))
    .pipe(livereload(server));

});

gulp.task('js', function() {
  return gulp.src('src/js/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('build/js'));
});

gulp.task('templates', function() {
  return gulp.src('src/*.jade')
    .pipe(jade({ pretty: true }))
    .pipe(gulp.dest('bin/'))
    .pipe(livereload(server));
});

gulp.task('express', function() {
  app.use(require('connect-livereload')());
  app.use(express.static(path.resolve('./bin')));
  app.listen(1337);
  gutil.log('Listening on port: 1337');
});

gulp.task('bower', function() {
  bower().pipe(gulp.dest('./build/js/lib'))
});

gulp.task('browserify', function() {
  return gulp.src('build/js/app.js')
    .pipe(browserify({
      shim: {
        threejs: {
          path: './build/js/lib/threejs/build/three.js',
          exports: 'THREE'
        }
      }
    }))
    .pipe(gulp.dest('bin/js/'))
    .pipe(livereload(server));
});

gulp.task('watch', function () {
  server.listen(35729, function (err) {
    if (err) return console.log(err);
  });
  gulp.watch('src/css/*.styl',['css']);
  gulp.watch('src/js/*.coffee',['buildjs']);
  gulp.watch('src/*.jade',['templates']);
});

gulp.task('buildjs', ['js','bower','browserify'])

// Default Task
gulp.task('default', ['buildjs','css','templates','express','watch']);