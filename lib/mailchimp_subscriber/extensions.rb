module MailchimpSubscriber
  require 'hominid'
  attr_accessor :api_key, :email, :fields, :content_type, :double_optin, :update_existing, :replace_interests, :send_welcome, :delete_member, :send_goodbye, :send_notify

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def subscribe_to(list_name,options={})
      after_create do |record|
        begin
          MailchimpSubscriber.subscribe(record,list_name,options)
        rescue RuntimeError
        end
      end

      after_destroy do |record|
        begin
          MailchimpSubscriber.unsubscribe(record,list_name,options)
        rescue RuntimeError
        end
      end
    end
  end

  def self.connect(mailchimp_api_key)
    Hominid::API.new(mailchimp_api_key)
  end

  def self.parse_options(record,options)
    @api_key = options[:using][:api_key]
    @email = record.send(options[:using][:email])
    @fields = options[:using][:fields] ? options[:using][:fields].inject({}) { |h, (k, v)| h[k] = record.send(v); h } : {}
    @content_type = options[:using][:content_type] || 'html'
    @double_optin = options[:using][:double_optin] || false
    @update_existing = options[:using][:update_existing] || true
    @replace_interests = options[:using][:replace_interests] || false
    @send_welcome = options[:using][:send_welcome] || false
    @delete_member = options[:using][:delete_member] || true
    @send_goodbye = options[:using][:send_goodbye] || false
    @send_notify = options[:using][:send_notify] || false
  end

  def self.subscribe(record,list_name,options)
    parse_options(record, options)
    client = connect(@api_key)
    list_id = client.find_list_by_name(list_name)['id']
    client.list_subscribe(list_id, @email, @fields, @content_type, @double_optin, @update_existing, @replace_interests, @send_welcome)
  end

  def self.unsubscribe(record,list_name,options)
    parse_options(record, options)
    client = connect(@api_key)
    list_id = client.find_list_by_name(list_name)["id"]
    client.list_unsubscribe(list_id, @email, @delete_member, @send_goodbye, @send_notify)
  end

end
