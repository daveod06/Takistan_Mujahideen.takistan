// move waypoint 500m towards LZ (CARELESS, FAST)
// move waypoint 450m from LZ (CARELESS, FAST) "this limitSpeed 160; this flyInHeight 25; this forceSpeed 160*_kph_to_mps;"
// move waypoint 160m from LZ (CARELESS, LIMITED) "this limitSpeed 50; this flyInHeight 25; this forceSpeed 50*_kph_to_mps;"
// transport_unload waypoint at LZ (CARELESS, FAST) "this LAND "land"; this limitSpeed 50; this flyInHeight 25; this forceSpeed 50*_kph_to_mps;" // wait for 3 sec after waypoint done
// move waypoint 200m from LZ (CARELESS, FAST)
// move waypoint 1km from LZ (CARELESS, FAST)

private _kph_to_mps = 0.277778;
