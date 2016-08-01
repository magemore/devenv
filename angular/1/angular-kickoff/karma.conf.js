module.exports = function(config) {
  config.set({
    basePath: './',
    frameworks: ['mocha', 'chai', 'browserify'],
    reporters: ['progress', 'coverage'],
    files: [
      'node_modules/angular/angular.min.js',
      'node_modules/angular-mocks/angular-mocks.js',
      'Sources/**/*.js'
    ],
    preprocessors: {
      'Sources/**/*.js': ['browserify']
    },
    browserify: {
      debug: true,
      transform: [
        ['browserify-istanbul', {
          ignore: ['Sources/**/!(*.spec)+(.js)'],
          instrumenter: require('isparta')
        }],
        ['babelify', {
          presets: ['es2015'],
          plugins: ['transform-html-import-to-string']
        }]
      ]
    },
    coverageReporter: {
      type : 'html',
      dir : 'coverage/'
    },
    browsers: ['Chrome']
  });
};
