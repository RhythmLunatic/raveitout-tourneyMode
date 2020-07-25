return Def.ActorFrame{
	LoadFont("common normal")..{
		Text=SysInfo["InternalName"]..":"..SysInfo["Version"];
		InitCommand=cmd(xy,5,5;horizalign,left;vertalign,top;zoom,.5;Stroke,Color("Black"));
	};
	LoadFont("common normal")..{
		InitCommand=cmd(xy,5,15;horizalign,left;vertalign,top;zoom,.5;Stroke,Color("Black"));
		OnCommand=function(self)
			local aspectRatio = round(GetScreenAspectRatio(),2);
			if aspectRatio == 1.78 then
				self:settext("DISPLAY TYPE: HD");
			elseif aspectRatio == 1.33 then
				self:settext("DISPLAY TYPE: SD");
			else
				self:settext("DISPLAY TYPE: ???");
			end;
		end;
	};
	LoadFont("common normal")..{
		InitCommand=cmd(xy,5,25;horizalign,left;vertalign,top;zoom,.5;Stroke,Color("Black"));
		Text=string.format("TOURNAMENT MODE [%i HEARTS]",HeartsPerPlay);
	};
	LoadFont("common normal")..{
		InitCommand=cmd(xy,5,35;horizalign,left;vertalign,top;zoom,.5;Stroke,Color("Black"));
		Text=string.upper(THEME:GetString("OptionTitles","LifeDifficulty"))..": "..GetLifeDifficulty();
	};
	
	-- Memory cards
	
	LoadActor(THEME:GetPathG("", "USB icon"))..{
		InitCommand=cmd(horizalign,left;vertalign,bottom;xy,SCREEN_LEFT+5,SCREEN_BOTTOM;zoom,.2);
		OnCommand=cmd(visible,ToEnumShortString(MEMCARDMAN:GetCardState(PLAYER_1)) == 'ready');
		StorageDevicesChangedMessageCommand=cmd(playcommand,"On");
	};
	
	LoadActor(THEME:GetPathG("", "USB icon"))..{
		InitCommand=cmd(horizalign,right;vertalign,bottom;xy,SCREEN_RIGHT-5,SCREEN_BOTTOM;zoom,.2);
		--OnCommand=cmd(visible,true);
		OnCommand=cmd(visible,ToEnumShortString(MEMCARDMAN:GetCardState(PLAYER_2)) == 'ready');
		StorageDevicesChangedMessageCommand=cmd(playcommand,"On");
	};

};
