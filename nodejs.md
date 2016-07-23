#nodejs

## quick http server
- [ ] install on vlad laptop
- [ ] install also on mobile termux


A good "ready-to-use tool" option could be http-server:
```bash
npm install http-server -g
```

To use it:
```
cd ~/Folder
http-server
```

Or, like this:
```
http-server ~/Folder
```

Check it out: https://github.com/nodeapps/http-server

## npm install by default
```
npm install -g express gulp async request lodash browserify pm2 grunt socket.io commander forever mongoose mocha moment bower chalk underscore gulp-uglify cheerio q debug bluebird nodemailer colors passport redis react karma hapi nodemon coffee-script mysql yo body-parser gulp-autoprefixer validator pug minimist cordova browser-sync less mongodb http-server grunt-cli gulp-imagemin winston npm-check-updates gulp-rename shelljs gulp-sourcemaps glob morgan webpack yargs fs-extra chai superagent gulp-minify-css uglify-js gulp-clean-css shelljs
```
- [ ] install more
 
# shelljs 
- [ ] try it for automation
https://www.npmjs.com/package/shelljs

```coffee
require 'shelljs/global'
 
if not which 'git'
  echo 'Sorry, this script requires git'
  exit 1
 
# Copy files to release dir 
rm '-rf', 'out/Release'
cp '-R', 'stuff/', 'out/Release'
 
# Replace macros in each .js file 
cd 'lib'
for file in ls '*.js'
  sed '-i', 'BUILD_VERSION', 'v0.1.2', file
  sed '-i', /^.*REMOVE_THIS_LINE.*$/, '', file
  sed '-i', /.*REPLACE_LINE_WITH_MACRO.*\n/, cat('macro.js'), file
cd '..'
 
# Run external tool synchronously 
if (exec 'git commit -am "Auto-commit"').code != 0
  echo 'Error: Git commit failed'
  exit 1
```
