require 'telegram_bot'
require_relative 'text_str.rb'

bot = TelegramBot.new(token: token)

mode_reply_manually = 0


bot.get_updates(fail_silently: true) do |message|
	user_nam = message.from.username
	#puts message.message_id
	#puts message.date
  	# if message.text	
  	# 	puts "text!!"
  	# else
  	# 	puts "#{message.photo.file_id}"
  	# end
  	puts "@#{message.from.username} in #{message.chat.title}: #{message.text}"
  	command = message.get_command_for(bot)
  	#puts command
  	if command.to_s.length > 0
	  	message.reply do |reply|
		  	reply_state = 1;
		  	if mode_reply_manually == 0
			    case #command
			    when command == "/start"
			      reply.text = "Ciao a tutti io sono Borbobot!"
			    when command == "/saluta"
			    	if user_nam != "fra137" 
			      		reply.text = "#{greetings.sample.capitalize} #{message.from.first_name}!"
			  		else
			  			reply.text = "#{greetings.sample.capitalize}, Padrone!"
			  		end
			  	when command =="/help"
			  		reply.text = help_str
			  	when command.downcase.include?("insulta")
			  		if user_nam != "fra137"
			  			reply.text = "Si bestia, #{message.from.first_name}!"
			  		else
			  			reply_state = 0
			  		end
			  	when command.downcase.include_any?(saluti)
		  			reply.text = "#{saluti.sample.capitalize} #{message.from.first_name}!"
			  	when command.downcase.include?("borbobot")
			  		if user_nam == "i4mins"
			  			reply.text = "#{saluti.sample.capitalize} INS!"
			  		elsif user_nam == "RobiLeo95"
			  			reply.text = "#{saluti.sample.capitalize} Robertulla! Sono il tuo vero borbottino 😘"
			  		elsif user_nam == "giuliamalag"
			  			reply.text = "#{saluti.sample.capitalize} Giulietta! Che belle Caviglie che hai 😏"
			  		elsif user_nam == "Fabio_Dieli"
			  			reply.text = "Fabio, non posso essere il tuo borbottino 😔,
			  							 ma sono disposto a cederti le caviglie di Giulietta 🙃"
		  			elsif user_nam != "fra137"
		  				reply.text = "Tu non sei il mio Padrone, non prendo ordini da te!"
		  			else
		  				reply.text = "Si, sono qui! Ai tuoi ordini Padrone"
		  			end
		  		when command.downcase.include?("ins")
		  			reply.text = "INS! INS! INS! INS! INS!"
		  		when command == man_cont_command
		  			reply.text = "Manual Control Active"
		  			mode_reply_manually = 1
			    else # otherwise in case
			      #reply.text = "I have no idea what #{command.inspect} means."
			      reply_state = 0
		    	end # end case
			else #manual reply == 1
				puts "Manual reply now ⤵️"
				man_reply = gets.chomp
				if man_reply == man_cont_stop
					mode_reply_manually = 0
					reply_state = 0
				else
					reply.text = man_reply
				end
			end # end manual reply
		    if reply_state == 1 
		    	puts "sending #{reply.text.inspect} to @#{user_nam}"
		    	reply.send_with(bot)
		    end
	  	end #end reply loop

	end # if command.length > 0
  	#elsif message.audio
  	#	puts "message is audio"
  	#elsif message.photo
  	#	puts "message is image"
  	#else
  	#	puts "message is sometthing else"
  	#end	
end #get update message




