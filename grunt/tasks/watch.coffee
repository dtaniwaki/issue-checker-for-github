module.exports = (grunt) ->
  grunt.config.merge {
    watch: {
      sass: {
        files: ['src/**/*.scss'],
        tasks: ['sass'],
        options: {
          spawn: false
        }
      }
    }
  }

  grunt.loadNpmTasks 'grunt-contrib-watch'
