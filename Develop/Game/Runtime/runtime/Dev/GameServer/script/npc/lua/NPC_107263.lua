function NPC_107263:OnDialogExit(Player, DialogID, Exit)
	HPPotionQty = Player:GetItem(32001)
	
	if (1072630 == DialogID and 2 == Exit) then --축복
		Player:GainBuff(120001)
		this:Balloon("$$NPC_107263_6")				
	end
	if (1072630 == DialogID and 3 == Exit) then --기부
		if (Player:GetSilver() >= 20) then
			Player:RemoveSilver(20)
			Player:AddAmity(2, 20) -- 레나시안 팩션 상승
			this:Balloon("$$NPC_107263_12")
		end
		if (Player:GetSilver() < 20) then
			this:Balloon("$$NPC_107263_15")		
		end
	end		
	if (1072630 == DialogID and 4 == Exit and HPPotionQty >= 10) then --포션(Full)일때
		this:Balloon("$$NPC_107263_19")
	end
	if (1072630 == DialogID and 4 == Exit and HPPotionQty < 10) then --상처치유의 물약
		Player:Tip("$$NPC_107263_22")	
		--Player:AddItem(32001, 3-HPPotionQty) dialog.xml에서 처리
		this:Balloon("$$NPC_107263_24")
	end
end