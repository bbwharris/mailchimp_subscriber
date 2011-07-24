require 'rails'

module MailchimpSubscriber
  class Railtie < ::Rails::Railtie
    initializer 'mailchimp_subscriber' do |app|
      require 'mailchimp_subscriber/extensions'
      ::ActiveRecord::Base.send :extend, MailchimpSubscriber::ClassMethods
    end
  end
end
