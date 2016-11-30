-- ·»°íÆ® È­¾à Æø¹ß¹°

function NPC_107226:OnDialogExit(Player, DialogID, Exit)
	--GLog0("NPC_0107226:OnDialogExit\n")
	
	if (1070463 == DialogID) and (3 == Exit) then
		local Field = Player:GetField()
		local Powder = Field:GetSpawnNPC(11120)
		Player:UpdateQuestVar(107046, 2)
		Powder:DisableInteraction()
		Player:Tip("$$NPC_107226_12")
		Powder:Balloon("5")
		Powder:Balloon("4")
		Powder:Balloon("3")
		Powder:Balloon("2")
		Powder:Balloon("1")
		Powder:UseTalentSelf(210722601)						
		Powder:Despawn(true)		
	end
end
