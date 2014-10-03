/*
* Author: Dayvid jones
* http://www.dayvid.com
* Copyright (c) Disco Blimp 2013
* http://www.discoblimp.com
* Version: 1.0.3
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
package dorkbots.dorkbots_commands
{
	import flash.errors.IllegalOperationError;
	
	import dorkbots.dorkbots_broadcasters.IBroadcastedEvent;
	
	// ABSTRACT CLASS (should be subclassed and not instantiated)
	public class AbstractCommands extends Command implements ICommands
	{
		protected var commands:Vector.<ICommand> = new Vector.<ICommand>();
		protected var currentCommandIndex:uint = 0;
		protected var startIndex:uint = 0;
		
		public function AbstractCommands()
		{
			super();
		}
		
		override protected function initAbstract(object:Object=null):void
		{
			
		}
		
		public final function get length():uint
		{
			return commands.length;
		}
		
		public final function addCommand(command:ICommand, position:int = -1):ICommand
		{
			if (position > -1)
			{
				if (position >= commands.length) position = commands.length;
				commands.splice(position, 0, command);
			}
			else
			{
				commands.push(command);
			}
			
			return command;
		}
		
		public final function getCommandFromPostion(position:uint):ICommand
		{
			return commands[position];
		}
		
		public final function getCommandFromName(aName:String):ICommand
		{
			var returnCommand:ICommand;
			var currentCommand:ICommand;
			
			for (var i:int = 0; i < commands.length; i++) 
			{
				currentCommand = commands[i];
				if (currentCommand.name == aName)
				{
					if (returnCommand) 
					{
						throw new Error("More than one command shares this name!!!!!!");
					}
					else
					{
						returnCommand = currentCommand;
					}
				}
			}
			
			return returnCommand;
		}
		
		public final function getCommandsPosition(command:ICommand):int
		{
			var postion:int = -1
			
			for (var i:int = 0; i < commands.length; i++) 
			{
				if (commands[i] == command)
				{
					if (postion > -1) 
					{
						throw new Error("More than one instance of this command was found!!!!!!");
					}
					else
					{
						postion = i;
					}
				}
			}
			
			return postion;
		}
		
		public final function removeCommand(command:ICommand):void
		{
			var index:int = commands.indexOf(command);
			while(index > -1)
			{
				commands.splice(index, 1);
				index = commands.indexOf(command);
			}
		}
		
		public final function disposeOfCommand(command:ICommand):void
		{
			command.removeEventListener(CommandEvents.COMPLETE, commandComplete);
			command.dispose();
			removeCommand(command);
		}
		
		override protected function executeAbstract():void
		{
			currentCommandIndex = 0;
			startIndex = 0;
			
			if (commands.length > 0)
			{
				executeCommand();
			}
			else
			{
				commandsCompleted();
			}
		}
		
		// ABSTRACT METHOD (must be overridden in a subclass)
		protected function executeCommand():void
		{
			throw new IllegalOperationError("Abstract method!!!!");
		}
		
		// ABSTRACT METHOD (must be overridden in a subclass)
		protected function commandComplete(event:IBroadcastedEvent):void
		{
			throw new IllegalOperationError("Abstract method!!!!");
		}
		
		protected final function commandsCompleted():void
		{
			broadcastEvent(CommandEvents.COMPLETE);
		}
		
		override protected function stopAbstract(complete:Boolean = false):void
		{
			for (var i:uint = 0; i < commands.length; i++)
			{
				commands[i].stop(complete);
				commands[i].removeEventListener(CommandEvents.COMPLETE, commandComplete);
			}
		}
		
		override public final function dispose():void
		{
			for (var i:uint = 0; i < commands.length; i++)
			{
				commands[i].removeEventListener(CommandEvents.COMPLETE, commandComplete);
				commands[i].dispose();
			}
			
			commands.length = 0;
			
			super.dispose();
		}
	}
}