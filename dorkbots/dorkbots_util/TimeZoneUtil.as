package dorkbots.dorkbots_util
{
	public class TimeZoneUtil
	{
		/**
		 * List of timezone abbreviations and matching GMT times.
		 * Modified form original code at:
		 * http://blog.flexexamples.com/2009/07/27/parsing-dates-with-timezones-in-flex/
		 * */
		private static var timeZoneAbbreviations:Array = [
			/* Hawaii-Aleutian Standard/Daylight Time */
			{abbr:"HAST", dst:"HADT", zone:"UTC-1000"},
			/* Alaska Standard/Daylight Time */
			{abbr:"AKST", dst:"AKDT", zone:"UTC-0900"},
			/* Pacific Standard/Daylight Time */
			{abbr:"PST", dst:"PDT", zone:"UTC-0800"},
			/* Mountain Standard/Daylight Time */
			{abbr:"MST", dst:"MDT", zone:"UTC-0700"},
			/* Central Standard/Daylight Time */
			{abbr:"CST", dst:"CDT", zone:"UTC-0600"},
			/* Eastern Standard/Daylight Time */
			{abbr:"EST", dst:"EDT", zone:"UTC-0500"},
			/* Atlantic Standard/Daylight Time */
			{abbr:"AST", dst:"ADT", zone:"UTC-0400"},
			/* Newfoundland Standard/Daylight Time */
			{abbr:"NST", dst:"NDT", zone:"UTC-0330"},
			/* London Standard/Daylight Time */
			{abbr:"BST", dst:"GMT", zone:"UTC+0100"},
			{abbr:"GMT", dst:"GMT", zone:"UTC+0000"}
		];
		
		/**
		 * Return local system timzezone abbreviation.
		 * */
		public static function getTimeZone(min:int = 0, max:int = 0):String
		{
			var dst:Boolean = isObservingDST();
			
			return parseTimeZoneFromGMT(_getTimeZoneDesignation(dst, min, max), dst);
		}
		
		public static function getUTC():Number
		{
			var nowDate:Date = new Date();
			
			return nowDate.getTimezoneOffset() / 60;
		}
		/**
		 * Determines if local computer is observing daylight savings time for US and London.
		 * */
		public static function isObservingDST():Boolean
		{
			var winter:Date = new Date(2011, 01, 01); // after daylight savings time ends
			var summer:Date = new Date(2011, 07, 01); // during daylight savings time
			var now:Date = new Date();
			
			var winterOffset:Number = winter.getTimezoneOffset();
			var summerOffset:Number = summer.getTimezoneOffset();
			var nowOffset:Number = now.getTimezoneOffset();
			
			if( (nowOffset == summerOffset) && (nowOffset != winterOffset) ) 
			{
				return true;
			} 
			else 
			{
				return false;
			}	
		}
		
		/**
		 * Goes through the timze zone abbreviations looking for matching GMT time.
		 * */
		private static function parseTimeZoneFromGMT(gmt:String, dst:Boolean):String 
		{
			for each (var obj:Object in timeZoneAbbreviations) 
			{
				if(obj.zone == gmt)
				{
					if (dst)
					{
						return obj.dst;
					}
					else
					{
						return obj.abbr;
					}
				}
			}
			return gmt;
		}
		
		public static function getTimeZoneDesignation(min:Number = 0, max:Number = 0):String 
		{
			return _getTimeZoneDesignation(isObservingDST(), min, max);
		}
		
		/**
		 * Method to build UTC from date and timezone offset and accounting for daylight savings.
		 * */
		private static function _getTimeZoneDesignation(dst:Boolean = false, min:Number = 0, max:Number = 0):String 
		{
			var date:Date = new Date();
			
			var timeZoneAsString:String = "UTC";
			var timeZoneOffset:Number = date.getTimezoneOffset() / 60;
			
			if (dst)
			{
				timeZoneOffset += 1;
			}
			
			if (min != 0 || max != 0)
			{
				timeZoneOffset = Math.min(timeZoneOffset, max);
				timeZoneOffset = Math.max(timeZoneOffset, min);
			}
			
			// timezoneoffset is the number that needs to be added to the local time to get to UTC, so
			// a positive number would actually be UTC -X hours
			if ( timeZoneOffset > 0 && timeZoneOffset <= 12 ) 
			{
				if (timeZoneOffset < 10)
				{
					timeZoneAsString += "-0" + timeZoneOffset.toString();
				}
				else
				{
					timeZoneAsString += "-" + timeZoneOffset.toString();
				}
			} 
			else if ( timeZoneOffset < 0 && timeZoneOffset >= -12 ) 
			{
				if (timeZoneOffset > -10)
				{
					timeZoneAsString += "+0" + timeZoneOffset.toString();
				}
				else
				{
					timeZoneAsString += "+" + timeZoneOffset.toString();
				}
			} 
			else 
			{
				timeZoneAsString += "+00";
			}
			
			// add zeros to match standard format
			timeZoneAsString += "00";

			return timeZoneAsString;
		}
	}
}