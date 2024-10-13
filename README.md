# corridors


## Terminology

- Element = a modular piece or building block of the game world. Consists of:
	- Units = Anything that acts and is placable within the map
		- Enemies = Units that follow the path
		- Garrison = Units built by the player.
		- Terraform = Modifications to the map added by the player.
	
## Lore / Premise

Many years after Seth's fall from power at the hands of Horus,
he sets his gaze on a lowly consolation prize, the realm of the undead king osiris.

### Depiction of Duat
- Entrance At the mouth of the nile.
- Entrance through tomb
- Long corridors with stone statues
- Gates guarded by minor deities with enormous knives who required you say their name. - weird

### About Set
- lord of the red land (desert)

### Units

- Eye of horus -> gaze beam
- ibis (Thoth) -> line attack with beak?
- balance - spinning projectile
- lake of fire - passage hurts the enemies (dot?)
- basic enemy - ghost, "recruited dead"
- hyksos - canaanite + egyptian settlers, popularized the use of the composite bow
	- not the first bows, but better bows
- "minion of Heka" - Heka was the deification of magical power. could be the targeted magic spells.
- "essence of Ra" - Ra the sun god obvi. AOE dmg for sun power.

### Income

- Ankh - represents eternal life. Life pool?
- Ka - the soul, basic income from dmg.
- Heart for Ammit -> on enemy kill
	- "Divine hearts were devoured for their power" -> permanent upgrade on kill boss?

### Items

- simple whetstone - attack damage
- "Benu's amulet" - protects the heart.
- "Winged sun crest" - Attack speed.
- "Amenta" - symbol of the horizon. Range item.
- Headdress - range

### Boons

- "Wreath of vindication" - Given to people after weighing the heart
- "Coffer of the viper" - Nehebkau the snake god was part of the 'collector of souls'

### TODO list

- Item basics:
	Name, description, mini icon
	Interaction with unit stats
	Custom modifiers
	Items assigned to units - how
	Selected unit displays items
- Deployable sub type:
	rename deployable garrison
	build tab selector
	split out config
	abstract lister
	key bindings
- Top right: stats
	Health - basic -1 enemy escape
	Income - basic +1 dmg, +10 kill
- Mid right: shop
	Shop Icon visible always
	Click shop brings out shop
	Purchaseable config - units, items
- Eye of horus POC
	- incrementing beam damage.
	- art/animation
	- beam particle effects
	- enemy impact effects
- Hyksos POC
	- front swing, back swing. attack speed relation. gahhhh
	- archer
	- art/animation
	- particle start point
- Conscript POC
	- basic undead enemy
	- art/animation
	- death animation
- Top left: Menu
	Quit
	Settings

	

Credits:
	
- Crocodile demo art -> https://opengameart.org/content/crocodile-1
	- (just a link back to the site)
