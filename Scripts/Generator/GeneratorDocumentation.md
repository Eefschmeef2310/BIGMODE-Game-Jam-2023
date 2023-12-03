# Tom's Modular Procedural Generator!

Just thought i'd put this together incase you want to mess around with the 
generator, add new modules, ect ect ect...
The Generator is up of two main components:
	1) The ModuleManager which is called each time a new module needs to be 
	created
	2) At least 1 "Module"

## Module Manager
Setup:
	1) Place module manager in scene
	2) Fill Modules array with all of the Modules in PackedScene format 
	3) Place the first module in the scene as a child of the ModuleManager

### Functions
GenerateNextModule(spawnPos:Vector2):
	Generaes a module selected at random from the "Modules" array and places
	it at the given spawnPos coordinates 

### Signals
moduleGenerated:
	Emmitted every time GenerateNextModule() is run 


## Module
At its core each module is made up of content and its connector
The content should be the visible level, the connector is a node with a
VisibleOnScreenNotifier2D as a child.
The Module script waits for the connector to be (almost) visible onscreen before
it calls the ModuleManager to generate the next module 
