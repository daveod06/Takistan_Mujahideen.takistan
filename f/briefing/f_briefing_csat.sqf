// F3 - Briefing
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// FACTION: CSAT

// ====================================================================================

// NOTES: MISSION
// The code below creates the mission sub-section of notes.

_mis = player createDiaryRecord ["diary", ["Mission","
<br/>
Maintain complete control of Takistan, especially the military outposts.
Stamp out any opposition with brutality.
"]];

// ====================================================================================

// NOTES: SITUATION
// The code below creates the situation sub-section of notes.

_sit = player createDiaryRecord ["diary", ["Situation","
<br/>
We've occupied the cites and towns of Takistan for months now. With this strategic
victory, our main force is finally ready to rout the Muslim insurgency in the countryside. 
We must maintain complete dominance of Takistan to support our
much, much larger goals.
<br/><br/>
ENEMY FORCES
<br/>
Civilian militia pests have been conducting small guerilla attacks in the
south near <marker name='TAOR_BLU_GIRNA'>Girna</marker> and 
<marker name='TAOR_BLU_IOANNIS'>Agios Ioannis</marker>.
<br/><br/>
FRIENDLY FORCES
<br/>
We occupy nearly every civilian town and military outpost on this island.
We have nearly 1000 men waiting in reserves that will move on Altis soon.
"]];

// ====================================================================================
