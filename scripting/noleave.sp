#pragma semicolon 1 // We like semicolons.

// ====[ INCLUDES ]====================================================
#include <sourcemod>

// ====[ CONSTANTS ]===================================================
#define PLUGIN_NAME			"Prevent leaving at round end"
#define PLUGIN_AUTHOR		"Root"
#define PLUGIN_DESCRIPTION	"Simply prevent player's leaving to spectator at round end"
#define PLUGIN_VERSION		"1.0"
#define PLUGIN_CONTACT		"http://www.dodsplugins.com/"

// ====[ VARIABLES ]===================================================
new Handle:g_ConVar_Version,
	Handle:g_AllowSpectators = INVALID_HANDLE;

// ====[ PLUGIN ]======================================================
public Plugin:myinfo =
{
	name			= PLUGIN_NAME,
	author			= PLUGIN_AUTHOR,
	description		= PLUGIN_DESCRIPTION,
	version			= PLUGIN_VERSION,
	url				= PLUGIN_CONTACT
};

/* OnPluginStart()
 *
 * When the plugin starts up.
 * --------------------------------------------------------------------- */
public OnPluginStart()
{
	// Create convars
	g_ConVar_Version = CreateConVar("blockspec_version", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_NOTIFY|FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED);

	g_AllowSpectators = FindConVar("mp_allowspectators");

	// Hook events
	HookEvent("dod_round_win", Event_round_end);
	HookEvent("dod_round_start", Event_round_start);
}

/* OnMapStart()
 *
 * When the map starts.
 * --------------------------------------------------------------------- */
public OnMapStart()
{
	// If round was latest and new round wasn't started, force mp_allowspectators to 1
	SetConVarInt(g_AllowSpectators, true);

	// Work around A2S_RULES bug in linux orangebox
	SetConVarString(g_ConVar_Version, PLUGIN_VERSION);
}

/* Event_round_end()
 *
 * When a round ends.
 * --------------------------------------------------------------------- */
public Event_round_end(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarInt(g_AllowSpectators, false);
}

/* Event_round_start()
 *
 * Called when a round starts.
 * --------------------------------------------------------------------- */
public Event_round_start(Handle:event, const String:name[], bool:dontBroadcast)
{
	SetConVarInt(g_AllowSpectators, true);
}