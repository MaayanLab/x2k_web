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
                        '!static/**',
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
                        '!static/**',
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
                        '!static/**',
                        '!node_modules/**',
                    ],
                    dest: 'dist',
                }]
            }
        }
	});

	grunt.loadNpmTasks('grunt-browserify');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-changed');

	grunt.registerTask('build', [
		'changed:browserify',
		'changed:less',
		'changed:copy',
	])
};