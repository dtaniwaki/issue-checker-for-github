module.exports = (grunt) ->
  grunt.config.merge {
    copy: {
      dist: {
        files: [
          {expand: true, cwd: 'src', src: ['css/**/*.css', 'js/**/*.js', 'images/**', 'css/octicons/*', '*.html', '*.json'], dest: 'app/'}
        ]
      }
    }
  }

  grunt.loadNpmTasks('grunt-contrib-copy')
