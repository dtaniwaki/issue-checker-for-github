'use strict'

module.exports = (grunt)->
  config =
    pkg:    grunt.file.readJSON('package.json')

  grunt.initConfig config
  grunt.loadTasks './grunt/tasks'

  grunt.registerTask 'compile', ['copy', 'sass', 'coffee']
  grunt.registerTask 'pack', ['clean', 'compile', 'compress']
  grunt.registerTask 'default', ['pack']
