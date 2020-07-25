return Def.ActorFrame{
	Def.Sprite{
		Texture=THEME:GetPathG("","PlayModes/splash/Pro" );
		InitCommand=cmd(diffusealpha,0;Center;Cover;);
		OffCommand=function(self)
			self:decelerate(0.5)
			:diffusealpha(1);
		end;
	};
};
