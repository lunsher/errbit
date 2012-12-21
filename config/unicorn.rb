# http://michaelvanrooijen.com/articles/2011/06/01-more-concurrency-on-a-single-heroku-dyno-with-the-new-celadon-cedar-stack/
# -*- encoding : utf-8 -*-
APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'


deploy_to  = "/home/errbit/application"
rails_root = "#{deploy_to}/current"
pid_file   = "#{deploy_to}/shared/pids/unicorn.pid"
socket_file= "#{deploy_to}/shared/unicorn.sock"
log_file   = "#{rails_root}/log/unicorn.log"
err_log    = "#{rails_root}/log/unicorn_error.log"
old_pid    = pid_file + '.oldbin'


timeout 30
worker_processes 3
listen socket_file, :backlog => 1024
pid pid_file
stderr_path err_log
stdout_path log_file


preload_app true


GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)
