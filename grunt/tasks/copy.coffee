module.exports = (grunt) ->
  grunt.config.merge {
    copy: {
      dist: {
        files: [
          {expand: true, cwd: 'src', src: ['js/**/*.js', 'images/**', '*.html', '*.json'], dest: 'app/'}
        ]
      }
    }
  }

  grunt.loadNpmTasks('grunt-contrib-copy');
