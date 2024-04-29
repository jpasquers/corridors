class_name GlobalID


static var GID: int = 0;

static func next():
	GID+=1;
	return GID;
