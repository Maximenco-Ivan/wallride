import gulp from 'gulp';
import systemjs from 'gulp-systemjs-builder';
import sass from 'gulp-sass';
import webserver from 'gulp-webserver';

const paths = {
	app: 'src/app/',
	css: [
//      'src/jspm_packages/github/Semantic-Org/Semantic-UI@2.2.2/semantic.css',
		'src/css/*.css'
	],
// 	external_css: [
// 		'src/jspm_packages/npm/eonasdan-bootstrap-datetimepicker@4.15.35/build/css/bootstrap-datetimepicker.min.css',
// 		'src/jspm_packages/github/twbs/bootstrap@2.3.2/docs/assets/css/bootstrap.css',
// 		'src/jspm_packages/github/FortAwesome/font-awesome@3.2.1/css/font-awesome.min.css'
// 	],
	assets: [
//      'src/css*/**',
		'src/img*/**',
// 		'src/*.txt',
// 		'src/*.html',
// 		'src/font*/**',
// 		'src/css*/filterable-list.css',
// 		'src/config.js',
// 		'src/jspm_packages*/system*',
		'src/jspm_packages*/**/*.ttf',
		'src/jspm_packages*/**/*.woff',
		'src/jspm_packages*/**/*.woff2'
	],
	dest: 'build/dist/'
};

// build JSPM modules
gulp.task('jspm', ['sass'], () => {
    let builder = systemjs('./src', './src/jspm.config.js');
    builder.config({
        separateCSS: true
    });

    builder.buildStatic('index.js', {
        // minify: false,
        // mangle: false,
        outFile: paths.dest + 'static/admin/index.bundle.js',
        browser: true,
        lowResSourceMaps: true,
        format: 'umd',
        rollup: true
    });
});

gulp.task('sass', () => {
	gulp.src('src/scss/*.scss')
		.pipe(sass())
		.pipe(gulp.dest('src/css/'));
});

gulp.task('copy-assets', () => {
	gulp.src(paths.assets)
		.pipe(gulp.dest(paths.dest + 'static/admin'));
});

gulp.task('watch', () => {
	gulp.watch('src/scss/*.scss', ['sass']);
});

gulp.task('server', ['watch'], () => {
	gulp.src('src')
		.pipe(webserver({
			livereload: {
				enable: true,
				filter: (filename) => {
					return !(filename.match(/.scss$/));
				}
			},
			open: true,
			fallback: '/html/index.html'
		}));
});

gulp.task('build', ['jspm', 'copy-assets']);

gulp.task('default');