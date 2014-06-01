module.exports = (grunt) ->
  grunt.config.merge {
    watch: {
      dist: {
        files: ['src/**'],
        tasks: ['compile'],
        options: {
          spawn: false
        }
      }
    }
  }

  grunt.loadNpmTasks 'grunt-contrib-watch'
