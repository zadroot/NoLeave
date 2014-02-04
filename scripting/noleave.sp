/**
* No Leave by Root
*
* Description:
*   Simply prevent player's leaving to spectators at a round end.
*
* Version 1.0
* Changelog & more info at http://goo.gl/4nKhJ
*/

// ====[ CONSTANTS ]=================================================
#define PLUGIN_NAME    "No Leave"
#define PLUGIN_VERSION "1.0"

// ====[ VARIABLES ]=================================================
new Handle:mp_allowspectators = INVALID_HANDLE;

// ====[ PLUGIN ]====================================================
public Plugin:myinfo =
{
	name        = PLUGIN_NAME,
	author      = "Root",
	description = "Simply prevent player's leaving to spectators at a round end",
	version     = PLUGIN_VERSION,
	url         = "http://www.dodsplugins.com/"
}


/* OnPluginStart()
 *
 * When the plugin starts up.
 * ------------------------------------------------------------------ */
public OnPluginStart()
{
	CreateConVar("blockspec_version", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_NOTIFY|FCVAR_DONTRECORD);
	mp_allowspectators = FindConVar("mp_allowspectators");

	// Hook required plugin events
	HookEvent("dod_round_win",   OnRoundEvents, EventHookMode_PostNoCopy);
	HookEvent("dod_round_start", OnRoundEvents, EventHookMode_PostNoCopy);
}

/* OnConfigsExecuted()
 *
 * When game configurations (e.g. map-specific configs) are executed.
 * ------------------------------------------------------------------ */
public OnConfigsExecuted()
{
	// If round was latest (i.e. new round has not started after winning) force mp_allowspectators to 1
	SetConVarBool(mp_allowspectators, true);
}

/* OnRoundEvents()
 *
 * When a round starts or ends.
 * ------------------------------------------------------------------ */
public OnRoundEvents(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarBool(mp_allowspectators, (name[10] == 's') ? true : false); // Hack
}