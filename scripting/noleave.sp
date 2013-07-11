/**
* No Leave by Root
*
* Description:
*   Simply prevent player's leaving to spectators at a round end.
*
* Version 1.0
* Changelog & more info at http://goo.gl/4nKhJ
*/

// ====[ CONSTANTS ]==============================================================
#define PLUGIN_NAME    "No Leave"
#define PLUGIN_VERSION "1.0"

// ====[ VARIABLES ]==============================================================
new Handle:mp_allowspectators = INVALID_HANDLE

// ====[ PLUGIN ]=================================================================
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
 * ------------------------------------------------------------------------------- */
public OnPluginStart()
{
	// Create ConVars
	CreateConVar("blockspec_version", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_NOTIFY|FCVAR_DONTRECORD)
	mp_allowspectators = FindConVar("mp_allowspectators")

	// Hook needed events that plugin using
	HookEvent("dod_round_win",   OnRoundEnd,   EventHookMode_PostNoCopy)
	HookEvent("dod_round_start", OnRoundStart, EventHookMode_PostNoCopy)
}

/* OnConfigsExecuted()
 *
 * When game configurations (e.g. map-specific configs) are executed.
 * ------------------------------------------------------------------------------- */
public OnConfigsExecuted()
{
	// If round was last (i.e. new round was not started), force mp_allowspectators to 1
	SetConVarBool(mp_allowspectators, true)
}

/* OnRoundEnd()
 *
 * When a round ends.
 * ------------------------------------------------------------------------------- */
public OnRoundEnd(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarBool(mp_allowspectators, false)
}

/* OnRoundStart()
 *
 * Called when a round starts.
 * ------------------------------------------------------------------------------- */
public OnRoundStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarBool(mp_allowspectators, true)
}