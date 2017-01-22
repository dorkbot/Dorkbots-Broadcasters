Dorkbots-Broadcasters
=================

Dorkbots Broadcasters is a flexible framework for adding and remove listeners to any object and passing objects in the event handler's parameter. 

C# - Includes an object for broadcasting events to classes and a manager class to attach multiple events.

The AS3 version - Includes a strict state update and declaration system for use in an observer pattern. Lighter than Flash’s Events and doesn’t bubble. It’s not a replacement for Flash’s event system, but a lighter option for use outside of the Display List.

http://www.dorkbots.com/repositories/broadcasters

Author: Dayvid jones<br>
http://www.dayvid.com<br>
Copyright (c) Superhero Robot 2017<br>
http://www.discoblimp.com

For now you can see an example at the Dorkbots Grid framework -<br> http://dorkbots.com/repositories/grid/index.html

Look at this file -<br>
https://github.com/dorkbot/Dorkbots-Grid/blob/master/Example/Assets/Scripts/Game/Controller.cs<br> Look at the Start method, there you will see an example of the Dorkbots Broadcasters being used. And the Event Handler “PlayerMovedEvent” method shows how to handle an event.

Look at this file -<br>
https://github.com/dorkbot/Dorkbots-Grid/blob/master/Example/Assets/Scripts/Game/GameEntity.cs<br>
In the "InternalStart" method you will see Event Handlers added to events. And below you will find examples of handling and digesting an event.

Look at this file -<br>
https://github.com/dorkbot/Dorkbots-Grid/blob/master/Example/Assets/Scripts/Util/Dorkbots/WorldGrid/GridCellEntity.cs<br>
In the "Awake" method you will see a BroadcasterManager being setup. The method "Interact" shows an event being broadcasted. And the Struct "EntityInteractionEventObject" is an example of attaching a typed DataObject to the Event Data Object.