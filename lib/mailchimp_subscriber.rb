module MailchimpSubscriber
  require 'hominid'

  def subscribe_to(listname,options={})
    after_create do |record|
      begin
        email = record.send(options[:using][:email])
        content_type = options[:using][:content_type] || 'html'
        update_existing = options[:using][:update_existing] || false
        replace_interests = options[:using][:replace_interests] || false
        send_welcome = options[:using][:send_welcome] || false

        client = Hominid::API.new(mailchimp_api_key)
        list_id = h.find_list_by_name(listname)['id']
        client.list_subscribe(list_id, email, {}, type, double_optin, update_existing, replace_interests, send_welcome)
      rescue RuntimeError
      end
    end


  end
end
