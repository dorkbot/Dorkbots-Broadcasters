/*
* Author: Dayvid jones
* http://www.dayvid.com
* Copyright (c) Superhero Robot 2016
* http://www.superherorobot.com
* Version: 1.0.0
* 
* Licence Agreement
*
* You may distribute and modify this class freely, provided that you leave this header intact,
* and add appropriate headers to indicate your changes. Credit is appreciated in applications
* that use this code, but is not required.
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

using System.Collections.Generic;
using System;

namespace Dorkbots.Broadcasters
{
	public class BroadcasterManager : IBroadcasterManager 
	{
		private Dictionary<string, IBroadcaster> broadcasterDictionary;

		public BroadcasterManager()
		{
			broadcasterDictionary = new Dictionary<string, IBroadcaster>();
		}

		public void BroadcastEvent(string eventName, object sender, object dataObject = null)
		{
			if (broadcasterDictionary.ContainsKey (eventName))
			{
				broadcasterDictionary [eventName].SendBroadcast (eventName, sender, dataObject);
			}
		}

		public void AddEventHandler(string eventName, EventHandler handler)
		{
			IBroadcaster broadcaster;
			if (!broadcasterDictionary.ContainsKey (eventName))
			{
				broadcaster = new Broadcaster ();
				broadcasterDictionary.Add (eventName, broadcaster);
			} 
			else
			{
				broadcaster = broadcasterDictionary [eventName];
			}
			// first remove the handler to make sure there are no duplicates
			broadcaster.BroadcastEvent -= handler;
			broadcaster.BroadcastEvent += handler;
		}

		public void RemoveEventHandler(string eventName, EventHandler handler)
		{
			if (broadcasterDictionary.ContainsKey (eventName))
			{
				broadcasterDictionary [eventName].BroadcastEvent -= handler;
			} 
		}

		public void RemoveAllEventHandlers()
		{
			foreach (IBroadcaster value in broadcasterDictionary.Values)
			{
				value.BroadcastEvent = null;
			}

			broadcasterDictionary = new Dictionary<string, IBroadcaster>();
		}
	}
}