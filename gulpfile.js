var gulp = require('gulp');
var browserify = require('gulp-browserify');
var concat = require('gulp-concat');


gulp.task('browserify', function(){
	gulp.src('public/scripts/*.js')
	.pipe(browserify({transform: 'reactify'}))
	.pipe(concat('main.js'))
	.pipe(gulp.dest('public/build'));
});

gulp.task('default', ['browserify'])

gulp.task('watch', function(){
	gulp.watch('public/scripts/**/*.*', ['default']);
});