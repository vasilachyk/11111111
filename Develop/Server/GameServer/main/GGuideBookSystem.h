#pragma once

class GEntityPlayer;

class GGuideBookSystem : public MTestMemPool<GGuideBookSystem>
{
public:
	void AddGuideBook_OnLevelUp(GEntityPlayer* pPlayer, int nLevel);
	void AddGuideBook_OnFieldEntered(GEntityPlayer* pPlayer, int nFieldID);

	void AddGuideBookForDBTask(const MUID& uidPlayer, int nGuideBookID);
};
