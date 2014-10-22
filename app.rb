#!/bin/ruby

require 'rbconfig'
THIS_FILE = File.expand_path(__FILE__)
RUBY = File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])

$gem_dir = File.dirname(__FILE__) + "/gems"
Gem.path.unshift($gem_dir) unless Gem.path.include?($gem_dir)

def install_gem(name, version = Gem::Requirement.default)
  require 'rubygems'
  require 'rubygems/dependency_installer'

  begin
    installer      = Gem::DependencyInstaller.new({:install_dir => "#{$gem_dir}"})
    installed_gems = installer.install name, version
  rescue Gem::GemNotFoundException

  end
end

def gems(*gems)
  gems.each { |g|
    begin
      gem *g
    rescue LoadError
      install_gem(*g)
    end
  }
end

gems(['sinatra', '1.4.5'], ['kramdown'], ['coderay'])
require 'sinatra'
require 'kramdown'
require 'coderay'

get '/settings' do
  `ruby settings.rb`
end

get '/*' do
  path = request.path_info
  if File.exists?("markdown/#{path}.md")
    Kramdown::Document.new(File.read("markdown/#{path}.md"), :template => 'markdown/templates/kramdown.html.erb' ).to_html
  else
    redirect to('/index')
  end
end

