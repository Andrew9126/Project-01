/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots *
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/
VAR time = -1
VAR keycard = 0
VAR proomenter = 1
VAR oroomenter = 1
VAR prisonkey = 0
VAR blankets = 0
VAR hammer = 0
VAR fuse = 0

-> hallway
== hallway ==
"WELCOME PLAYER, TO THE ESCAPE ROOM!"
Before you is a dimmly lit hallway, containing a door on your left and right.
This choice cannot be undone, and will determine your journey.
What fate will you choose?
* [Choose the Right Door] -> prison_room
* [Choose the Left Door] -> office_room
-> END

== prison_room ==
{proomenter == 1: As you enter the room, you appear to be behind bars of a prison cell. The door you came through quickly locks behind you with a loud clang sound.}
Infront of you is a bed, a toilet, a barred window, and the cell door which leads to a hallway.
Where would you like to investigate?
+ [Approach the Bed] -> prison_bed
+ [Approach the Toilet] -> prison_toilet
+ [Approach the Window] -> prison_window
+ [Approach Cell Door] -> cell_door
-> END
== cell_door ==
~ proomenter = proomenter - 1
The door appears to be restricted by a simple lock and a pair of wood boards nailed down horizontally.
{prisonkey == 2: The lock has been taken care of, as you already used the key.}
{hammer == 2: The boards have been taken down, as you used the hammer.}

* {hammer == 1} [Use Hammer] -> broken_boards
* {prisonkey == 1} [Use Key] -> unlock_prison_door
+ {prisonkey == 2 && hammer == 2} [Open Cell Door] -> prison_hallway
+ [Return to Center] -> prison_room

-> END
== broken_boards ==
~ hammer = hammer + 1
You tear down the boards with your hammer, freeing the door from the restriction.
* [Return to Door] -> cell_door
-> END
== unlock_prison_door ==
~ prisonkey = prisonkey + 1
As you insert and turn the key, the door unlocks with a swift click.
* [Return to Door] -> cell_door
== prison_bed ==
~ proomenter = proomenter - 1
A plain, uncomfortable looking bed lies infront of you, clearly untouched for some time now. There's a pillow{blankets == 0: and a blanket} on the bed.

* [Move Pillow] -> key_discovery
* [Take Blanket] -> blanket_get
+ [Return to Center] -> prison_room
-> END
== key_discovery ==
~ prisonkey = prisonkey + 1
Under the pillow you find a key! Maybe this can be used to escape?
* [Return to Bed] -> prison_bed
-> END
== blanket_get ==
~ blankets = blankets + 1
You pick up the blanket and add it to your collection of items. You child.
* [Return to Bed] -> prison_bed
-> END
== prison_toilet ==
~ proomenter = proomenter - 1
A normal looking toilet with a strange oder. Best to leave it be.

* [Check behind the Toilet] -> behind_toilet
+ [Return to Center] -> prison_room
-> END
== behind_toilet ==
~ hammer = hammer + 1
Behind the toilet you spot a lone hammer, just sitting there.
You add it to your collection.

* [Return to Center] -> prison_room
-> END
== prison_window ==
~ proomenter = proomenter - 1
A simple window restrained by metal bars, offering dim moonlight to flood the room.
You can spot a metal object ontop of the window sill.
* [Pickup Object] -> fuse_pickup2
+ [Return to Center] -> prison_room
-> END
== fuse_pickup2 ==
~ fuse = fuse + 1
You collected a fuse.
+ [Return to Center] -> prison_room
-> END
== prison_hallway ==
Finally free from the cell, you enter the hallway to the prison. You can see a door at the end of the hallway, as well as a table halfway down the corridor.

* [Look Down?] -> hallway_fuse
* [Approach the Table] -> hallway_table
+ [Approach the Exit] -> prison_exit
+ [Return to the Room] -> prison_room
-> END
== hallway_fuse ==
~ fuse = fuse + 1
You look down at your feet, and spot a fuse nearby! What are the odds?
You collect the fuse.
+ [Return to Hallway] -> prison_hallway
-> END
== hallway_table ==
At the small table, you see a lamp and a fuse laying on the table.
* [Pick up fuse] -> fuse_pickup
-> END
== fuse_pickup ==
~ fuse = fuse + 1
You collected a fuse.
+ [Return to Hallway] -> prison_hallway
-> END
== prison_exit ==
The door displays a basic "EXIT" sign above itself, glowing in green.
You try pushing on the door, but it doesn't budge.
To the right of the door you see an empty fuse box with 3 slots.
You have put {fuse} fuses into the box.

* {fuse == 3} [Open Exit Door] -> prison_escape
+ [Return to Hallway] -> prison_hallway
-> END
== prison_escape ==
Congratulations! You have successfully escaped the Prison Escape Room!
-> END


== office_room ==
{oroomenter == 1: As you enter the room, you find yourself in a simple office space, with a standard desk set up. The door you came through swiftly closes behind you with a smooth click.}
As you scan your surrondings, you can see a desk, clock, and a door that has a green glowing "EXIT" sign above it.
The clock is constantly ticking. There is no escaping the clock's infinite march forwards through time.
Where would you like to investigate?

+ [Approach the Desk] -> office_desk
+ [Approach the Clock] -> office_clock
+ [Approach the Exit] -> office_exit
-> END
== office_desk ==
~ oroomenter = oroomenter - 1
The desk seems to have a single drawer. You try to open it but it seems firmly locked.
There is also a paper on the desk. It reads:
"NOTICE TO NIGHT CREW: You will only be able to access your nighttime keycard at MIDNIGHT. The drawer will stay locked otherwise for the protection of the companies' goods. Glory to the company!"

* {time == 2} [Open Drawer] -> keycard_get
+ [Return to Center] -> office_room
-> END
== keycard_get ==
~ keycard = keycard + 1
The drawer pops open and inside you find a keycard! Maybe this will work on the door?
+ [Return to Center] -> office_room
-> END
== office_clock ==
~ oroomenter = oroomenter - 1
As you approach the clock, the ticking gets significantly louder.
With the droning ticks echoing throughout your head, you can make out "{advance_time()}" on the clock face.
{time == 2: It seems to be the correct time for the drawer to open. You should go check it out.}
{keycard == 1: Returning with keycard in hand, you seem to find a strange box that didn't look like it was there before on the wall to your left.}
+ {keycard == 1} [Investigate Box] -> office_upgrade
+ [Return to Center] -> office_room
-> END
== office_upgrade ==
Looking closely, the box appears to fit a keycard inside, and reads "SECURITY UPGRADE"
* [Slot the Keycard] -> keycard_upgrade
-> END
== keycard_upgrade ==
~ keycard = keycard + 1
The keycard inserts with a click, and pops back out swiftly. It should now be upgraded to the standard security bypass level.
+ [Return to Center] -> office_room
-> END
== office_exit ==
~ oroomenter = oroomenter - 1
Infront of you lies the Exit door. It seems simply shut by a keycard reader, a standard method of security.
{keycard == 1: The keycard doesn't seem to work on the door. Perhaps you have the wrong one? Try looking around some more.}
* {keycard == 2} [Use Keycard] -> office_escape
+ [Return to Center] -> office_room
-> END
== office_escape ==
Congratulations! You have successfully escaped the Office Escape Room!
-> END
== function advance_time ==

    ~ time = time + 1
    
    {
        - time > 2:
            ~ time = 0
    }    
    
    {    
        - time == 0:
            ~ return "12 PM"
        
        - time == 1:
            ~ return "6 PM"
        
        - time == 2:
            ~ return "12 AM"
    
    }
    
    
        
    ~ return time
    




