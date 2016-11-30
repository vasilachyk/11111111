-- 물의 정령 치료사 물빵

function NPC_116617:OnDialogExit(Player, DialogID, Exit)
	if ((116616 == DialogID) and (1 == Exit)) then
		this:UseTalent(211350800,Player)
		this:Balloon("화이팅!")
	end
end

