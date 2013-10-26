Path = require('path')
fs = require('fs')

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffee:
      compile:
        files:
          'lobstertrap.js': 'lobstertrap.coffee'
          'doc/example.js': 'doc/example.coffee'

    watch:
      coffee:
        files: ['lobstertrap.coffee', 'docs/example/landing-page.coffee', 'docs/sass/*']
        tasks: ["coffee", "uglify", "compass"]

    uglify:
      options:
        banner: "/*! <%= pkg.name %> <%= pkg.version %> */\n"

      dist:
        src: 'src/lobstertrap.js'
        dest: 'lobstertrap.min.js'

    # compass:
    #   dist:
    #     options:
    #       sassDir: 'sass'
    #       cssDir: 'themes'

    haml:
      doc:
        language: "coffee"
        src: "doc/example.haml"
        dest: "doc/example.html"

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  # grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-haml'

  grunt.registerTask 'default', ['coffee', 'uglify', 'haml']