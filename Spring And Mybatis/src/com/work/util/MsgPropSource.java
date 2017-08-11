package com.work.util;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;

@Component
public class MsgPropSource
{	
	private static MessageSource messageSource;
	
	@Autowired
	public void setMessageSource(MessageSource messageSource){
		MsgPropSource.messageSource=messageSource;
	}
	
	public static String getMessage(String key){
		return messageSource.getMessage(key,null,null);
	}

	public static String getMessage(String key,Object obj[]){
		return messageSource.getMessage(key,obj,Locale.SIMPLIFIED_CHINESE);
	}
}


