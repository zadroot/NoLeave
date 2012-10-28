/**
* No Leave by Root
*
* Description:
*   Simply prevent player's leaving to spectator at round end.
*
* Version 1.0
* Changelog & more info at http://goo.gl/4nKhJ
*/

// ====[ INCLUDES ]===============================================
#include <sourcemod>

// ====[ CONSTANTS ]==============================================
#define PLUGIN_NAME    "No Leave"
#define PLUGIN_VERSION "1.0"

// ====[ VARIABLES ]==============================================
new Handle:AllowSpectators = INVALID_HANDLE

// ====[ PLUGIN ]=================================================
public Plugin:myinfo =
{
	name        = PLUGIN_NAME,
	author      = "Root",
	description = "Simply prevent player's leaving to spectator at round end",
	version     = PLUGIN_VERSION,
	url         = "http://dodsplugins.com/"
}


/* OnPluginStart()
 *
 * When the plugin starts up.
 * --------------------------------------------------------------- */
public OnPluginStart()
{
	// Create convars
	CreateConVar("blockspec_version", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_NOTIFY|FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED)

	AllowSpectators = FindConVar("mp_allowspectators")

	// Hook events
	HookEvent("dod_round_win",   Event_round_end)
	HookEvent("dod_round_start", Event_round_start)
}

/* Event_round_end()
 *
 * When a round ends.
 * --------------------------------------------------------------- */
public Event_round_end(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarInt(AllowSpectators, false)
}

/* Event_round_start()
 *
 * Called when a round starts.
 * --------------------------------------------------------------- */
public Event_round_start(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarInt(AllowSpectators, true)
}