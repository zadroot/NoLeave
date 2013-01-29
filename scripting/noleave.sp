// ====[ INCLUDES ]====================================================
#include <sourcemod>

// ====[ CONSTANTS ]===================================================
#define PLUGIN_NAME    "No Leave"
#define PLUGIN_VERSION "1.0"

// ====[ VARIABLES ]===================================================
new Handle:mp_allowspectators = INVALID_HANDLE

// ====[ PLUGIN ]======================================================
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
 * --------------------------------------------------------------------- */
public OnPluginStart()
{
	// Create convars
	CreateConVar("blockspec_version", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_NOTIFY|FCVAR_PLUGIN|FCVAR_SPONLY)

	mp_allowspectators = FindConVar("mp_allowspectators")

	// Hook events
	HookEvent("dod_round_win", Event_round_end)
	HookEvent("dod_round_start", Event_round_start)
}

/* OnConfigsExecuted()
 *
 * When game configurations (e.g. map-specific configs) are executed.
 * --------------------------------------------------------------------- */
public OnConfigsExecuted()
{
	// If round was latest and new round wasn't started, force mp_allowspectators to 1
	SetConVarBool(mp_allowspectators, true)
}

/* Event_round_end()
 *
 * When a round ends.
 * --------------------------------------------------------------------- */
public Event_round_end(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarBool(mp_allowspectators, false)
}

/* Event_round_start()
 *
 * Called when a round starts.
 * --------------------------------------------------------------------- */
public Event_round_start(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarBool(mp_allowspectators, true)
}