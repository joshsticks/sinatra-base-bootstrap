{spawn, exec} = require 'child_process'

task 'watch', 'continually build coffee files with --watch', ->
  coffee = spawn 'coffee', ['-cw', '-o', 'public/js', 'coffeescript']
  coffee.stdout.on 'data', (data) -> console.log data.toString().trim()
  coffee2 = spawn 'coffee', ['-cw', '-o', 'test/spec', 'test/spec']
  coffee2.stdout.on 'data', (data) -> console.log data.toString().trim()
