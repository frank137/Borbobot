# -*- coding: utf-8 -*-

from telegram.ext import Updater
from text_str import *
from pprint import pprint
import datetime


updater = Updater(token=TOKEN)

dp = updater.dispatcher

from telegram.ext import CommandHandler
from telegram.ext import MessageHandler, Filters
import logging
logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                    level=logging.INFO)


########### Utilitites 
# Resolve message data to a readable name 	 		
def get_name(user):
        try:
            name = user.first_name
        except (NameError, AttributeError):
            try:
                name = user.username
            except (NameError, AttributeError):
                logger.info("No username or first name.. wtf")
                return	""
        return name


################################# Functions

def start(bot, update):
    bot.send_message(chat_id=update.message.chat_id, text="I'm a bot, please talk to me!")

def echo(bot, update):
	username = update.message.from_user.username 
	user_id = update.message.from_user.id 
	message_id = update.message.message_id 
	chat_id = update.message.chat.id

	if username != None:
		message = username+': '+update.message.text
		pprint(str(chat_id)+" - "+str(message))
	
		name = get_name(update.message.from_user)
		timestamp = datetime.datetime.utcnow()

		info = { 'user_id': user_id, 'chat_id': chat_id, 'message_id':message_id, 'message': message, 'timestamp': timestamp }
		#db.natalia_textmessages.insert(info)

		info = { 'user_id': user_id, 'name': name, 'username': username, 'last_seen': timestamp }
		#db.users.update_one( { 'user_id': user_id }, { "$set": info }, upsert=True)
	else:
		print("Person chatted without a username")

def caps(bot, update, args):
    text_caps = ' '.join(args).upper()
    bot.send_message(chat_id=update.message.chat_id, text=text_caps)

def unknown(bot, update):
    bot.send_message(chat_id=update.message.chat_id, text="Sorry, I didn't understand that command.")

start_handler = CommandHandler('start', start)
dp.add_handler(start_handler)

echo_handler = MessageHandler(Filters.text, echo)
dp.add_handler(echo_handler)

caps_handler = CommandHandler('caps', caps, pass_args=True)
dp.add_handler(caps_handler)

unknown_handler = MessageHandler(Filters.command, unknown)
dp.add_handler(unknown_handler)



updater.start_polling()
print(updater.running)
#test