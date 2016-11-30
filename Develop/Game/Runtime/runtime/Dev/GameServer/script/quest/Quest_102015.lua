-- 용병계약 해지
function Quest_102015:OnEnd(Player, NPC)
	Player:SetAmity(115, 27000) -- 광기의 눈 부족 우호도 초기화
	Player:SetAmity(116, 27000)	-- 흰색 예티 부족 우호도 초기화
end
