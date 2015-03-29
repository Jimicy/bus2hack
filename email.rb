require 'mandrill'

def send_email(name,email,link)
	mandrill = Mandrill::API.new 'Vrj1cfKddBFaYZRKTePcIw'

	puts "aaa"
    message = {"tags"=>["password-resets"],
    "subject"=>"Confirm hackathon attendance!",

     "from_email"=>"noreply@bus2hack.com",
     "from_name"=>"The hack2bus team",
     "merge_language"=>"mailchimp",

     "global_merge_vars"=>[{"name"=>"merge1", "content"=>"merge1 content"}],
     "merge"=>true,
     "to"=>
        [{"name"=>"#{name}",
            "type"=>"to",
            "email"=>"#{email}"}],
     #"metadata"=>{"website"=>"www.example.com"},
     #"preserve_recipients"=>nil,
     "html"=>"<h2>Follow this link to confirm your attendance!</h2> <br><center>#{link}</center>"}
    async = false
    ip_pool = "Main Pool"
    result = mandrill.messages.send message, async, ip_pool 
        # [{"email"=>"recipient.email@example.com",
        #     "_id"=>"abc123abc123abc123abc123abc123",
        #     "reject_reason"=>"hard-bounce",
        #     "status"=>"sent"}]
rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'    
    raise
end

#send_email("George","gplukov@gmail.com", "www.aaa.com")
