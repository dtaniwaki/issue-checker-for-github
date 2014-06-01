module.exports = (grunt) ->
  grunt.config.merge {
    clean: {
      dist: ['app/*', 'app.zip']
    }
  }

  grunt.loadNpmTasks 'grunt-contrib-clean'
