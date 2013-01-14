#define PLUGIN_NAME    "No Leave"
#define PLUGIN_VERSION "1.0"
new Handle:AllowSpectators
public Plugin:myinfo =
{ name = PLUGIN_NAME, author = "Root", description = "Simply prevent player's leaving to spectator at round end", version = PLUGIN_VERSION, url = "http://dodsplugins.com/" }
public OnPluginStart()
{
	CreateConVar("blockspec_version", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_NOTIFY|FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED)
	AllowSpectators = FindConVar("mp_allowspectators")
	HookEvent("dod_round_win",   Event_round_end)
	HookEvent("dod_round_start", Event_round_start)
}
public Event_round_end(Handle:event, const String:name[], bool:dontBroadcast)   SetConVarBool(AllowSpectators, false)
public Event_round_start(Handle:event, const String:name[], bool:dontBroadcast) SetConVarBool(AllowSpectators, true)