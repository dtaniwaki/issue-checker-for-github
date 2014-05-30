'use strict'

module.exports = (grunt)->
  config =
    pkg:    grunt.file.readJSON('package.json')

  grunt.initConfig config
  grunt.loadTasks './grunt/tasks'

