module.exports = (grunt) ->
  grunt.config.merge {
    coffee: {
      dist: {
        expand: true,
        flatten: true,
        cwd: 'src/js',
        src: ['*.coffee'],
        dest: 'app/js',
        ext: '.js'
      }
    }
  }

  grunt.loadNpmTasks 'grunt-contrib-coffee'
