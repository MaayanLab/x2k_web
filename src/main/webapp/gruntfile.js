var path = require('path')

module.exports = function(grunt) {
	grunt.initConfig({
        babel: {
            options: {
                sourceMap: true,
                presets: ['env']
            },
            dist: {
                files: [{
                    expand: true,
                    cwd: '.',
                    src: [
                        '**/*.js',
                        '!**/*.dist.js',
                        '!**/*.min.js',
                        '!gruntfile.js',
                        '!node_modules/**',
                    ],
                    dest: '.',
                    rename: function(dest, matchedSrcPath, options) {
                        var base = path.join(
                            path.dirname(matchedSrcPath),
                            path.basename(matchedSrcPath, '.js')
                        )
                        return path.join(dest, base + '.dist.js')
                    }
                }]
            }
        },
		less: {
			"default": {
				options: {
                    yuicompress: true,
                    sourceMap: true
				},
                files: [{
                    expand: true,
                    cwd: '.',
                    src: [
                        '**/*.css',
                        '!**/*.dist.css',
                        '!**/*.min.css',
                        '!node_modules/**',
                    ],
                    dest: '.',
                    rename: function(dest, matchedSrcPath, options) {
                        var base = path.join(
                            path.dirname(matchedSrcPath),
                            path.basename(matchedSrcPath, '.css')
                        )
                        return path.join(dest, base + '.dist.css')
                    }
                }]
			}
		}
	})

	grunt.loadNpmTasks('grunt-babel')
	grunt.loadNpmTasks('grunt-contrib-less')

	grunt.registerTask('build', [
		'babel',
		'less',
	])
}