package dorkbots.dorkbots_util
{
	
	/**
	 * The TwitterStringParser class assists with the parsing of a tweet to add hyperlinks 
	 * around Links, HashTags, and UserNames in a tweet.
	 * based on Joseph Labrecque's work - http://inflagrantedelicto.memoryspiral.com/2010/01/parsing-tweets-with-the-twitterstring-class/
	 */ 
	
	public class TwitterStringParser
	{
		private static var _instance:TwitterStringParser;
		
		public var textEvent:Boolean = false;
		public var userNameClass:String = "userName";
		public var hashtagClass:String = "hashtag";
		public var hyperlinkClass:String = "hyperlink";
		
		public function TwitterStringParser(pvt:PrivateClass)
		{
			
		}
		
		public static function get instance():TwitterStringParser
		{
			if (_instance)
			{
				return _instance;
			}
			else
			{
				_instance = new TwitterStringParser(new PrivateClass());
			}
			return _instance;
		}
		
		public function parseTweet(t:String):String 
		{
			var step1:String = parseHyperlinks(t);
			var step2:String = parseUsernames(step1);
			var step3:String = parseHashtags(step2);
			
			return step3;
		}
		
		private function parseUsernames(t:String):String 
		{
			var textEventString:String = (textEvent) ? "event:" : "";
			
			var result:String = t.replace(/(^|\s)@(\w+)/g, "$1@<a class='" + userNameClass + "' href='" + textEventString + "http://www.twitter.com/$2' target='_blank'>$2</a>");
			
			return result;
		}
		
		private function parseHashtags(t:String):String 
		{
			var textEventString:String = (textEvent) ? "event:" : "";
			
			var result:String = t.replace(/(^|\s)#(\w+)/g, "$1<a class='" + hashtagClass + "' href='" + textEventString + "https://twitter.com/hashtag/$2?src=hash' target='_blank'>#$2</a>");
			
			return result;
		}
		
		private function parseHyperlinks(t:String):String 
		{
			var textEventString:String = (textEvent) ? "event:" : "";
			
			var urlPattern:RegExp = new RegExp("(((f|ht){1}tp://)[-a-zA-Z0-9@:%_\+.~#?&//=]+)", "g");
			var result:String = t.replace(urlPattern, "<a class='" + hyperlinkClass + "' href='" + textEventString + "$1' target='_blank'>$1</a>");
			
			return result;
		}
		
	}
}

// this Private Class is only used to "jam" the param in the singleton constructor.  So only this singleton can instiate itself
class PrivateClass
{
	public function PrivateClass()
	{
	}
}