module.exports = (grunt) ->
  grunt.initConfig {
    sass: {
      dist: {
        options: {
          style: 'compressed'
        },
        files: [{
          expand: true,
          cwd: 'src',
          src: ['css/*.scss'],
          dest: 'app',
          ext: '.css'
        }]
      }
    }
  }

  grunt.loadNpmTasks 'grunt-contrib-sass'
