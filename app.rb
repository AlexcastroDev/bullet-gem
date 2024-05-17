# ===== Lekito on Rails =====

# frozen_string_literal: true
require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'activerecord', '=7.1.2'
  gem 'bullet',       '=7.1.6'
  gem 'sqlite3'
  gem 'minitest'
end

require 'active_record'
require 'logger'
require 'bullet'
require 'bullet/active_record71'
require 'minitest/autorun'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
ActiveSupport::LogSubscriber.colorize_logging = false

# ===== DEFINE THE SCHEMA =====
ActiveRecord::Schema.define do
  self.verbose = false
  
  create_table :orders do |t|
    t.string :name
  end

  create_table :order_items do |t|
    t.integer :order_id
    t.string :name
    t.integer :quantity
  end
end

# ===== MODELS =====

class Order < ActiveRecord::Base
  has_many :order_items
end

class OrderItem < ActiveRecord::Base
  belongs_to :order
end

# ===== SEED =====

# Create 3 items and 1 order
order = Order.create!(name: 'o1', order_items: [
  OrderItem.new(name: 'oi1', quantity: 1),
  OrderItem.new(name: 'oi2', quantity: 2),
  OrderItem.new(name: 'oi3', quantity: 3)
])

# ===== TEST =====
ActiveRecord::Base.logger = Logger.new $stdout
require 'minitest/autorun'

class ProblemTest < Minitest::Test
  def setup
    Bullet.enable = true
    Bullet.rails_logger = true
    Bullet.raise = true
    Bullet.n_plus_one_query_enable = true
    Bullet.start_request

    puts "Bullet.enable = #{Bullet.enable?}"
  end

  def test_raise_n_plus_one_query
    order = Order.first
    order.order_items.each do |item|
      item.update(name: "item #{('a'..'z').to_a.sample}", quantity: rand(1..10))
      puts item.name
    end
  end

  def teardown
    Bullet.perform_out_of_channel_notifications if Bullet.notification?
    Bullet.end_request
  end
end
