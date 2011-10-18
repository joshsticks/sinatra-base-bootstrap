
desc 'Compile coffee scripts and pack assets'
task :brew do
  `sass views/scss/styles.scss public/css/styles.css && coffee -c -o public/js coffeescript && jammit`
end