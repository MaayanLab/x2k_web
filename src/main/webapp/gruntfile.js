module.exports = function(grunt) {
	grunt.initConfig({
        browserify: {
            dist: {
                options: {
                    transform: [
                        ['babelify', {
                            sourceMap: true,
                            presets: ['env'],
                        }],
                        'windowify',
                    ]
                },
                files: [{
                    expand: true,
                    cwd: '.',
                    src: [
                        '**/*.js',
                        '!dist/**',
                        '!**/*.min.js',
                        '!gruntfile.js',
                        '!node_modules/**',
                    ],
                    dest: 'dist',
                }]
            }
        },
		less: {
			dist: {
				options: {
                    yuicompress: true,
                    sourceMap: true
				},
                files: [{
                    expand: true,
                    cwd: '.',
                    src: [
                        '**/*.css',
                        '!dist/**',
                        '!**/*.min.css',
                        '!node_modules/**',
                    ],
                    dest: 'dist',
                }]
			}
        },
        copy: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '.',
                    src: [
                        '**/*.min.js',
                        '**/*.min.css',
                        '!dist/**',
                        '!node_modules/**',
                    ],
                    dest: 'dist',
                }]
            }
        }
	})

	grunt.loadNpmTasks('grunt-browserify')
	grunt.loadNpmTasks('grunt-contrib-less')
	grunt.loadNpmTasks('grunt-contrib-copy')

	grunt.registerTask('build', [
		'browserify',
		'less',
		'copy',
	])
}