# frozen_string_literal: true

require 'fileutils'
require './lib/sitemap_generator/generator.rb'

FileUtils.mkdir_p 'static/rss'

g = Generator.new
g.generate_rss
