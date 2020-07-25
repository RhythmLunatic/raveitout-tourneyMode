local function pickRandomSong()
	local group = RIO_FOLDER_NAMES["DefaultArcadeFolder"]
	if not group then
		local groups = getAvailableGroups();
		local numGroups = #groups
		if numGroups > 1 then
			group = groups[math.random(numGroups)];
		else
			group = groups[1];
		end;
	end;
	local songs = SONGMAN:GetSongsInGroup(group);
	local randomSong = songs[math.random(#songs)]
	GAMESTATE:SetCurrentSong(randomSong);
	GAMESTATE:SetPreferredSong(randomSong);
	--assert(randomSong,"Attempted to get a valid song in group "..group.." and failed. Bad things will happen now.")
end;

SetUpMusicSelect = function()
	setenv("StageBreak",true);
	
	--I don't really like this but it's the RIO 'style'
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		--Don't force 3x and noteskins!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		GAMESTATE:ApplyGameCommand( "mod,30% mini;", pn );
	end
	GAMESTATE:ApplyGameCommand("applydefaultoptions;name,Pro;text,Pro;playmode,regular;difficulty,easy;screen,ScreenSelectMusic;setenv,PlayMode,Pro");
	-- Pro Mode
	setenv("HeaderTitle","SELECT MUSIC");
	
	--same as above
	local lastPlayedSong = PROFILEMAN:GetProfile(GAMESTATE:GetMasterPlayerNumber()):GetLastPlayedSong();
	if lastPlayedSong then
		local lastUsedGroup = lastPlayedSong:GetGroupName();
		if lastUsedGroup == RIO_FOLDER_NAMES["EasyFolder"] or lastUsedGroup == RIO_FOLDER_NAMES["SpecialFolder"] then
			pickRandom = true
		end;
	else
		--If there wasn't a last played song it probably doesn't exist anymore so pick random
		pickRandom = true;
	end;
	
	if pickRandom then
		pickRandomSong()
	else
		GAMESTATE:SetCurrentSong(lastPlayedSong);
	end;
	generateFavoritesForMusicWheel()
	PREFSMAN:SetPreference("AllowW1",'AllowW1_Everywhere');
	return "ScreenSelectMusic"
end;



Branch.AfterProfileLoad = function()
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		--ProfileFromMemoryCardIsNew checks if it's a memory card internally so no need to check additionally
		if PROFILEMAN:ProfileFromMemoryCardIsNew(pn) then
			return "ScreenNewProfileCustom"
		else
			--If it's an RFID scanned (local) profile
			if PROFILEMAN:IsPersistentProfile(pn) and PROFILEMAN:GetProfile(pn):GetTotalNumSongsPlayed() == 0 then
				return "ScreenNewProfileCustom"
			end;
		end;
	end;
	
	return SetUpMusicSelect();
end


