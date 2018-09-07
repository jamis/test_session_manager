require 'test_helper'

class MiddlewareTest < ActiveSupport::TestCase
  setup do
    @app = ->(env) { :done }
    @session = {}
    @env = { 'rack.session' => @session }

    @manager = TestSessionManager.new
    @middleware = TestSessionManager::Middleware.new(@app, @manager)
  end

  test 'middleware with no manager data added' do
    assert @manager.flash.empty?
    assert @manager.session.empty?

    assert @session['flash'].blank?
    assert @session['session'].blank?

    @middleware.call(@env)

    assert @session['flash'].blank?
    assert @session['session'].blank?
  end

  test 'middleware adds session values' do
    @manager.session['first'] = '1st'
    @manager.session['second'] = '2nd'

    @middleware.call(@env)

    assert_equal '1st', @session['first']
    assert_equal '2nd', @session['second']
  end

  test 'middleware adds flash values' do
    @manager.flash['first'] = '1st'
    @manager.flash['second'] = '2nd'

    @middleware.call(@env)

    assert_equal({ 'flashes' => { 'first' => '1st', 'second' => '2nd' }, 'discard' => [] }, @session['flash'])
  end

  test 'middleware preserves existing flash values' do
    @session['flash'] = { 'flashes' => { 'original' => 'keep', 'old' => 'lose' }, 'discard' => [ 'old' ] }

    @manager.flash['first'] = '1st'
    @manager.flash['second'] = '2nd'

    @middleware.call(@env)

    assert_equal({ 'flashes' => { 'original' => 'keep', 'first' => '1st', 'second' => '2nd' }, 'discard' => [] }, @session['flash'])
  end

  test 'middleware resets manager on each request' do
    @manager.session['a'] = 'b'
    @manager.flash['b'] = 'a'

    @middleware.call(@env)

    assert @manager.session.blank?
    assert @manager.flash.blank?
  end
end
