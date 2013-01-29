// ====[ INCLUDES ]====================================================
#include <sourcemod>

// ====[ CONSTANTS ]===================================================
#define PLUGIN_NAME    "No Leave"
#define PLUGIN_VERSION "1.0"

// ====[ VARIABLES ]===================================================
new Handle:g_AllowSpectators = INVALID_HANDLE

// ====[ PLUGIN ]======================================================
public Plugin:myinfo =
{
	name        = PLUGIN_NAME,
	author      = "Root",
	description = "Simply prevent player's leaving to spectator at round end",
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

	g_AllowSpectators = FindConVar("mp_allowspectators")

	// Hook events
	HookEvent("dod_round_win", Event_round_end)
	HookEvent("dod_round_start", Event_round_start)
}

/* OnMapStart()
 *
 * When the map starts.
 * --------------------------------------------------------------------- */
public OnMapStart()
{
	// If round was latest and new round wasn't started, force mp_allowspectators to 1
	SetConVarInt(g_AllowSpectators, true)
}

/* Event_round_end()
 *
 * When a round ends.
 * --------------------------------------------------------------------- */
public Event_round_end(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarBool(g_AllowSpectators, false)
}

/* Event_round_start()
 *
 * Called when a round starts.
 * --------------------------------------------------------------------- */
public Event_round_start(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarBool(g_AllowSpectators, true)
}