# v2.0:

Features:
* The Garden Room is now 3 waves of bosses :white_check_mark: 
* 2 new Serpent variants :white_check_mark:
* New door aesthetic in the Garden :clock3:
* New Ladybug enemies in the garden (during wave 3) :clock3: (Clone of bats)
* 2 New items :clock3: (Deisgned below)
* 1 New transformation :white_check_mark:
* Debug flag - Test all of the items in room 1 :white_check_mark:
 
Fixes:
* Corrected Curse of Mortality making Donation and Reroll machines disappear :white_check_mark:
* Corrected Apple tears gfx not popping correctly :clock3:
* Corrected a rare situation where Harvest would enter a state where it would never proc again :white_check_mark:
* Corrected an issue where the player could not get 'My Beloved' from the Garden Room :white_check_mark:
* Corrected Serpent gibs :white_check_mark:
* Corrected costume overlays :white_check_mark:
* Corrected a situation where items removed from The Garden Pool would not be added back to the pool on new run :white_check_mark:

Balances:
* Adams damage changed from 14 to 10 :white_check_mark:
* Deception risk changed to 40% chance to negatively impact you, down from 50% :white_check_mark:
* Exiled gives players 2 Heart Containers, not 3 :white_check_mark:
* The Fall of Man rewards .5 damage per heart taken, down from 1.0 :white_check_mark:
* Harvest proc chance 5% -> 1.5%/Luck :white_check_mark:


|Name|Design|Item Art|Costume Art|Functionality|
|---|---|---|---|---|
|Crack The Earth|:white_check_mark:|:clock3:|:clock3:|:white_check_mark:|
|Legion|:white_check_mark:|:clock3:|No Costume|:white_check_mark:|
|Deceiver!|:white_check_mark:|Not needed|:clock3:|:white_check_mark:|


### Item Details
 * Crack The Earth
   * Effect: Every 10 frames, has a 2% chance per Luck to create an earth quake under a random enemy in the room, dealing strong damage. Excludes flying enemies and bosses.
   * Item Look: Black Feather (from a raven)
   * Costume: Isaac has a back cat's tail? (Similar to the Gnawed leaf Mario tail costume)

 * Legion
   * Effect: Isaac gains a demonic familiar (named Legion) that upon room entry, has a chance to spawn in the center of the room. Legion will fire a brimstone laser at enemies in the room until the room is clear.
   * Item Look: Large red Diamond (Blood DIamond)
   * Costume: Isaac has a deep purple glow behind his head with particles rising off, eyes become black
   * Details on Legions' look: 
     * Statanic, dark, demonic, floating
     * Use same sprite sheet as Adam (or Brother Bobby) -- I think? We need 8 directions, these only have 4
     * Should be around 30 pixels wide and tall. This is a big familiar and will help hide the starting position of the Brimstone laser.

 * Deceiver! (Transformation)
   * Effect: Killing enemies has a %5 chance to life steal (half heart)
   * Costume: Isaac is wearing a snake costume (http://tinyurl.com/zu3stcv).  This should not have legs, but instead a tail (like a mermaid)
   * Transformation is made up of 2 of the following items:
     * The Bible
     * Book of Revelations
     * Deception
     * The Fall of Man
