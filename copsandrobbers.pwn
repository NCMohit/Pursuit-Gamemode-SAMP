//           ASh's CNR GameMode

#include <a_samp>

new Float:coppos = 2033.4949;
new Float:robpos = 2033.4888;
new copsize = 0;
new robsize = 0;
new cops[10];
new robbers[10];
new matchstart = 0;
new waittxt[20];

main()
{
	print("\n----------------------------------");
	print(" ASh's GameMode");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("CnR but with Cars");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(1, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(2, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(3, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(4, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(5, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(6, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	DisableInteriorEnterExits();
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid,1958.3783, 1343.1572, 15.3746);
	SetPlayerFacingAngle(playerid,90);
	SetPlayerCameraPos(playerid, 1951.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
    GameTextForPlayer(playerid,"ASh's CnR Pursuit",3000,4);
    waittxt[playerid] = CreatePlayerTextDraw(playerid, 320.0, 400.0, "Waiting for players");
    SetPlayerTime(playerid,0,0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(cops[playerid]){
		DestroyVehicle(cops[playerid]);
		copsize -= 1;
	}
	if(robbers[playerid]){
		DestroyVehicle(robbers[playerid]);
		robsize -= 1;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerInterior(playerid,17);
	SetPlayerPos(playerid,493.390991,-22.722799,1000.679687);
    SendClientMessage(playerid,0xFFFFFFFF,"To join any team: /joincop OR /joinrobbers");
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(cops[playerid]){
	    copsize -= 1;
	}
	if(robbers[playerid]){
	    robsize -= 1;
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(IsPlayerInAnyVehicle(playerid)){
	    SendClientMessage(playerid,0xFFFFFFFF,"You have already chosen cop/robber dumbass OR you cant type for shit");
	}
	else{
		if (strcmp("/joincop", cmdtext, true, 10) == 0)
		{
		    SetPlayerInterior(playerid,0);
			SendClientMessage(playerid,0xFFFFFFFF,"You have joined cops, your objective is to ram robbers. You also have double car health");
			SetPlayerPos(playerid,coppos,1348.7268,10.6719,179.9408);
			coppos += 3;
			cops[playerid] = CreateVehicle(490, coppos,1348.7268,10.6719,179.9408, -1, -1, -1);
			PutPlayerInVehicle(playerid, cops[playerid], 0);
            SetVehicleParamsEx(cops[playerid],0,0,0,0,0,0,0);
            SetVehicleHealth(cops[playerid],2000);
            AddVehicleComponent(cops[playerid],1010);
            SetPlayerColor(playerid, 0x7777DDFF);
            copsize +=1;
		}
		if(strcmp("/joinrobbers", cmdtext, true, 10) == 0){
		    SetPlayerInterior(playerid,0);
	        SendClientMessage(playerid,0xFFFFFFFF,"You have joined robbers, your objective is to run away from cops as long as possible");
	        SetPlayerPos(playerid,robpos,1312.7020,10.6719,179.9408);
	        robpos += 3;
	        robbers[playerid] = CreateVehicle(451, robpos,1312.7020,10.6719,179.9408, -1, -1, -1);
	        PutPlayerInVehicle(playerid, robbers[playerid], 0);
	        SetVehicleParamsEx(robbers[playerid],0,0,0,0,0,0,0);
	        SetPlayerColor(playerid, 0x77CC77FF);
			robsize +=1;
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT){
	    SendClientMessage(playerid,0xFFFFFFFF,"Don't leave the car dumbass");
	    if(cops[playerid]){
	        PutPlayerInVehicle(playerid, cops[playerid], 0);
		}
		if(robbers[playerid]){
		    PutPlayerInVehicle(playerid, robbers[playerid], 0);
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(matchstart == 0){
		if(copsize >=1 && robsize >=1){
		    PlayerTextDrawDestroy(playerid, waittxt[playerid]);
		    SendClientMessage(playerid,0xFFFFFFFF,"Match starting in 10 seconds !!!");
			SetTimerEx("Wait", 10000, false, "i", playerid);
			matchstart = 2;
		}
		else{
            PlayerTextDrawShow(playerid, waittxt[playerid]);
		}
	}
	if(matchstart == 1){
		if(robsize == 0 || copsize == 0){
		    RemovePlayerFromVehicle(playerid);
			DestroyVehicle(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid,0xFFFFFFFF,"Match has ended. !!!");
			SetPlayerHealth(playerid,0);
			copsize = 0;
			robsize = 0;
			matchstart = 0;
		}
	}
	return 1;
}
forward Wait(playerid);
public Wait(playerid)
{
	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
	SendClientMessage(playerid,0xFFFFFFFF,"Match Started !!!");
	if(cops[playerid]){
	    SetVehicleParamsEx(cops[playerid],1,0,0,0,0,0,0);
	}
	if(robbers[playerid]){
	    SetVehicleParamsEx(robbers[playerid],1,0,0,0,0,0,0);
	}
	matchstart = 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
