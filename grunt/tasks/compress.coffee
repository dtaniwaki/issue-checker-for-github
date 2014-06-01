module.exports = (grunt) ->
  grunt.config.merge {
    compress: {
      dist: {
        options: {
          archive: 'app.zip',
          mode: 'zip'
        },
        files: [
          {src: ['app/**'], dest: './'}
        ]
      }
    }
  }

  grunt.loadNpmTasks('grunt-contrib-compress');
