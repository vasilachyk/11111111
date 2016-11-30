function NPC_3020:OnDialogExit(Player, DialogID, Exit)
	HPPotionQty = Player:GetItem(32001)
	--SilverQty = Player:GetSilver()
	
	if (3020 == DialogID and 2 == Exit) then --축복
		Player:GainBuff(120001)
		this:Balloon("$$NPC_3020_7")				
	end
	if (3020 == DialogID and 3 == Exit) then --기부
		if (Player:GetSilver() >= 20) then
			Player:RemoveSilver(20)
			Player:AddAmity(2, 20) -- 레나시안 팩션 상승
			this:Balloon("$$NPC_3020_13")		
		end
		if (Player:GetSilver() < 20) then
			this:Balloon("$$NPC_3020_16")		
		end
	end		
	if (3020 == DialogID and 4 == Exit and HPPotionQty >= 10) then --포션(Full)일때
		this:Balloon("$$NPC_3020_20")
	end
	if (3020 == DialogID and 4 == Exit and HPPotionQty < 10) then --상처치유의 물약
		Player:Tip("$$NPC_3020_23")	
		--Player:AddItem(32001, 3-HPPotionQty) dialog.xml에서 처리
		this:Balloon("$$NPC_3020_25")
	end	
	
	if (30052 == DialogID and 1 == Exit and HPPotionQty >= 10) then --3005 퀘스트 중, 포션(Full)일때
		--Player:AddItem(10005, 1)	dialog.xml에서 처리
		this:Balloon("$$NPC_3020_30")
	end		
	if (30052 == DialogID and 1 == Exit and HPPotionQty < 10) then --3005 퀘스트 중, 상처치유의 물약
		Player:Tip("$$NPC_3020_33")	
		--Player:AddItem(32001, 3-HPPotionQty) dialog.xml에서 처리
		--Player:AddItem(10005, 1)
		this:Balloon("$$NPC_3020_36")
	end	
end
