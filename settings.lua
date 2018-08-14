-- CONFIG FILE --
iCountsWarning 				= 5;
iFovCheckOnCamera 			= 1;

bSimulatePlayers 			= true; -- simulating players on stream. BAD: CPedPool (Memory Address: 0x00B7CD98)
bSimulateVehicles 			= true; -- simulating vehicles on stream. BAD: CPedPool (Memory Address: 0xC502AA0)
bCheckAdmins				= true; -- system checking players on hack (shader! invisible players!) /checkwh (nick)
bCheckOnCamera 				= true; -- warnings for admins if player from wall of aimed on player
bCheckOnFiring 				= true; -- warnings (+iCountsWarning counts!) for admins, if warnings > 5 = ban on week. If player from wall firing of on player
-- END