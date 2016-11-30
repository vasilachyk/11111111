--============================================
-- filename: entry.lua
-- 설명: MasterServer의 초기 진입 파일
--
--============================================

function dofile_safe(filename)
	filename = "script/"..filename
	local f = io.open(filename);
	if f then
		f:close();
		dofile (filename);
	end
end

-- require에서 검색할 수 있는 패쓰 설정
package.path = "./?.lua;./?.dll;./script/?.lua;./script/?.dll";

-- 미리 읽어놓을 lua 파일들
dofile_safe("Const.lua");
dofile_safe("Const_debug.lua");



-- 미리 설정할 상수값



-- 미리 설정할 변수값


-- 초기화
math.randomseed( os.time() )