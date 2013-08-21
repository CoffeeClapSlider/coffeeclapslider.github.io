module.exports = (grunt)->

  grunt.initConfig
    "coffeelint":
      "app": [ 'src/*.coffee' ]
    "coffee":
      "public":
        files:
          'app/CoffeeClapSlider.js': [ 'src/*.coffee' ]
    "watch":
      "files": [ 'src/*.coffee' ]
      "tasks": [ 'coffeelint', 'coffee' ]


  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', [ 'coffeelint', 'coffee:public' ]
  grunt.registerTask 'w', [ 'coffeelint', 'coffee:public', 'watch' ]
