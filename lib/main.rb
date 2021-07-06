# frozen_string_literal: true

require 'byebug'
require 'active_model'
require_relative 'controllers/game'
require_relative 'models/base'
require_relative 'models/board'
require_relative 'models/cell'

puts 'New Game starting'
Controllers::Game.new.start
