--[[
	Game GMMoveBattle LUA script
--]]


-- Global instance
luaGMMoveBattle = {};

-- ShowGMMoveBattleTab
function luaGMMoveBattle:ShowGMMoveBattleTab()
	
	--gamedebug:Log( "Å×½ºÆ®" );
	
	pnlMoveBattleMain:Show( true );
	
end

-- HideGMMoveBattleTab
function luaGMMoveBattle:HideGMMoveBattleTab()
	
	pnlMoveBattleMain:Show( false );
	
end

-- KillMe
function luaGMMoveBattle:KillMe()
	
	gamefunc:KillMe();
	
end

-- Rebirth
function luaGMMoveBattle:Rebirth()
	
	gamefunc:Rebirth();
	
end

-- ResetAllCoolTime
function luaGMMoveBattle:ResetAllCoolTime()
	
	gamefunc:ResetAllCoolTime();
	
end

-- ItemRepairAll
function luaGMMoveBattle:ItemRepairAll()
	
	gamefunc:ItemRepairAll();
	
end

-- OnLoadededtGMBattle_HPRecover
function luaGMMoveBattle:OnLoadededtGMBattle_HPRecover()
	
	local hpmax		= gamefunc:GetMaxHP();
	edtGMBattle_HPRecover:SetText( hpmax );	
end

-- OnLoadededtGMBattle_MPRecover
function luaGMMoveBattle:OnLoadededtGMBattle_MPRecover()
	
	local hpmax		= gamefunc:GetMaxEN();
	edtGMBattle_MPRecover:SetText( hpmax );	
end

-- OnLoadededtGMBattle_SPRecover
function luaGMMoveBattle:OnLoadededtGMBattle_SPRecover()
	
	local hpmax		= gamefunc:GetMaxSTA();
	edtGMBattle_SPRecover:SetText( hpmax );	
end

-- OnClickHPRecorver
function luaGMMoveBattle:OnClickHPRecorver()
	
	local hp	= edtGMBattle_HPRecover:GetText();
	if( ( nil == hp ) or ( "" == hp ) )	then
		return ;
	end
	
	gamefunc:OnGMSetMe( "hp", hp );
	
end

-- OnClickMPRecorver
function luaGMMoveBattle:OnClickMPRecorver()
	
	local mp	= edtGMBattle_MPRecover:GetText();
	if( ( nil == mp ) or ( "" == mp ) )	then
		return ;
	end
	
	gamefunc:OnGMSetMe( "ep", mp );

end

-- OnClickSPRecorver
function luaGMMoveBattle:OnClickSPRecorver()
	
	local sp	= edtGMBattle_SPRecover:GetText();
	if( ( nil == sp ) or ( "" == sp ) )	then
		return ;
	end
	
	gamefunc:OnGMSetMe( "sp", sp );

end

-- OnClickAllRecorver
function luaGMMoveBattle:OnClickAllRecorver()
	
	gamefunc:OnGMSetMe( "hp", gamefunc:GetMaxHP() );
	gamefunc:OnGMSetMe( "ep", gamefunc:GetMaxEN() );
	gamefunc:OnGMSetMe( "sp", gamefunc:GetMaxSTA() );
	
end

-- OnLoadededtGMBattle_Kill
function luaGMMoveBattle:OnLoadededtGMBattle_Kill()
	
	local range		= gamefunc:GetRangeKillEntity();
	edtGMBattle_Kill:SetText( range );	
	
end

-- OnClickKill
function luaGMMoveBattle:OnClickKill()
	
	local range	= edtGMBattle_Kill:GetText();
	if( ( nil == range ) or ( "" == range ) )	then
		return ;
	end
	
	gamefunc:RangeKillEntity( range );

end

-- OnLoadededtGMBattle_BPart
function luaGMMoveBattle:OnLoadededtGMBattle_BPart()
	
	local range		= gamefunc:GetRangeBreakPart();
	edtGMBattle_BPart:SetText( range );	
	
end

-- OnClickBPart
function luaGMMoveBattle:OnClickBPart()
	
	local range	= edtGMBattle_BPart:GetText();
	if( ( nil == range ) or ( "" == range ) )	then
		return ;
	end
	
	gamefunc:RangeBreakPart( range );

end