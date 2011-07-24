require 'rubygems'
require 'test/unit'
require 'mailchimp_subscriber'

class User
  attr_accessor :email, :first_name, :last_name
  def initialize
    @email = "test@brandon-harris.com"
    @first_name = "Brandon"
    @last_name = "Harris"
  end
end

class SubscriberTest < Test::Unit::TestCase
  def setup
    @api_key = "1db21b9d9e03a08d804281ef5bad7ae4-us1"
    @client = MailchimpSubscriber.connect(@api_key)
    @list_name = "TestList"
    @list_id = @client.find_list_by_name(@list_name)["id"]
    @user = User.new
  end

  def test_new_subscriber_and_delete
    MailchimpSubscriber.subscribe @user, @list_name, :using => {:email => :email, :api_key => @api_key, :fields => {:FNAME => :first_name, :LNAME => :last_name}}
    success = @client.list_member_info(@list_id, [@user.email])["success"]
    assert_equal 1, success

    MailchimpSubscriber.unsubscribe(@user, @list_name, :using => {:email => :email, :api_key => @api_key, :fields => {:FNAME => :first_name, :LNAME => :last_name}})
    success = @client.list_member_info(@list_id, [@user.email])["success"]
    assert_equal 0, success

  end

end
