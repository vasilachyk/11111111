<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version = '1.0' xmlns:xsl = 'http://www.w3.org/1999/XSL/Transform'>
<xsl:template match='ACTION'>
     <tr bgcolor='white'><td></td>
         <td><xsl:value-of select='@type' /> </td>
         <td>
             <xsl:choose>
                     <xsl:when test='@param1 = 2556' >#개발자의 행진곡</xsl:when>
                     <xsl:when test='@param1 = 5071' >#투척 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 5072' >#투척 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 5073' >#투척 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 5074' >#투척 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 10001' >한손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 10002' >한손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 10003' >한손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 10004' >한손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 10005' >한손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 10101' >베기 특화</xsl:when>
                     <xsl:when test='@param1 = 10102' >베기 특화</xsl:when>
                     <xsl:when test='@param1 = 10103' >베기 특화</xsl:when>
                     <xsl:when test='@param1 = 10104' >베기 특화</xsl:when>
                     <xsl:when test='@param1 = 10105' >베기 특화</xsl:when>
                     <xsl:when test='@param1 = 10201' >파쇄 특화</xsl:when>
                     <xsl:when test='@param1 = 10202' >파쇄 특화</xsl:when>
                     <xsl:when test='@param1 = 10203' >파쇄 특화</xsl:when>
                     <xsl:when test='@param1 = 10204' >파쇄 특화</xsl:when>
                     <xsl:when test='@param1 = 10205' >파쇄 특화</xsl:when>
                     <xsl:when test='@param1 = 10301' >방어 숙련</xsl:when>
                     <xsl:when test='@param1 = 10302' >방어 숙련</xsl:when>
                     <xsl:when test='@param1 = 10303' >방어 숙련</xsl:when>
                     <xsl:when test='@param1 = 10401' >전술 훈련</xsl:when>
                     <xsl:when test='@param1 = 10402' >전술 훈련</xsl:when>
                     <xsl:when test='@param1 = 10501' >함성의 특화</xsl:when>
                     <xsl:when test='@param1 = 10601' >강격</xsl:when>
                     <xsl:when test='@param1 = 10602' >강격</xsl:when>
                     <xsl:when test='@param1 = 10603' >강격</xsl:when>
                     <xsl:when test='@param1 = 10701' >돌진</xsl:when>
                     <xsl:when test='@param1 = 10702' >돌진</xsl:when>
                     <xsl:when test='@param1 = 10703' >돌진</xsl:when>
                     <xsl:when test='@param1 = 10801' >방패 가격: 기절</xsl:when>
                     <xsl:when test='@param1 = 10802' >방패 가격: 기절</xsl:when>
                     <xsl:when test='@param1 = 10803' >방패 가격: 기절</xsl:when>
                     <xsl:when test='@param1 = 10901' >혼돈의 일격</xsl:when>
                     <xsl:when test='@param1 = 10902' >혼돈의 일격</xsl:when>
                     <xsl:when test='@param1 = 10903' >혼돈의 일격</xsl:when>
                     <xsl:when test='@param1 = 11001' >방패 가격: 침묵</xsl:when>
                     <xsl:when test='@param1 = 11002' >방패 가격: 침묵</xsl:when>
                     <xsl:when test='@param1 = 11003' >방패 가격: 침묵</xsl:when>
                     <xsl:when test='@param1 = 11101' >전장의 함성</xsl:when>
                     <xsl:when test='@param1 = 11102' >전장의 함성</xsl:when>
                     <xsl:when test='@param1 = 11103' >전장의 함성</xsl:when>
                     <xsl:when test='@param1 = 11201' >격려의 함성</xsl:when>
                     <xsl:when test='@param1 = 11202' >격려의 함성</xsl:when>
                     <xsl:when test='@param1 = 11203' >격려의 함성</xsl:when>
                     <xsl:when test='@param1 = 11301' >분노의 함성</xsl:when>
                     <xsl:when test='@param1 = 11302' >분노의 함성</xsl:when>
                     <xsl:when test='@param1 = 11303' >분노의 함성</xsl:when>
                     <xsl:when test='@param1 = 11406' >질풍의 일격</xsl:when>
                     <xsl:when test='@param1 = 11407' >질풍의 일격</xsl:when>
                     <xsl:when test='@param1 = 11408' >질풍의 일격</xsl:when>
                     <xsl:when test='@param1 = 11401' >연속돌격</xsl:when>
                     <xsl:when test='@param1 = 11402' >연속돌격</xsl:when>
                     <xsl:when test='@param1 = 11403' >연속돌격</xsl:when>
                     <xsl:when test='@param1 = 11501' >보루</xsl:when>
                     <xsl:when test='@param1 = 11502' >보루</xsl:when>
                     <xsl:when test='@param1 = 11503' >보루</xsl:when>
                     <xsl:when test='@param1 = 11601' >파멸의 일격</xsl:when>
                     <xsl:when test='@param1 = 11602' >파멸의 일격</xsl:when>
                     <xsl:when test='@param1 = 11603' >파멸의 일격</xsl:when>
                     <xsl:when test='@param1 = 11801' >충격 반사</xsl:when>
                     <xsl:when test='@param1 = 11802' >충격 반사</xsl:when>
                     <xsl:when test='@param1 = 11803' >충격 반사</xsl:when>
                     <xsl:when test='@param1 = 11901' >철벽</xsl:when>
                     <xsl:when test='@param1 = 11902' >철벽</xsl:when>
                     <xsl:when test='@param1 = 11903' >철벽</xsl:when>
                     <xsl:when test='@param1 = 12000' >역습</xsl:when>
                     <xsl:when test='@param1 = 20001' >양손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 20002' >양손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 20003' >양손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 20004' >양손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 20005' >양손무기 숙련</xsl:when>
                     <xsl:when test='@param1 = 20201' >피의 갈증</xsl:when>
                     <xsl:when test='@param1 = 20202' >피의 갈증</xsl:when>
                     <xsl:when test='@param1 = 20203' >피의 갈증</xsl:when>
                     <xsl:when test='@param1 = 20301' >분노 조절</xsl:when>
                     <xsl:when test='@param1 = 20302' >분노 조절</xsl:when>
                     <xsl:when test='@param1 = 21001' >사자후 특화</xsl:when>
                     <xsl:when test='@param1 = 20401' >무력화</xsl:when>
                     <xsl:when test='@param1 = 20402' >무력화</xsl:when>
                     <xsl:when test='@param1 = 20403' >무력화</xsl:when>
                     <xsl:when test='@param1 = 20501' >버팔로의 진격</xsl:when>
                     <xsl:when test='@param1 = 20501' >버팔로의 진격 [2hb]</xsl:when>
                     <xsl:when test='@param1 = 20502' >버팔로의 진격</xsl:when>
                     <xsl:when test='@param1 = 20502' >버팔로의 진격 [2hb]</xsl:when>
                     <xsl:when test='@param1 = 20503' >버팔로의 진격</xsl:when>
                     <xsl:when test='@param1 = 20503' >버팔로의 진격 [2hb]</xsl:when>
                     <xsl:when test='@param1 = 20601' >녹턴</xsl:when>
                     <xsl:when test='@param1 = 20601' >녹턴</xsl:when>
                     <xsl:when test='@param1 = 20602' >녹턴</xsl:when>
                     <xsl:when test='@param1 = 20602' >녹턴</xsl:when>
                     <xsl:when test='@param1 = 20603' >녹턴</xsl:when>
                     <xsl:when test='@param1 = 20603' >녹턴</xsl:when>
                     <xsl:when test='@param1 = 20701' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 20701' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 20702' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 20702' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 20703' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 20703' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 20801' >회오리치기</xsl:when>
                     <xsl:when test='@param1 = 20801' >회오리치기</xsl:when>
                     <xsl:when test='@param1 = 20802' >회오리치기</xsl:when>
                     <xsl:when test='@param1 = 20802' >회오리치기</xsl:when>
                     <xsl:when test='@param1 = 20803' >회오리치기</xsl:when>
                     <xsl:when test='@param1 = 20803' >회오리치기</xsl:when>
                     <xsl:when test='@param1 = 20806' >후려치기</xsl:when>
                     <xsl:when test='@param1 = 20806' >후려치기</xsl:when>
                     <xsl:when test='@param1 = 20807' >후려치기</xsl:when>
                     <xsl:when test='@param1 = 20807' >후려치기</xsl:when>
                     <xsl:when test='@param1 = 20808' >후려치기</xsl:when>
                     <xsl:when test='@param1 = 20808' >후려치기</xsl:when>
                     <xsl:when test='@param1 = 20901' >사자후</xsl:when>
                     <xsl:when test='@param1 = 21006' >정신집중</xsl:when>
                     <xsl:when test='@param1 = 21007' >정신집중</xsl:when>
                     <xsl:when test='@param1 = 21008' >정신집중</xsl:when>
                     <xsl:when test='@param1 = 21101' >격노</xsl:when>
                     <xsl:when test='@param1 = 21106' >위기탈출</xsl:when>
                     <xsl:when test='@param1 = 21201' >#나락떨구기</xsl:when>
                     <xsl:when test='@param1 = 21201' >#나락떨구기</xsl:when>
                     <xsl:when test='@param1 = 21202' >#나락떨구기</xsl:when>
                     <xsl:when test='@param1 = 21202' >#나락떨구기</xsl:when>
                     <xsl:when test='@param1 = 21203' >#나락떨구기</xsl:when>
                     <xsl:when test='@param1 = 21203' >#나락떨구기</xsl:when>
                     <xsl:when test='@param1 = 21401' >평정</xsl:when>
                     <xsl:when test='@param1 = 21402' >평정</xsl:when>
                     <xsl:when test='@param1 = 21403' >평정</xsl:when>
                     <xsl:when test='@param1 = 21501' >분노의 질주</xsl:when>
                     <xsl:when test='@param1 = 21502' >분노의 질주</xsl:when>
                     <xsl:when test='@param1 = 21503' >분노의 질주</xsl:when>
                     <xsl:when test='@param1 = 21801' >되받아치기</xsl:when>
                     <xsl:when test='@param1 = 21802' >되받아치기</xsl:when>
                     <xsl:when test='@param1 = 21803' >되받아치기</xsl:when>
                     <xsl:when test='@param1 = 21901' >분쇄</xsl:when>
                     <xsl:when test='@param1 = 21901' >분쇄</xsl:when>
                     <xsl:when test='@param1 = 21902' >분쇄</xsl:when>
                     <xsl:when test='@param1 = 21902' >분쇄</xsl:when>
                     <xsl:when test='@param1 = 21903' >분쇄</xsl:when>
                     <xsl:when test='@param1 = 21903' >분쇄</xsl:when>
                     <xsl:when test='@param1 = 21906' >#불굴의 인내</xsl:when>
                     <xsl:when test='@param1 = 21907' >#불굴의 인내</xsl:when>
                     <xsl:when test='@param1 = 21908' >#불굴의 인내</xsl:when>
                     <xsl:when test='@param1 = 22000' >분노</xsl:when>
                     <xsl:when test='@param1 = 25000' >#[테스트]공격 방어시 HP+50회복</xsl:when>
                     <xsl:when test='@param1 = 25121' >#불의 화살 Rank 1 (test)</xsl:when>
                     <xsl:when test='@param1 = 25122' >#화염화살</xsl:when>
                     <xsl:when test='@param1 = 25141' >#파이어볼 Rank 1 (test)</xsl:when>
                     <xsl:when test='@param1 = 25200' >#카운터 일격 (test)</xsl:when>
                     <xsl:when test='@param1 = 25201' >#카운터 연계공격 (test)</xsl:when>
                     <xsl:when test='@param1 = 25202' >#광포의 일격 (test)</xsl:when>
                     <xsl:when test='@param1 = 25203' >#저격모드 (test)</xsl:when>
                     <xsl:when test='@param1 = 25204' >#은신 (test)</xsl:when>
                     <xsl:when test='@param1 = 25205' >#강신모드 (test)</xsl:when>
                     <xsl:when test='@param1 = 25206' >#마인드스톰 (test)</xsl:when>
                     <xsl:when test='@param1 = 25207' >#빽스탭 (test)</xsl:when>
                     <xsl:when test='@param1 = 25208' >#강신 일격 (test)</xsl:when>
                     <xsl:when test='@param1 = 25209' >#저격 일격 (test)</xsl:when>
                     <xsl:when test='@param1 = 25210' >#마법 일격 (test)</xsl:when>
                     <xsl:when test='@param1 = 25211' >#멀티 발사체 (test)</xsl:when>
                     <xsl:when test='@param1 = 25212' >#멀티 발사체2 (test)</xsl:when>
                     <xsl:when test='@param1 = 25213' >#HitCapsule 발사체 (test)</xsl:when>
                     <xsl:when test='@param1 = 25214' >#지형 발사체 (test)</xsl:when>
                     <xsl:when test='@param1 = 25215' >#짝퉁파워웨이브 (test)</xsl:when>
                     <xsl:when test='@param1 = 25301' >#루트 (test_Target)</xsl:when>
                     <xsl:when test='@param1 = 25302' >#루트 (test_Self)</xsl:when>
                     <xsl:when test='@param1 = 25400' >#치유 마법진 (test)</xsl:when>
                     <xsl:when test='@param1 = 25401' >#화염 마법진 (test)</xsl:when>
                     <xsl:when test='@param1 = 25402' >#화염 덫 (test)</xsl:when>
                     <xsl:when test='@param1 = 25410' >#정화 (test)</xsl:when>
                     <xsl:when test='@param1 = 25411' >#정화 효과(test)</xsl:when>
                     <xsl:when test='@param1 = 25502' >#축복의 오오라 즉시 (test)</xsl:when>
                     <xsl:when test='@param1 = 25503' >#힐링 서클 (test)</xsl:when>
                     <xsl:when test='@param1 = 25504' >#메테오 (test)</xsl:when>
                     <xsl:when test='@param1 = 25505' >#광역 데미지 (test)</xsl:when>
                     <xsl:when test='@param1 = 25501' >#디버프 걸기용1</xsl:when>
                     <xsl:when test='@param1 = 25510' >#Drag 테스트</xsl:when>
                     <xsl:when test='@param1 = 25512' >#징벌 오오라 (test)</xsl:when>
                     <xsl:when test='@param1 = 25514' >#마젠타의 조명탄</xsl:when>
                     <xsl:when test='@param1 = 30001' >#단검 숙련 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 30002' >#단검 숙련 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 30003' >#단검 숙련 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 30004' >#단검 숙련 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 30005' >#단검 숙련 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 30101' >#찌르기 특화 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 30102' >#찌르기 특화 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 30103' >#찌르기 특화 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 30104' >#찌르기 특화 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 30105' >#찌르기 특화 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 30401' >#인체학 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 30402' >#인체학 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 30403' >#인체학 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 30501' >#은신 숙련</xsl:when>
                     <xsl:when test='@param1 = 30502' >#은신 숙련</xsl:when>
                     <xsl:when test='@param1 = 30601' >#그림자 밟기 특화</xsl:when>
                     <xsl:when test='@param1 = 30701' >#은신</xsl:when>
                     <xsl:when test='@param1 = 30702' >#은신 II</xsl:when>
                     <xsl:when test='@param1 = 30703' >#은신 III</xsl:when>
                     <xsl:when test='@param1 = 30801' >#그림자 밟기</xsl:when>
                     <xsl:when test='@param1 = 30802' >#그림자 밟기 II</xsl:when>
                     <xsl:when test='@param1 = 30901' >#매의 발톱</xsl:when>
                     <xsl:when test='@param1 = 30902' >#매의 발톱</xsl:when>
                     <xsl:when test='@param1 = 30903' >#매의 발톱</xsl:when>
                     <xsl:when test='@param1 = 31001' >#급습</xsl:when>
                     <xsl:when test='@param1 = 31002' >#급습</xsl:when>
                     <xsl:when test='@param1 = 31003' >#급습</xsl:when>
                     <xsl:when test='@param1 = 31006' >#급습 [Ref Back]</xsl:when>
                     <xsl:when test='@param1 = 31007' >#급습 [Ref Back]</xsl:when>
                     <xsl:when test='@param1 = 31008' >#급습 [Ref Back]</xsl:when>
                     <xsl:when test='@param1 = 31401' >#가시 함정</xsl:when>
                     <xsl:when test='@param1 = 31402' >#가시 함정</xsl:when>
                     <xsl:when test='@param1 = 31403' >#가시 함정</xsl:when>
                     <xsl:when test='@param1 = 31101' >#발목 절단</xsl:when>
                     <xsl:when test='@param1 = 31102' >#발목 절단</xsl:when>
                     <xsl:when test='@param1 = 31103' >#발목 절단</xsl:when>
                     <xsl:when test='@param1 = 31201' >#무력화</xsl:when>
                     <xsl:when test='@param1 = 31202' >#무력화</xsl:when>
                     <xsl:when test='@param1 = 31203' >#무력화</xsl:when>
                     <xsl:when test='@param1 = 31301' >#전력질주</xsl:when>
                     <xsl:when test='@param1 = 31501' >#흙 뿌리기</xsl:when>
                     <xsl:when test='@param1 = 31502' >#흙 뿌리기</xsl:when>
                     <xsl:when test='@param1 = 31503' >#흙 뿌리기</xsl:when>
                     <xsl:when test='@param1 = 31601' >#레퀴엠</xsl:when>
                     <xsl:when test='@param1 = 31602' >#레퀴엠</xsl:when>
                     <xsl:when test='@param1 = 31603' >#레퀴엠</xsl:when>
                     <xsl:when test='@param1 = 31606' >#레퀴엠 [Ref Back]</xsl:when>
                     <xsl:when test='@param1 = 31607' >#레퀴엠 [Ref Back]</xsl:when>
                     <xsl:when test='@param1 = 31608' >#레퀴엠 [Ref Back]</xsl:when>
                     <xsl:when test='@param1 = 31801' >#명계로의 산책</xsl:when>
                     <xsl:when test='@param1 = 31802' >#명계로의 산책</xsl:when>
                     <xsl:when test='@param1 = 31803' >#명계로의 산책</xsl:when>
                     <xsl:when test='@param1 = 31901' >#자아붕괴</xsl:when>
                     <xsl:when test='@param1 = 31902' >#자아붕괴</xsl:when>
                     <xsl:when test='@param1 = 31903' >#자아붕괴</xsl:when>
                     <xsl:when test='@param1 = 40001' >#원거리 무기 숙련 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 40002' >#원거리 무기 숙련 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 40003' >#원거리 무기 숙련 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 40004' >#원거리 무기 숙련 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 40005' >#원거리 무기 숙련 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 40101' >#활 특화 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 40102' >#활 특화 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 40103' >#활 특화 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 40104' >#활 특화 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 40105' >#활 특화 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 40201' >#화약무기 특화 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 40202' >#화약무기 특화 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 40203' >#화약무기 특화 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 40204' >#화약무기 특화 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 40205' >#화약무기 특화 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 40301' >#직감 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 40302' >#직감 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 40303' >#직감 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 40401' >#근성 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 40402' >#근성 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 40501' >#강궁</xsl:when>
                     <xsl:when test='@param1 = 40601' >3추적</xsl:when>
                     <xsl:when test='@param1 = 40701' >#죽음의 표식</xsl:when>
                     <xsl:when test='@param1 = 40801' >#암살 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 40802' >#암살 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 40803' >#암살 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 40804' >#암살 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 40805' >#암살 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 40901' >#연사 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 40902' >#연사 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 40903' >#연사 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 40904' >#연사 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 40905' >#연사 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 41001' >#출혈 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41002' >#출혈 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41003' >#출혈 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41004' >#출혈 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 41005' >#출혈 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 41101' >#관통 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41102' >#관통 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41103' >#관통 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41104' >#관통 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 41105' >#관통 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 41201' >#고통의 사격 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41202' >#고통의 사격 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41203' >#고통의 사격 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41204' >#고통의 사격 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 41205' >#고통의 사격 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 41301' >#스네어샷 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41302' >#스네어샷 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41303' >#스네어샷 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41304' >#스네어샷 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 41305' >#스네어샷 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 41401' >#산탄 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41402' >#산탄 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41403' >#산탄 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41501' >#교란 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41502' >#교란 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41503' >#교란 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41601' >#죽음의 가시 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41602' >#죽음의 가시 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41603' >#죽음의 가시 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41701' >#질풍의 사격 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 41702' >#질풍의 사격 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 41703' >#질풍의 사격 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 41704' >#질풍의 사격 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 41705' >#질풍의 사격 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 50001' >#마법 숙련 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 50002' >#마법 숙련 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 50003' >#마법 숙련 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 50004' >#마법 숙련 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 50005' >#마법 숙련 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 50101' >#마법 특화 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 50102' >#마법 특화 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 50103' >#마법 특화 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 50104' >#마법 특화 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 50105' >#마법 특화 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 50201' >#마법 역학 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 50202' >#마법 역학 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 50203' >#마법 역학 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 50301' >#집중 특화 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 50302' >#집중 특화 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 50401' >#게이트</xsl:when>
                     <xsl:when test='@param1 = 50501' >#화염화살</xsl:when>
                     <xsl:when test='@param1 = 50502' >#화염화살</xsl:when>
                     <xsl:when test='@param1 = 50503' >#화염화살</xsl:when>
                     <xsl:when test='@param1 = 50506' >#자연의 표식</xsl:when>
                     <xsl:when test='@param1 = 50507' >#자연의 인장</xsl:when>
                     <xsl:when test='@param1 = 50508' >#자연의 낙인</xsl:when>
                     <xsl:when test='@param1 = 50601' >#얼음화살</xsl:when>
                     <xsl:when test='@param1 = 50602' >#얼음화살</xsl:when>
                     <xsl:when test='@param1 = 50603' >#얼음화살</xsl:when>
                     <xsl:when test='@param1 = 50701' >#화염회오리</xsl:when>
                     <xsl:when test='@param1 = 50702' >#화염회오리</xsl:when>
                     <xsl:when test='@param1 = 50703' >#화염회오리</xsl:when>
                     <xsl:when test='@param1 = 51901' >#매혹</xsl:when>
                     <xsl:when test='@param1 = 50801' >#최면</xsl:when>
                     <xsl:when test='@param1 = 50901' >#디스펠 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 50902' >#디스펠 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 50903' >#디스펠 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 51001' >#포이즌 스프레이 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 51002' >#포이즌 스프레이 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 51003' >#포이즌 스프레이 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 51101' >#선더볼트 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 51102' >#선더볼트 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 51103' >#선더볼트 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 51201' >#명상</xsl:when>
                     <xsl:when test='@param1 = 51202' >#명상 Rank 2 (삭제)</xsl:when>
                     <xsl:when test='@param1 = 51301' >#각성의 영역</xsl:when>
                     <xsl:when test='@param1 = 51401' >#아케인 블라스트 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 51402' >#아케인 블라스트 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 51403' >#아케인 블라스트 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 51501' >#하트 익스플로젼 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 51502' >#하트 익스플로젼 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 51503' >#하트 익스플로젼 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 51504' >#하트 익스플로젼 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 51505' >#하트 익스플로젼 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 51601' >#메테오 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 51602' >#메테오 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 51603' >#메테오 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 51604' >#메테오 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 51605' >#메테오 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 51701' >#블리자드 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 51702' >#블리자드 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 51703' >#블리자드 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 51704' >#블리자드 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 51705' >#블리자드 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 51801' >#마나 갑옷</xsl:when>
                     <xsl:when test='@param1 = 52001' >#화염구</xsl:when>
                     <xsl:when test='@param1 = 52002' >#화염구</xsl:when>
                     <xsl:when test='@param1 = 52003' >#화염구</xsl:when>
                     <xsl:when test='@param1 = 52101' >#얼음 기둥</xsl:when>
                     <xsl:when test='@param1 = 52102' >#얼음 기둥</xsl:when>
                     <xsl:when test='@param1 = 52103' >#얼음 기둥</xsl:when>
                     <xsl:when test='@param1 = 52201' >#얼음 폭풍</xsl:when>
                     <xsl:when test='@param1 = 52202' >#얼음 폭풍</xsl:when>
                     <xsl:when test='@param1 = 52203' >#얼음 폭풍</xsl:when>
                     <xsl:when test='@param1 = 52301' >#전소</xsl:when>
                     <xsl:when test='@param1 = 52302' >#전소</xsl:when>
                     <xsl:when test='@param1 = 52303' >#전소</xsl:when>
                     <xsl:when test='@param1 = 52401' >#얼음 운석</xsl:when>
                     <xsl:when test='@param1 = 52402' >#얼음 운석</xsl:when>
                     <xsl:when test='@param1 = 52403' >#얼음 운석</xsl:when>
                     <xsl:when test='@param1 = 52501' >#혼돈의 표식</xsl:when>
                     <xsl:when test='@param1 = 52601' >#혼돈의 인장</xsl:when>
                     <xsl:when test='@param1 = 60001' >신성 숙련</xsl:when>
                     <xsl:when test='@param1 = 60002' >신성 숙련</xsl:when>
                     <xsl:when test='@param1 = 60003' >신성 숙련</xsl:when>
                     <xsl:when test='@param1 = 60004' >신성 숙련</xsl:when>
                     <xsl:when test='@param1 = 60005' >신성 숙련</xsl:when>
                     <xsl:when test='@param1 = 60101' >#신성 특화 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 60102' >#신성 특화 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 60103' >#신성 특화 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 60104' >#신성 특화 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 60105' >#신성 특화 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 60201' >정신 수련</xsl:when>
                     <xsl:when test='@param1 = 60202' >정신 수련</xsl:when>
                     <xsl:when test='@param1 = 60203' >정신 수련</xsl:when>
                     <xsl:when test='@param1 = 60301' >믿음의 유산</xsl:when>
                     <xsl:when test='@param1 = 60302' >믿음의 유산</xsl:when>
                     <xsl:when test='@param1 = 60401' >#신앙심 수련 </xsl:when>
                     <xsl:when test='@param1 = 60501' >강신</xsl:when>
                     <xsl:when test='@param1 = 60601' >징벌의 성역</xsl:when>
                     <xsl:when test='@param1 = 60602' >징벌의 성역</xsl:when>
                     <xsl:when test='@param1 = 60603' >징벌의 성역</xsl:when>
                     <xsl:when test='@param1 = 60701' >치유</xsl:when>
                     <xsl:when test='@param1 = 60702' >치유</xsl:when>
                     <xsl:when test='@param1 = 60703' >치유</xsl:when>
                     <xsl:when test='@param1 = 60801' >빛의 망치</xsl:when>
                     <xsl:when test='@param1 = 60802' >빛의 망치</xsl:when>
                     <xsl:when test='@param1 = 60803' >빛의 망치</xsl:when>
                     <xsl:when test='@param1 = 60901' >축복의 빛</xsl:when>
                     <xsl:when test='@param1 = 60902' >축복의 오오라</xsl:when>
                     <xsl:when test='@param1 = 61001' >치유의 성역</xsl:when>
                     <xsl:when test='@param1 = 61002' >치유의 성역</xsl:when>
                     <xsl:when test='@param1 = 61003' >치유의 성역</xsl:when>
                     <xsl:when test='@param1 = 61101' >#부활의 손길</xsl:when>
                     <xsl:when test='@param1 = 61102' >#즉시부활</xsl:when>
                     <xsl:when test='@param1 = 61201' >치유의 파동</xsl:when>
                     <xsl:when test='@param1 = 61202' >치유의 파동</xsl:when>
                     <xsl:when test='@param1 = 61203' >치유의 파동</xsl:when>
                     <xsl:when test='@param1 = 61301' >#침묵의 성역</xsl:when>
                     <xsl:when test='@param1 = 61302' >#침묵의 성역</xsl:when>
                     <xsl:when test='@param1 = 61303' >#침묵의 성역</xsl:when>
                     <xsl:when test='@param1 = 61401' >축복</xsl:when>
                     <xsl:when test='@param1 = 61402' >축복</xsl:when>
                     <xsl:when test='@param1 = 61403' >축복</xsl:when>
                     <xsl:when test='@param1 = 61406' >#레나스의 가호</xsl:when>
                     <xsl:when test='@param1 = 61501' >#레나스의 화살</xsl:when>
                     <xsl:when test='@param1 = 61502' >#레나스의 화살</xsl:when>
                     <xsl:when test='@param1 = 61503' >#레나스의 화살</xsl:when>
                     <xsl:when test='@param1 = 61506' >#레나스의 진노</xsl:when>
                     <xsl:when test='@param1 = 61507' >#레나스의 진노</xsl:when>
                     <xsl:when test='@param1 = 61508' >#레나스의 진노</xsl:when>
                     <xsl:when test='@param1 = 61701' >심판의 망치</xsl:when>
                     <xsl:when test='@param1 = 61702' >심판의 망치</xsl:when>
                     <xsl:when test='@param1 = 61703' >심판의 망치</xsl:when>
                     <xsl:when test='@param1 = 61801' >성전의 망치</xsl:when>
                     <xsl:when test='@param1 = 61802' >성전의 망치</xsl:when>
                     <xsl:when test='@param1 = 61803' >성전의 망치</xsl:when>
                     <xsl:when test='@param1 = 61901' >빛의 고리</xsl:when>
                     <xsl:when test='@param1 = 61902' >빛의 고리</xsl:when>
                     <xsl:when test='@param1 = 61903' >빛의 고리</xsl:when>
                     <xsl:when test='@param1 = 62001' >빛의 소용돌이</xsl:when>
                     <xsl:when test='@param1 = 62002' >빛의 소용돌이</xsl:when>
                     <xsl:when test='@param1 = 62003' >빛의 소용돌이</xsl:when>
                     <xsl:when test='@param1 = 62101' >마력충전</xsl:when>
                     <xsl:when test='@param1 = 62201' >기적의 선율</xsl:when>
                     <xsl:when test='@param1 = 62202' >회유</xsl:when>
                     <xsl:when test='@param1 = 62301' >정화: 독</xsl:when>
                     <xsl:when test='@param1 = 62302' >정화: 질병</xsl:when>
                     <xsl:when test='@param1 = 62303' >정화: 저주</xsl:when>
                     <xsl:when test='@param1 = 70000' >기초 갑옷 훈련</xsl:when>
                     <xsl:when test='@param1 = 70001' >중급 갑옷 훈련</xsl:when>
                     <xsl:when test='@param1 = 70002' >상급 갑옷 훈련</xsl:when>
                     <xsl:when test='@param1 = 70101' >#힘 증가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70102' >#힘 증가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70103' >#힘 증가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70104' >#힘 증가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70105' >#힘 증가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70201' >#민첩성 증가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70202' >#민첩성 증가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70203' >#민첩성 증가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70204' >#민첩성 증가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70205' >#민첩성 증가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70301' >#지능 능가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70302' >#지능 능가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70303' >#지능 능가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70304' >#지능 능가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70305' >#지능 능가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70401' >#건강 증가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70402' >#건강 증가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70403' >#건강 증가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70404' >#건강 증가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70405' >#건강 증가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70501' >#매력 증가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70502' >#매력 증가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70503' >#매력 증가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70504' >#매력 증가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70505' >#매력 증가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70601' >#생명력 증가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70602' >#생명력 증가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70603' >#생명력 증가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70604' >#생명력 증가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70605' >#생명력 증가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70701' >#지구력 증가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70702' >#지구력 증가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70703' >#지구력 증가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70704' >#지구력 증가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70705' >#지구력 증가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70801' >#정신력 증가 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 70802' >#정신력 증가 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 70803' >#정신력 증가 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 70804' >#정신력 증가 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 70805' >#정신력 증가 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 70900' >#낙법</xsl:when>
                     <xsl:when test='@param1 = 71000' >#스내쳐</xsl:when>
                     <xsl:when test='@param1 = 71100' >#정신수양</xsl:when>
                     <xsl:when test='@param1 = 72001' >빌기</xsl:when>
                     <xsl:when test='@param1 = 72002' >인사</xsl:when>
                     <xsl:when test='@param1 = 72003' >환호</xsl:when>
                     <xsl:when test='@param1 = 72004' >박수</xsl:when>
                     <xsl:when test='@param1 = 72005' >울기</xsl:when>
                     <xsl:when test='@param1 = 72006' >춤</xsl:when>
                     <xsl:when test='@param1 = 72007' >무시</xsl:when>
                     <xsl:when test='@param1 = 72008' >키스</xsl:when>
                     <xsl:when test='@param1 = 72009' >웃기</xsl:when>
                     <xsl:when test='@param1 = 72010' >둘러보기</xsl:when>
                     <xsl:when test='@param1 = 72011' >부정</xsl:when>
                     <xsl:when test='@param1 = 72012' >지목</xsl:when>
                     <xsl:when test='@param1 = 72013' >긍정</xsl:when>
                     <xsl:when test='@param1 = 72014' >경례</xsl:when>
                     <xsl:when test='@param1 = 72015' >한숨</xsl:when>
                     <xsl:when test='@param1 = 72016' >대화1</xsl:when>
                     <xsl:when test='@param1 = 72017' >대화2</xsl:when>
                     <xsl:when test='@param1 = 72018' >조롱</xsl:when>
                     <xsl:when test='@param1 = 72019' >신호</xsl:when>
                     <xsl:when test='@param1 = 72020' >앉기</xsl:when>
                     <xsl:when test='@param1 = 72021' >일어나기</xsl:when>
                     <xsl:when test='@param1 = 80000' >#무기사용:한손검</xsl:when>
                     <xsl:when test='@param1 = 80001' >#무기사용:한손둔기</xsl:when>
                     <xsl:when test='@param1 = 80002' >#무기사용:단검</xsl:when>
                     <xsl:when test='@param1 = 80003' >#무기사용:쌍단검</xsl:when>
                     <xsl:when test='@param1 = 80004' >#무기사용:양손검</xsl:when>
                     <xsl:when test='@param1 = 80005' >#무기사용:양손둔기</xsl:when>
                     <xsl:when test='@param1 = 80006' >#무기사용:활</xsl:when>
                     <xsl:when test='@param1 = 80007' >#무기사용:총</xsl:when>
                     <xsl:when test='@param1 = 80008' >#무기사용:스태프</xsl:when>
                     <xsl:when test='@param1 = 80009' >#무기사용:책</xsl:when>
                     <xsl:when test='@param1 = 80010' >베기 특화</xsl:when>
                     <xsl:when test='@param1 = 80011' >둔기 특화</xsl:when>
                     <xsl:when test='@param1 = 80012' >#찌르기 특화</xsl:when>
                     <xsl:when test='@param1 = 80013' >#자연마법 특화</xsl:when>
                     <xsl:when test='@param1 = 80014' >신성마법 특화</xsl:when>
                     <xsl:when test='@param1 = 80015' >#기초낙법</xsl:when>
                     <xsl:when test='@param1 = 80016' >#중급낙법</xsl:when>
                     <xsl:when test='@param1 = 80017' >#기초갑옷 숙련</xsl:when>
                     <xsl:when test='@param1 = 80018' >중급갑옷 숙련</xsl:when>
                     <xsl:when test='@param1 = 80019' >상급갑옷 숙련</xsl:when>
                     <xsl:when test='@param1 = 80020' >#함성의 특화</xsl:when>
                     <xsl:when test='@param1 = 80021' >#사자후 특화</xsl:when>
                     <xsl:when test='@param1 = 90000' >채집 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 90001' >채집 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 90002' >채집 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 90003' >채집 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 90004' >채집 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 90005' >채집 Rank 6</xsl:when>
                     <xsl:when test='@param1 = 90006' >채집 Rank 7</xsl:when>
                     <xsl:when test='@param1 = 90007' >채집 Rank 8</xsl:when>
                     <xsl:when test='@param1 = 90008' >채집 Rank 9</xsl:when>
                     <xsl:when test='@param1 = 90009' >채집 Rank 10</xsl:when>
                     <xsl:when test='@param1 = 90100' >#약초학 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 90101' >#약초학 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 90102' >#약초학 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 90103' >#약초학 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 90104' >#약초학 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 90105' >#약초학 Rank 6</xsl:when>
                     <xsl:when test='@param1 = 90106' >#약초학 Rank 7</xsl:when>
                     <xsl:when test='@param1 = 90107' >#약초학 Rank 8</xsl:when>
                     <xsl:when test='@param1 = 90108' >#약초학 Rank 9</xsl:when>
                     <xsl:when test='@param1 = 90109' >#약초학 Rank 10</xsl:when>
                     <xsl:when test='@param1 = 90200' >#자물쇠 따기 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 90201' >#자물쇠 따기 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 90202' >#자물쇠 따기 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 90203' >#자물쇠 따기 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 90204' >#자물쇠 따기 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 90205' >#자물쇠 따기 Rank 6</xsl:when>
                     <xsl:when test='@param1 = 90206' >#자물쇠 따기 Rank 7</xsl:when>
                     <xsl:when test='@param1 = 90207' >#자물쇠 따기 Rank 8</xsl:when>
                     <xsl:when test='@param1 = 90208' >#자물쇠 따기 Rank 9</xsl:when>
                     <xsl:when test='@param1 = 90209' >#자물쇠 따기 Rank 10</xsl:when>
                     <xsl:when test='@param1 = 90300' >#목공 지식 Rank 1</xsl:when>
                     <xsl:when test='@param1 = 90301' >#목공 지식 Rank 2</xsl:when>
                     <xsl:when test='@param1 = 90302' >#목공 지식 Rank 3</xsl:when>
                     <xsl:when test='@param1 = 90303' >#목공 지식 Rank 4</xsl:when>
                     <xsl:when test='@param1 = 90304' >#목공 지식 Rank 5</xsl:when>
                     <xsl:when test='@param1 = 90305' >#목공 지식 Rank 6</xsl:when>
                     <xsl:when test='@param1 = 90306' >#목공 지식 Rank 7</xsl:when>
                     <xsl:when test='@param1 = 90307' >#목공 지식 Rank 8</xsl:when>
                     <xsl:when test='@param1 = 90308' >#목공 지식 Rank 9</xsl:when>
                     <xsl:when test='@param1 = 90309' >#목공 지식 Rank 10</xsl:when>
                     <xsl:when test='@param1 = 100070' >#none_전방 회피</xsl:when>
                     <xsl:when test='@param1 = 100071' >#none_후방 회피</xsl:when>
                     <xsl:when test='@param1 = 100072' >#none_왼쪽 회피</xsl:when>
                     <xsl:when test='@param1 = 100073' >#none_오른족 회피</xsl:when>
                     <xsl:when test='@param1 = 101001' >#1hs 일반공격 1타</xsl:when>
                     <xsl:when test='@param1 = 101002' >#1hs 일반공격 2타</xsl:when>
                     <xsl:when test='@param1 = 101003' >#1hs 일반공격 3타</xsl:when>
                     <xsl:when test='@param1 = 101004' >#1hs 일반공격 4타</xsl:when>
                     <xsl:when test='@param1 = 101005' >#1hs 일반공격 5타</xsl:when>
                     <xsl:when test='@param1 = 101011' >#1hs 특수(앞+LMB)</xsl:when>
                     <xsl:when test='@param1 = 101023' >#1hs 특수(뒤+LMB)</xsl:when>
                     <xsl:when test='@param1 = 101030' >#1hs 기본 발도기</xsl:when>
                     <xsl:when test='@param1 = 101050' >#1hs 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 101051' >#1hs 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 101052' >#1hs 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 101053' >#1hs 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 101060' >#1hs 부분 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 101061' >#1hs 부분 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 101062' >#1hs 부분 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 101063' >#1hs 부분 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 101070' >#1hs 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 101071' >#1hs 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 101072' >#1hs 왼쪽 회피</xsl:when>
                     <xsl:when test='@param1 = 101073' >#1hs 오른쪽 회피</xsl:when>
                     <xsl:when test='@param1 = 102001' >#1hb 일반공격 1타</xsl:when>
                     <xsl:when test='@param1 = 102002' >#1hb 일반공격 2타</xsl:when>
                     <xsl:when test='@param1 = 102003' >#1hb 일반공격 3타</xsl:when>
                     <xsl:when test='@param1 = 102004' >#1hb 일반공격 4타</xsl:when>
                     <xsl:when test='@param1 = 102005' >#1hb 일반공격 5타</xsl:when>
                     <xsl:when test='@param1 = 102011' >#1hb 특수(앞+LMB)</xsl:when>
                     <xsl:when test='@param1 = 102023' >#1hb 특수(뒤+LMB)</xsl:when>
                     <xsl:when test='@param1 = 102030' >#1hb 기본 발도기</xsl:when>
                     <xsl:when test='@param1 = 102050' >#1hb 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 102051' >#1hb 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 102052' >#1hb 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 102053' >#1hb 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 102060' >#1hb 부분 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 102061' >#1hb 부분 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 102062' >#1hb 부분 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 102063' >#1hb 부분 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 102070' >#1hb 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 102071' >#1hb 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 102072' >#1hb 좌측 회피</xsl:when>
                     <xsl:when test='@param1 = 102073' >#1hb 우측 회피</xsl:when>
                     <xsl:when test='@param1 = 103001' >#1hp 일반공격 1타</xsl:when>
                     <xsl:when test='@param1 = 103002' >#1hp 일반공격 2타</xsl:when>
                     <xsl:when test='@param1 = 103003' >#1hp 일반공격 3타</xsl:when>
                     <xsl:when test='@param1 = 103011' >#1hp 특수(앞+LMB)</xsl:when>
                     <xsl:when test='@param1 = 103023' >#1hp 특수(뒤+LMB)</xsl:when>
                     <xsl:when test='@param1 = 103030' >#1hp 기본 발도기</xsl:when>
                     <xsl:when test='@param1 = 103070' >#1hp 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 103071' >#1hp 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 103072' >#1hp 좌측 회피</xsl:when>
                     <xsl:when test='@param1 = 103073' >#1hp 우측 회피</xsl:when>
                     <xsl:when test='@param1 = 104001' >#2hd 일반공격 1타</xsl:when>
                     <xsl:when test='@param1 = 104002' >#2hd 일반공격 2타</xsl:when>
                     <xsl:when test='@param1 = 104003' >#2hd 일반공격 3타</xsl:when>
                     <xsl:when test='@param1 = 104011' >#2hd 특수(앞+LMB)</xsl:when>
                     <xsl:when test='@param1 = 104023' >#2hd 특수(뒤+LMB))</xsl:when>
                     <xsl:when test='@param1 = 104030' >#2hd 기본 발도기</xsl:when>
                     <xsl:when test='@param1 = 104050' >#2hd 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 104051' >#2hd 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 104052' >#2hd 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 104053' >#2hd 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 104060' >#2hd 부분 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 104061' >#2hd 부분 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 104062' >#2hd 부분 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 104063' >#2hd 부분 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 104070' >#2hd 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 104071' >#2hd 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 104072' >#2hd 좌측 회피</xsl:when>
                     <xsl:when test='@param1 = 104073' >#2hd 우측 회피</xsl:when>
                     <xsl:when test='@param1 = 105001' >#staff 일반공격 1타</xsl:when>
                     <xsl:when test='@param1 = 105002' >#staff 일반공격 2타</xsl:when>
                     <xsl:when test='@param1 = 105003' >#staff 일반공격 3타</xsl:when>
                     <xsl:when test='@param1 = 105004' >#staff 일반공격 4타</xsl:when>
                     <xsl:when test='@param1 = 105011' >#staff 특수(앞+LMB)</xsl:when>
                     <xsl:when test='@param1 = 105023' >#staff 특수(뒤+LMB)</xsl:when>
                     <xsl:when test='@param1 = 105050' >#staff 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 105051' >#staff 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 105052' >#staff 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 105053' >#staff 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 105060' >#staff 부분 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 105061' >#staff 부분 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 105062' >#staff 부분 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 105063' >#staff 부분 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 105070' >#staff 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 105071' >#staff 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 105072' >#staff 좌측 회피</xsl:when>
                     <xsl:when test='@param1 = 105073' >#staff 우측 회피</xsl:when>
                     <xsl:when test='@param1 = 106001' >#arc_일반 공격</xsl:when>
                     <xsl:when test='@param1 = 106070' >#arc 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 106071' >#arc 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 106072' >#arc 왼쪽 회피</xsl:when>
                     <xsl:when test='@param1 = 106073' >#arc 오른쪽 회피</xsl:when>
                     <xsl:when test='@param1 = 107001' >#2hb 일반공격 1타</xsl:when>
                     <xsl:when test='@param1 = 107002' >#2hb 일반공격 2타</xsl:when>
                     <xsl:when test='@param1 = 107003' >#2hb 일반공격 3타</xsl:when>
                     <xsl:when test='@param1 = 107011' >#2hb 특수(앞+LMB)</xsl:when>
                     <xsl:when test='@param1 = 107023' >#2hb 특수(뒤+LMB))</xsl:when>
                     <xsl:when test='@param1 = 107030' >#2hb 기본 발도기</xsl:when>
                     <xsl:when test='@param1 = 107050' >#2hb 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 107051' >#2hb 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 107052' >#2hb 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 107053' >#2hb 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 107060' >#2hb 부분 가드 Rank0</xsl:when>
                     <xsl:when test='@param1 = 107061' >#2hb 부분 가드 Rank1</xsl:when>
                     <xsl:when test='@param1 = 107062' >#2hb 부분 가드 Rank2</xsl:when>
                     <xsl:when test='@param1 = 107063' >#2hb 부분 가드 Rank3</xsl:when>
                     <xsl:when test='@param1 = 107070' >#2hb 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 107071' >#2hb 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 107072' >#2hb 좌측 회피</xsl:when>
                     <xsl:when test='@param1 = 107073' >#2hb 우측 회피</xsl:when>
                     <xsl:when test='@param1 = 109001' >#dwp 일반공격 1타</xsl:when>
                     <xsl:when test='@param1 = 109002' >#dwp 일반공격 2타</xsl:when>
                     <xsl:when test='@param1 = 109003' >#dwp 일반공격 3타</xsl:when>
                     <xsl:when test='@param1 = 109004' >#dwp 일반공격 4타</xsl:when>
                     <xsl:when test='@param1 = 109005' >#dwp 일반공격 5타</xsl:when>
                     <xsl:when test='@param1 = 109006' >#dwp 일반공격 6타</xsl:when>
                     <xsl:when test='@param1 = 109070' >#dwp 전방 회피</xsl:when>
                     <xsl:when test='@param1 = 109071' >#dwp 후방 회피</xsl:when>
                     <xsl:when test='@param1 = 109072' >#dwp 좌측 회피</xsl:when>
                     <xsl:when test='@param1 = 109073' >#dwp 우측 회피</xsl:when>
                     <xsl:when test='@param1 = 110000' >오우거 힘의 물약 사용</xsl:when>
                     <xsl:when test='@param1 = 110001' >약화 물약</xsl:when>
                     <xsl:when test='@param1 = 110002' >#초보자용 정신력 포션 사용</xsl:when>
                     <xsl:when test='@param1 = 110003' >#저급 스테미너 물약</xsl:when>
                     <xsl:when test='@param1 = 110004' >#저급 힐링 물약</xsl:when>
                     <xsl:when test='@param1 = 110005' >#저급 EN 물약</xsl:when>
                     <xsl:when test='@param1 = 110006' >#저급 회복 물약</xsl:when>
                     <xsl:when test='@param1 = 110007' >#저급 스테미너 증가 물약</xsl:when>
                     <xsl:when test='@param1 = 110008' >#저급 HP 증가 물약</xsl:when>
                     <xsl:when test='@param1 = 110009' >#저급 EN 증가 물약</xsl:when>
                     <xsl:when test='@param1 = 110010' >#저급 공격력 증가 물약</xsl:when>
                     <xsl:when test='@param1 = 110011' >성수 사용</xsl:when>
                     <xsl:when test='@param1 = 111500' >생명의 부적 사용</xsl:when>
                     <xsl:when test='@param1 = 111501' >생명의 가호 사용</xsl:when>
                     <xsl:when test='@param1 = 111510' >우르 사용</xsl:when>
                     <xsl:when test='@param1 = 112000' >귀환</xsl:when>
                     <xsl:when test='@param1 = 112001' >테레스 텔레포트 발굴지로 순간이동</xsl:when>
                     <xsl:when test='@param1 = 112002' >리오드 텔레포트 발굴지로 순간이동</xsl:when>
                     <xsl:when test='@param1 = 112003' >프로토타입 테레스 가이드스톤</xsl:when>
                     <xsl:when test='@param1 = 113000' >상처치유의 물약 사용</xsl:when>
                     <xsl:when test='@param1 = 113001' >#리필 정신력 포션 사용</xsl:when>
                     <xsl:when test='@param1 = 113002' >#리필 활력 포션 사용</xsl:when>
                     <xsl:when test='@param1 = 113004' >회복의 물약 사용</xsl:when>
                     <xsl:when test='@param1 = 113005' >순수한 에다앙 사용</xsl:when>
                     <xsl:when test='@param1 = 114000' >바삭바삭한 빵</xsl:when>
                     <xsl:when test='@param1 = 114001' >구운 거미다리</xsl:when>
                     <xsl:when test='@param1 = 114002' >훈제 늑대고기</xsl:when>
                     <xsl:when test='@param1 = 114003' >브로드테일 스튜</xsl:when>
                     <xsl:when test='@param1 = 114004' >초승달 사슴의 녹용</xsl:when>
                     <xsl:when test='@param1 = 114005' >렌고트 송어 찜</xsl:when>
                     <xsl:when test='@param1 = 114006' >군용 소시지</xsl:when>
                     <xsl:when test='@param1 = 114007' >사슴 전골</xsl:when>
                     <xsl:when test='@param1 = 114008' >가재 찜</xsl:when>
                     <xsl:when test='@param1 = 114009' >도마뱀 구이</xsl:when>
                     <xsl:when test='@param1 = 114010' >핀델 빵</xsl:when>
                     <xsl:when test='@param1 = 114011' >허브와 함께 구운 거미다리</xsl:when>
                     <xsl:when test='@param1 = 114012' >허브를 가미한 훈제 늑대고기</xsl:when>
                     <xsl:when test='@param1 = 114013' >브로드테일 허브 스튜</xsl:when>
                     <xsl:when test='@param1 = 114014' >허브를 가미한 렌고트 송어 찜</xsl:when>
                     <xsl:when test='@param1 = 114015' >핀델 소시지</xsl:when>
                     <xsl:when test='@param1 = 114016' >허브를 가미한 사슴 전골</xsl:when>
                     <xsl:when test='@param1 = 114017' >허브 도마뱀 구이</xsl:when>
                     <xsl:when test='@param1 = 114018' >게살 수프</xsl:when>
                     <xsl:when test='@param1 = 114019' >허브 게살 수프</xsl:when>
                     <xsl:when test='@param1 = 114020' >송사리 튀김</xsl:when>
                     <xsl:when test='@param1 = 114021' >향긋한 송사리 튀김</xsl:when>
                     <xsl:when test='@param1 = 114022' >선인장 노루 구이</xsl:when>
                     <xsl:when test='@param1 = 114023' >향긋한 선인장 노루 구이</xsl:when>
                     <xsl:when test='@param1 = 114024' >죽순 버섯 볶음</xsl:when>
                     <xsl:when test='@param1 = 114025' >호박죽</xsl:when>
                     <xsl:when test='@param1 = 114026' >과일 샐러드</xsl:when>
                     <xsl:when test='@param1 = 114027' >약과</xsl:when>
                     <xsl:when test='@param1 = 114028' >에다 치즈</xsl:when>
                     <xsl:when test='@param1 = 114029' >치킨 너겟</xsl:when>
                     <xsl:when test='@param1 = 114030' >치킨 햄버거</xsl:when>
                     <xsl:when test='@param1 = 114031' >양고기 치즈 퐁듀</xsl:when>
                     <xsl:when test='@param1 = 114032' >허브 양고기 치즈 퐁듀</xsl:when>
                     <xsl:when test='@param1 = 114033' >열풍 도마뱀 구이</xsl:when>
                     <xsl:when test='@param1 = 114034' >생선 구이</xsl:when>
                     <xsl:when test='@param1 = 114035' >탄산수</xsl:when>
                     <xsl:when test='@param1 = 114036' >사과 파이</xsl:when>
                     <xsl:when test='@param1 = 114037' >신선한 우유</xsl:when>
                     <xsl:when test='@param1 = 114038' >양고기 스튜</xsl:when>
                     <xsl:when test='@param1 = 114039' >맥주</xsl:when>
                     <xsl:when test='@param1 = 114040' >소금에 절인 돼지고기</xsl:when>
                     <xsl:when test='@param1 = 114041' >천연 과일 주스</xsl:when>
                     <xsl:when test='@param1 = 114042' >훈제 거위고기</xsl:when>
                     <xsl:when test='@param1 = 114043' >달콤한 꿀물</xsl:when>
                     <xsl:when test='@param1 = 114044' >상어고기 요리</xsl:when>
                     <xsl:when test='@param1 = 114045' >그랑 크뤼 프리미에르</xsl:when>
                     <xsl:when test='@param1 = 114046' >아이스 밀크</xsl:when>
                     <xsl:when test='@param1 = 114047' >젤라또</xsl:when>
                     <xsl:when test='@param1 = 114048' >샤베트</xsl:when>
                     <xsl:when test='@param1 = 114049' >돌체비타</xsl:when>
                     <xsl:when test='@param1 = 114050' >박쥐 날개 구이</xsl:when>
                     <xsl:when test='@param1 = 114051' >졸깃한 박쥐 날개</xsl:when>
                     <xsl:when test='@param1 = 140000' >#오베르의 큼직한 자루</xsl:when>
                     <xsl:when test='@param1 = 140001' >함정에 걸린 병사를 풀어줍니다.</xsl:when>
                     <xsl:when test='@param1 = 140002' >의식을 잃은 순례자를 깨웁니다.</xsl:when>
                     <xsl:when test='@param1 = 140003' >고블린골렘의 무기나 갑옷을 약화시킵니다.</xsl:when>
                     <xsl:when test='@param1 = 140004' >#깃발 꽂기</xsl:when>
                     <xsl:when test='@param1 = 140005' >#마법 지뢰 탐지</xsl:when>
                     <xsl:when test='@param1 = 140006' >#마법 지뢰 제거</xsl:when>
                     <xsl:when test='@param1 = 140007' >#마법지뢰의 폭발</xsl:when>
                     <xsl:when test='@param1 = 140008' >#등산용 신호탄</xsl:when>
                     <xsl:when test='@param1 = 140009' >해충 퇴치</xsl:when>
                     <xsl:when test='@param1 = 140010' >전격 대미지</xsl:when>
                     <xsl:when test='@param1 = 140011' >정화의 불길</xsl:when>
                     <xsl:when test='@param1 = 140012' >까르엔의 축복</xsl:when>
                     <xsl:when test='@param1 = 140013' >은자의 반지</xsl:when>
                     <xsl:when test='@param1 = 140014' >냉기 완드</xsl:when>
                     <xsl:when test='@param1 = 140015' >영혼의 구술</xsl:when>
                     <xsl:when test='@param1 = 140016' >영혼의 구술</xsl:when>
                     <xsl:when test='@param1 = 140017' >제일스 분쇄기</xsl:when>
                     <xsl:when test='@param1 = 140018' >불완전한 코볼드란</xsl:when>
                     <xsl:when test='@param1 = 140019' >카이저의 발톱</xsl:when>
                     <xsl:when test='@param1 = 141000' >#흡입기 사용</xsl:when>
                     <xsl:when test='@param1 = 141001' >#디가오의 도끼 사용</xsl:when>
                     <xsl:when test='@param1 = 141002' >#유령의 덫 사용</xsl:when>
                     <xsl:when test='@param1 = 141003' >#유령포획기 사용</xsl:when>
                     <xsl:when test='@param1 = 141004' >#횃불 던지기</xsl:when>
                     <xsl:when test='@param1 = 141005' >#윌라의 조사</xsl:when>
                     <xsl:when test='@param1 = 141006' >정체불명의 오염원</xsl:when>
                     <xsl:when test='@param1 = 219999801' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 219999802' >가드불가공격</xsl:when>
                     <xsl:when test='@param1 = 219999803' >박치기</xsl:when>
                     <xsl:when test='@param1 = 219999804' >한숨</xsl:when>
                     <xsl:when test='@param1 = 219999805' >도발1</xsl:when>
                     <xsl:when test='@param1 = 219999806' >도발2</xsl:when>
                     <xsl:when test='@param1 = 219999807' >가드</xsl:when>
                     <xsl:when test='@param1 = 200111' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 200112' >일반공격1-2</xsl:when>
                     <xsl:when test='@param1 = 200113' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 200114' >냉기공격</xsl:when>
                     <xsl:when test='@param1 = 200115' >가드</xsl:when>
                     <xsl:when test='@param1 = 200119' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 200120' >일반공격3</xsl:when>
                     <xsl:when test='@param1 = 200121' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200122' >마법 공격</xsl:when>
                     <xsl:when test='@param1 = 200123' >고블린 마법사 잡기 샘플</xsl:when>
                     <xsl:when test='@param1 = 200124' >광역 공격</xsl:when>
                     <xsl:when test='@param1 = 200129' >가드</xsl:when>
                     <xsl:when test='@param1 = 200131' >우측공격</xsl:when>
                     <xsl:when test='@param1 = 200132' >좌측 공격</xsl:when>
                     <xsl:when test='@param1 = 200133' >전진 공격</xsl:when>
                     <xsl:when test='@param1 = 200134' >태클</xsl:when>
                     <xsl:when test='@param1 = 200139' >가드</xsl:when>
                     <xsl:when test='@param1 = 200141' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200149' >가드</xsl:when>
                     <xsl:when test='@param1 = 200021501' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 200021502' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 200021503' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 200021504' >도발</xsl:when>
                     <xsl:when test='@param1 = 200021505' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 200021506' >방어</xsl:when>
                     <xsl:when test='@param1 = 200021601' >일반공격(근접)</xsl:when>
                     <xsl:when test='@param1 = 200021602' >하급치유</xsl:when>
                     <xsl:when test='@param1 = 200021603' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 200021604' >맹독분사</xsl:when>
                     <xsl:when test='@param1 = 200021605' >도발</xsl:when>
                     <xsl:when test='@param1 = 200021606' >맹독폭팔</xsl:when>
                     <xsl:when test='@param1 = 201501' >정면공격</xsl:when>
                     <xsl:when test='@param1 = 201502' >회피</xsl:when>
                     <xsl:when test='@param1 = 201503' >삽질1(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 200211' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200212' >실드 배쉬</xsl:when>
                     <xsl:when test='@param1 = 200213' >논실드 배쉬</xsl:when>
                     <xsl:when test='@param1 = 200214' >스페셜(꼬리살랑)</xsl:when>
                     <xsl:when test='@param1 = 200215' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 200219' >가드</xsl:when>
                     <xsl:when test='@param1 = 200221' >화염발사</xsl:when>
                     <xsl:when test='@param1 = 200222' >근접 공격</xsl:when>
                     <xsl:when test='@param1 = 200223' >가드</xsl:when>
                     <xsl:when test='@param1 = 200225' >졸기</xsl:when>
                     <xsl:when test='@param1 = 200231' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200232' >범위 공격</xsl:when>
                     <xsl:when test='@param1 = 200233' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 200239' >가드</xsl:when>
                     <xsl:when test='@param1 = 200234' >졸기</xsl:when>
                     <xsl:when test='@param1 = 200241' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200242' >범위 공격</xsl:when>
                     <xsl:when test='@param1 = 200243' >좌측 공격</xsl:when>
                     <xsl:when test='@param1 = 200244' >와일드 댄스</xsl:when>
                     <xsl:when test='@param1 = 200245' >스페셜</xsl:when>
                     <xsl:when test='@param1 = 200246' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 200247' >마무리 일격</xsl:when>
                     <xsl:when test='@param1 = 200249' >가드</xsl:when>
                     <xsl:when test='@param1 = 200251' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200252' >범위 공격</xsl:when>
                     <xsl:when test='@param1 = 200253' >좌측 공격</xsl:when>
                     <xsl:when test='@param1 = 200254' >폭주</xsl:when>
                     <xsl:when test='@param1 = 200255' >내려찍기</xsl:when>
                     <xsl:when test='@param1 = 200257' >필살의 일격</xsl:when>
                     <xsl:when test='@param1 = 200259' >가드</xsl:when>
                     <xsl:when test='@param1 = 200411' >통상기</xsl:when>
                     <xsl:when test='@param1 = 200412' >도발</xsl:when>
                     <xsl:when test='@param1 = 200413' >암드 어택</xsl:when>
                     <xsl:when test='@param1 = 200414' >무시하기</xsl:when>
                     <xsl:when test='@param1 = 200415' >생각하기</xsl:when>
                     <xsl:when test='@param1 = 200416' >자체힐링</xsl:when>
                     <xsl:when test='@param1 = 200417' >범위공격</xsl:when>
                     <xsl:when test='@param1 = 200418' >통상기 [잽]</xsl:when>
                     <xsl:when test='@param1 = 200419' >가드</xsl:when>
                     <xsl:when test='@param1 = 200420' >태클</xsl:when>
                     <xsl:when test='@param1 = 200421' >통상기</xsl:when>
                     <xsl:when test='@param1 = 200422' >도발</xsl:when>
                     <xsl:when test='@param1 = 200423' >암드 어택</xsl:when>
                     <xsl:when test='@param1 = 200424' >무시하기</xsl:when>
                     <xsl:when test='@param1 = 200425' >생각하기</xsl:when>
                     <xsl:when test='@param1 = 200426' >자체힐링</xsl:when>
                     <xsl:when test='@param1 = 200427' >범위공격</xsl:when>
                     <xsl:when test='@param1 = 200428' >통상기 [잽]</xsl:when>
                     <xsl:when test='@param1 = 200429' >가드</xsl:when>
                     <xsl:when test='@param1 = 200430' >태클</xsl:when>
                     <xsl:when test='@param1 = 200431' >통상기</xsl:when>
                     <xsl:when test='@param1 = 200432' >도발</xsl:when>
                     <xsl:when test='@param1 = 200433' >암드 어택</xsl:when>
                     <xsl:when test='@param1 = 200434' >무시하기</xsl:when>
                     <xsl:when test='@param1 = 200435' >생각하기</xsl:when>
                     <xsl:when test='@param1 = 200436' >자체힐링</xsl:when>
                     <xsl:when test='@param1 = 200437' >범위공격</xsl:when>
                     <xsl:when test='@param1 = 200438' >통상기 [잽]</xsl:when>
                     <xsl:when test='@param1 = 200439' >가드</xsl:when>
                     <xsl:when test='@param1 = 200310' >태클</xsl:when>
                     <xsl:when test='@param1 = 200311' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200312' >도발</xsl:when>
                     <xsl:when test='@param1 = 200313' >우측 공격(약)</xsl:when>
                     <xsl:when test='@param1 = 200314' >회피기 (좌)</xsl:when>
                     <xsl:when test='@param1 = 200315' >회피기 (우)</xsl:when>
                     <xsl:when test='@param1 = 200319' >가드</xsl:when>
                     <xsl:when test='@param1 = 200321' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200322' >마법 공격</xsl:when>
                     <xsl:when test='@param1 = 200323' >졸기</xsl:when>
                     <xsl:when test='@param1 = 200330' >거침없이 로우킥</xsl:when>
                     <xsl:when test='@param1 = 200331' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200332' >범위 공격</xsl:when>
                     <xsl:when test='@param1 = 200333' >대시 어택</xsl:when>
                     <xsl:when test='@param1 = 200334' >포효</xsl:when>
                     <xsl:when test='@param1 = 200335' >98% 미네랄 워터</xsl:when>
                     <xsl:when test='@param1 = 200339' >가드</xsl:when>
                     <xsl:when test='@param1 = 200340' >태클</xsl:when>
                     <xsl:when test='@param1 = 200341' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200342' >근접 공격</xsl:when>
                     <xsl:when test='@param1 = 200343' >대시 어택</xsl:when>
                     <xsl:when test='@param1 = 200345' >포효</xsl:when>
                     <xsl:when test='@param1 = 200346' >홍삼 엑기스</xsl:when>
                     <xsl:when test='@param1 = 200349' >가드</xsl:when>
                     <xsl:when test='@param1 = 200360' >Buffalo-Yawn #1</xsl:when>
                     <xsl:when test='@param1 = 200361' >Buffalo-Yawn #2</xsl:when>
                     <xsl:when test='@param1 = 200362' >Buffalo-Atk</xsl:when>
                     <xsl:when test='@param1 = 200363' >Buffalo-AtkShort</xsl:when>
                     <xsl:when test='@param1 = 200364' >Buffalo-RangeAtk15m</xsl:when>
                     <xsl:when test='@param1 = 200365' >Buffalo-Rush</xsl:when>
                     <xsl:when test='@param1 = 200511' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200512' >마법 공격</xsl:when>
                     <xsl:when test='@param1 = 200513' >회복 마법</xsl:when>
                     <xsl:when test='@param1 = 200611' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 200612' >마법 공격</xsl:when>
                     <xsl:when test='@param1 = 200613' >자폭</xsl:when>
                     <xsl:when test='@param1 = 200911' >가드</xsl:when>
                     <xsl:when test='@param1 = 200912' >샘플 공격</xsl:when>
                     <xsl:when test='@param1 = 200931' >가드</xsl:when>
                     <xsl:when test='@param1 = 200932' >샘플 공격1</xsl:when>
                     <xsl:when test='@param1 = 200933' >샘플 공격2</xsl:when>
                     <xsl:when test='@param1 = 200934' >땅파기</xsl:when>
                     <xsl:when test='@param1 = 200935' >스크류드라이버</xsl:when>
                     <xsl:when test='@param1 = 210201' >촉수치기</xsl:when>
                     <xsl:when test='@param1 = 210202' >양손 훅</xsl:when>
                     <xsl:when test='@param1 = 210203' >롤링</xsl:when>
                     <xsl:when test='@param1 = 210204' >해머핸드</xsl:when>
                     <xsl:when test='@param1 = 210205' >브레스</xsl:when>
                     <xsl:when test='@param1 = 210206' >발길질</xsl:when>
                     <xsl:when test='@param1 = 210207' >연속촉수</xsl:when>
                     <xsl:when test='@param1 = 210208' >양치질</xsl:when>
                     <xsl:when test='@param1 = 210209' >전방대시</xsl:when>
                     <xsl:when test='@param1 = 210210' >후방대시</xsl:when>
                     <xsl:when test='@param1 = 210211' >좌측대시</xsl:when>
                     <xsl:when test='@param1 = 210212' >우측대시</xsl:when>
                     <xsl:when test='@param1 = 210213' >idle1</xsl:when>
                     <xsl:when test='@param1 = 210214' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210215' >고통1</xsl:when>
                     <xsl:when test='@param1 = 210216' >고통2</xsl:when>
                     <xsl:when test='@param1 = 222001' >1타</xsl:when>
                     <xsl:when test='@param1 = 222002' >2연타</xsl:when>
                     <xsl:when test='@param1 = 222003' >3연타</xsl:when>
                     <xsl:when test='@param1 = 222004' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 222005' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 222006' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 222007' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 222008' >회피L</xsl:when>
                     <xsl:when test='@param1 = 222009' >회피R</xsl:when>
                     <xsl:when test='@param1 = 222010' >반격</xsl:when>
                     <xsl:when test='@param1 = 222011' >훼이크</xsl:when>
                     <xsl:when test='@param1 = 222101' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 222102' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 222104' >맹독공격</xsl:when>
                     <xsl:when test='@param1 = 222210' >휠윈드_끝(to_mode0)</xsl:when>
                     <xsl:when test='@param1 = 222211' >휠윈드_시작(to_mode1)</xsl:when>
                     <xsl:when test='@param1 = 211001' >단타</xsl:when>
                     <xsl:when test='@param1 = 211002' >장타</xsl:when>
                     <xsl:when test='@param1 = 211003' >태클</xsl:when>
                     <xsl:when test='@param1 = 211004' >속사</xsl:when>
                     <xsl:when test='@param1 = 211005' >강베기</xsl:when>
                     <xsl:when test='@param1 = 211006' >대시</xsl:when>
                     <xsl:when test='@param1 = 211007' >풍차돌리기</xsl:when>
                     <xsl:when test='@param1 = 211008' >돌던지기</xsl:when>
                     <xsl:when test='@param1 = 211009' >울부짖기#1</xsl:when>
                     <xsl:when test='@param1 = 211010' >울부짖기#2</xsl:when>
                     <xsl:when test='@param1 = 211011' >엉덩방아</xsl:when>
                     <xsl:when test='@param1 = 211012' >조롱#1</xsl:when>
                     <xsl:when test='@param1 = 211013' >조롱#2</xsl:when>
                     <xsl:when test='@param1 = 211014' >조롱#3</xsl:when>
                     <xsl:when test='@param1 = 211015' >잡아 던지기</xsl:when>
                     <xsl:when test='@param1 = 211016' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211017' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211018' >연속 펀치</xsl:when>
                     <xsl:when test='@param1 = 211019' >풍차돌리기 (지속)</xsl:when>
                     <xsl:when test='@param1 = 211101' >단타</xsl:when>
                     <xsl:when test='@param1 = 211102' >장타</xsl:when>
                     <xsl:when test='@param1 = 211103' >태클</xsl:when>
                     <xsl:when test='@param1 = 211105' >강베기</xsl:when>
                     <xsl:when test='@param1 = 211106' >대시</xsl:when>
                     <xsl:when test='@param1 = 211107' >풍차돌리기</xsl:when>
                     <xsl:when test='@param1 = 211109' >울부짖기#1</xsl:when>
                     <xsl:when test='@param1 = 211110' >울부짖기#2</xsl:when>
                     <xsl:when test='@param1 = 211111' >엉덩방아</xsl:when>
                     <xsl:when test='@param1 = 211112' >조롱#1</xsl:when>
                     <xsl:when test='@param1 = 211113' >조롱#2</xsl:when>
                     <xsl:when test='@param1 = 211114' >조롱#3</xsl:when>
                     <xsl:when test='@param1 = 201210' >잡기</xsl:when>
                     <xsl:when test='@param1 = 212001' >연속 공격</xsl:when>
                     <xsl:when test='@param1 = 212002' >띄우기 공격</xsl:when>
                     <xsl:when test='@param1 = 212003' >마법 공격</xsl:when>
                     <xsl:when test='@param1 = 212004' >퀵캐스팅</xsl:when>
                     <xsl:when test='@param1 = 212005' >퀵캐스팅발사</xsl:when>
                     <xsl:when test='@param1 = 212006' >좌측 회피</xsl:when>
                     <xsl:when test='@param1 = 212007' >우측 회피</xsl:when>
                     <xsl:when test='@param1 = 212009' >가드</xsl:when>
                     <xsl:when test='@param1 = 212201' >공격1</xsl:when>
                     <xsl:when test='@param1 = 212202' >공격2</xsl:when>
                     <xsl:when test='@param1 = 212204' >마법1</xsl:when>
                     <xsl:when test='@param1 = 212205' >마법2</xsl:when>
                     <xsl:when test='@param1 = 212206' >마법3</xsl:when>
                     <xsl:when test='@param1 = 212207' >마법4</xsl:when>
                     <xsl:when test='@param1 = 212208' >비명소리</xsl:when>
                     <xsl:when test='@param1 = 212209' >잡기</xsl:when>
                     <xsl:when test='@param1 = 213001' >단타</xsl:when>
                     <xsl:when test='@param1 = 213002' >평타</xsl:when>
                     <xsl:when test='@param1 = 213003' >짖기</xsl:when>
                     <xsl:when test='@param1 = 213004' >삽질1(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 213005' >삽질2(울기)</xsl:when>
                     <xsl:when test='@param1 = 213006' >도발</xsl:when>
                     <xsl:when test='@param1 = 213007' >회전L</xsl:when>
                     <xsl:when test='@param1 = 213008' >회전R</xsl:when>
                     <xsl:when test='@param1 = 213009' >회전180</xsl:when>
                     <xsl:when test='@param1 = 213010' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 213011' >전투뻘짓</xsl:when>
                     <xsl:when test='@param1 = 213012' >반격</xsl:when>
                     <xsl:when test='@param1 = 213013' >왼발공격</xsl:when>
                     <xsl:when test='@param1 = 213014' >오른발공격</xsl:when>
                     <xsl:when test='@param1 = 213101' >단타</xsl:when>
                     <xsl:when test='@param1 = 213102' >평타</xsl:when>
                     <xsl:when test='@param1 = 213103' >짖기</xsl:when>
                     <xsl:when test='@param1 = 213104' >삽질1(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 213105' >삽질2(울기)</xsl:when>
                     <xsl:when test='@param1 = 213106' >도발</xsl:when>
                     <xsl:when test='@param1 = 213107' >회전L</xsl:when>
                     <xsl:when test='@param1 = 213108' >회전R</xsl:when>
                     <xsl:when test='@param1 = 213109' >회전180</xsl:when>
                     <xsl:when test='@param1 = 213110' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 213111' >전투뻘짓</xsl:when>
                     <xsl:when test='@param1 = 213112' >반격</xsl:when>
                     <xsl:when test='@param1 = 213201' >단타</xsl:when>
                     <xsl:when test='@param1 = 213202' >평타</xsl:when>
                     <xsl:when test='@param1 = 213203' >짖기</xsl:when>
                     <xsl:when test='@param1 = 213204' >삽질1(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 213205' >삽질2(울기)</xsl:when>
                     <xsl:when test='@param1 = 213206' >도발</xsl:when>
                     <xsl:when test='@param1 = 213207' >회전L</xsl:when>
                     <xsl:when test='@param1 = 213208' >회전R</xsl:when>
                     <xsl:when test='@param1 = 213209' >회전180</xsl:when>
                     <xsl:when test='@param1 = 213210' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 213211' >전투뻘짓</xsl:when>
                     <xsl:when test='@param1 = 213212' >반격</xsl:when>
                     <xsl:when test='@param1 = 201900' >idle2</xsl:when>
                     <xsl:when test='@param1 = 201901' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 201902' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 201903' >모드전환(burrow)</xsl:when>
                     <xsl:when test='@param1 = 201904' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 201905' >대쉬공격</xsl:when>
                     <xsl:when test='@param1 = 201906' >뿌리공격</xsl:when>
                     <xsl:when test='@param1 = 201907' >성큰</xsl:when>
                     <xsl:when test='@param1 = 201908' >잡기</xsl:when>
                     <xsl:when test='@param1 = 201909' >성큰 - 파워강</xsl:when>
                     <xsl:when test='@param1 = 201921' >좌측 회전(mode1)</xsl:when>
                     <xsl:when test='@param1 = 201922' >우측 회전(mode1)</xsl:when>
                     <xsl:when test='@param1 = 201923' >모드전환(unburrow)</xsl:when>
                     <xsl:when test='@param1 = 201924' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 201925' >양손공격</xsl:when>
                     <xsl:when test='@param1 = 201926' >포자숨결</xsl:when>
                     <xsl:when test='@param1 = 201927' >포자날리기</xsl:when>
                     <xsl:when test='@param1 = 201928' >잡기</xsl:when>
                     <xsl:when test='@param1 = 201929' >활력</xsl:when>
                     <xsl:when test='@param1 = 201930' >첫 모드전환(unburrow)</xsl:when>
                     <xsl:when test='@param1 = 214001' >1타</xsl:when>
                     <xsl:when test='@param1 = 214002' >2연타</xsl:when>
                     <xsl:when test='@param1 = 214003' >3연타</xsl:when>
                     <xsl:when test='@param1 = 214004' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 214005' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 214006' >반격</xsl:when>
                     <xsl:when test='@param1 = 214007' >회피L</xsl:when>
                     <xsl:when test='@param1 = 214008' >회피R</xsl:when>
                     <xsl:when test='@param1 = 214009' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 214010' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 214501' >1타</xsl:when>
                     <xsl:when test='@param1 = 214502' >2연타</xsl:when>
                     <xsl:when test='@param1 = 214503' >3연타</xsl:when>
                     <xsl:when test='@param1 = 214504' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 214505' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 214506' >반격</xsl:when>
                     <xsl:when test='@param1 = 214507' >회피L</xsl:when>
                     <xsl:when test='@param1 = 214508' >회피R</xsl:when>
                     <xsl:when test='@param1 = 221101' >1타</xsl:when>
                     <xsl:when test='@param1 = 221102' >1타</xsl:when>
                     <xsl:when test='@param1 = 221103' >1타</xsl:when>
                     <xsl:when test='@param1 = 221104' >mode1</xsl:when>
                     <xsl:when test='@param1 = 221105' >mode2</xsl:when>
                     <xsl:when test='@param1 = 221106' >mode0</xsl:when>
                     <xsl:when test='@param1 = 221201' >1타</xsl:when>
                     <xsl:when test='@param1 = 221202' >1타</xsl:when>
                     <xsl:when test='@param1 = 221203' >1타</xsl:when>
                     <xsl:when test='@param1 = 221204' >mode1</xsl:when>
                     <xsl:when test='@param1 = 221205' >mode2</xsl:when>
                     <xsl:when test='@param1 = 221206' >mode0</xsl:when>
                     <xsl:when test='@param1 = 600001' >이레인의 여관 등록</xsl:when>
                     <xsl:when test='@param1 = 600002' >무시</xsl:when>
                     <xsl:when test='@param1 = 600003' >긍정</xsl:when>
                     <xsl:when test='@param1 = 600004' >폭소</xsl:when>
                     <xsl:when test='@param1 = 600005' >춤</xsl:when>
                     <xsl:when test='@param1 = 600006' >대화 1</xsl:when>
                     <xsl:when test='@param1 = 600007' >대화 2</xsl:when>
                     <xsl:when test='@param1 = 600008' >부정</xsl:when>
                     <xsl:when test='@param1 = 200025001' >모드전환1</xsl:when>
                     <xsl:when test='@param1 = 200025002' >모드전환0</xsl:when>
                     <xsl:when test='@param1 = 200025101' >뿌리묶기</xsl:when>
                     <xsl:when test='@param1 = 200025201' >모드전환1</xsl:when>
                     <xsl:when test='@param1 = 200025202' >모드전환2</xsl:when>
                     <xsl:when test='@param1 = 200025203' >모드전환3</xsl:when>
                     <xsl:when test='@param1 = 200025204' >모드전환0</xsl:when>
                     <xsl:when test='@param1 = 200025211' >stack공격</xsl:when>
                     <xsl:when test='@param1 = 200025212' >stacknupdate공격</xsl:when>
                     <xsl:when test='@param1 = 200025213' >이속순차감소공격</xsl:when>
                     <xsl:when test='@param1 = 200025214' >stacknupdate공격</xsl:when>
                     <xsl:when test='@param1 = 200009400' >비웃기</xsl:when>
                     <xsl:when test='@param1 = 200009401' >도토리먹기</xsl:when>
                     <xsl:when test='@param1 = 200009410' >종베기</xsl:when>
                     <xsl:when test='@param1 = 200009411' >수직베기</xsl:when>
                     <xsl:when test='@param1 = 200009412' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 200009413' >하단베기</xsl:when>
                     <xsl:when test='@param1 = 200009414' >대쉬공격</xsl:when>
                     <xsl:when test='@param1 = 200009415' >제자리회전공격</xsl:when>
                     <xsl:when test='@param1 = 200009420' >모드전환(버로우)</xsl:when>
                     <xsl:when test='@param1 = 200009421' >모드전환(언버로)</xsl:when>
                     <xsl:when test='@param1 = 200009500' >비웃기</xsl:when>
                     <xsl:when test='@param1 = 200009510' >가드</xsl:when>
                     <xsl:when test='@param1 = 200009511' >베기1</xsl:when>
                     <xsl:when test='@param1 = 200009512' >베기2</xsl:when>
                     <xsl:when test='@param1 = 200009513' >방패치기</xsl:when>
                     <xsl:when test='@param1 = 200009520' >모드전환(버로우)</xsl:when>
                     <xsl:when test='@param1 = 200009521' >모드전환(언버로)</xsl:when>
                     <xsl:when test='@param1 = 210210901' >포효</xsl:when>
                     <xsl:when test='@param1 = 210210902' >리프 어택</xsl:when>
                     <xsl:when test='@param1 = 210210903' >위협</xsl:when>
                     <xsl:when test='@param1 = 210221901' >땅 파기</xsl:when>
                     <xsl:when test='@param1 = 210221902' >포효</xsl:when>
                     <xsl:when test='@param1 = 210221001' >모드전환(1-0)</xsl:when>
                     <xsl:when test='@param1 = 307701' >일하기</xsl:when>
                     <xsl:when test='@param1 = 307702' >쉬기</xsl:when>
                     <xsl:when test='@param1 = 200303302' >2연타</xsl:when>
                     <xsl:when test='@param1 = 200303303' >도발</xsl:when>
                     <xsl:when test='@param1 = 200305701' >공격</xsl:when>
                     <xsl:when test='@param1 = 200305801' >위협</xsl:when>
                     <xsl:when test='@param1 = 200305802' >공격</xsl:when>
                     <xsl:when test='@param1 = 210700100' >idle2(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 210700101' >idle3(울기)</xsl:when>
                     <xsl:when test='@param1 = 210700102' >짖기</xsl:when>
                     <xsl:when test='@param1 = 210700103' >회전L</xsl:when>
                     <xsl:when test='@param1 = 210700104' >회전R</xsl:when>
                     <xsl:when test='@param1 = 210700111' >물기</xsl:when>
                     <xsl:when test='@param1 = 210700112' >물어뜯기</xsl:when>
                     <xsl:when test='@param1 = 210700113' >대쉬물기</xsl:when>
                     <xsl:when test='@param1 = 210700114' >회피회전L</xsl:when>
                     <xsl:when test='@param1 = 210700115' >회피회전R</xsl:when>
                     <xsl:when test='@param1 = 210700116' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 210700800' >idle2(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 210700801' >idle3(울기)</xsl:when>
                     <xsl:when test='@param1 = 210700802' >짖기</xsl:when>
                     <xsl:when test='@param1 = 210700803' >회전L</xsl:when>
                     <xsl:when test='@param1 = 210700804' >회전R</xsl:when>
                     <xsl:when test='@param1 = 210700811' >물기</xsl:when>
                     <xsl:when test='@param1 = 210700812' >물어뜯기</xsl:when>
                     <xsl:when test='@param1 = 210700813' >대쉬물기</xsl:when>
                     <xsl:when test='@param1 = 210700814' >회피회전L</xsl:when>
                     <xsl:when test='@param1 = 210700815' >회피회전R</xsl:when>
                     <xsl:when test='@param1 = 210700816' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 210701001' >물기</xsl:when>
                     <xsl:when test='@param1 = 210701002' >오른손할퀴기</xsl:when>
                     <xsl:when test='@param1 = 210701003' >왼손할퀴기</xsl:when>
                     <xsl:when test='@param1 = 210701004' >흙뿌리기</xsl:when>
                     <xsl:when test='@param1 = 210701005' >회전공격</xsl:when>
                     <xsl:when test='@param1 = 210701006' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 210701007' >으르렁</xsl:when>
                     <xsl:when test='@param1 = 210701008' >멍멍</xsl:when>
                     <xsl:when test='@param1 = 210701009' >아파하기 #1</xsl:when>
                     <xsl:when test='@param1 = 210701010' >아파하기 #2</xsl:when>
                     <xsl:when test='@param1 = 210701020' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 210701021' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 210701022' >무리소환</xsl:when>
                     <xsl:when test='@param1 = 210701023' >으르렁대기(노쿨)</xsl:when>
                     <xsl:when test='@param1 = 210701024' >공포의울부짖음</xsl:when>
                     <xsl:when test='@param1 = 210701025' >회전공격(노쿨)</xsl:when>
                     <xsl:when test='@param1 = 210701101' >1타</xsl:when>
                     <xsl:when test='@param1 = 210701102' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210701103' >3연타</xsl:when>
                     <xsl:when test='@param1 = 210701104' >강한공격(삭제중)</xsl:when>
                     <xsl:when test='@param1 = 210701105' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210701106' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 210701107' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 210701108' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210701109' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210701110' >반격(삭제중)</xsl:when>
                     <xsl:when test='@param1 = 210701111' >역습 포커스</xsl:when>
                     <xsl:when test='@param1 = 210701112' >강격</xsl:when>
                     <xsl:when test='@param1 = 210701113' >충격 반사</xsl:when>
                     <xsl:when test='@param1 = 210701114' >보루</xsl:when>
                     <xsl:when test='@param1 = 210701115' >파멸의 일격</xsl:when>
                     <xsl:when test='@param1 = 210701116' >방패 가격: 기절</xsl:when>
                     <xsl:when test='@param1 = 210701117' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210701118' >방어</xsl:when>
                     <xsl:when test='@param1 = 210701301' >1타</xsl:when>
                     <xsl:when test='@param1 = 210701302' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210701303' >3타</xsl:when>
                     <xsl:when test='@param1 = 210701304' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 210701305' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210701306' >전진공격</xsl:when>
                     <xsl:when test='@param1 = 210701307' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 210701308' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 210701309' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210701310' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210701311' >분노 포커스</xsl:when>
                     <xsl:when test='@param1 = 210701312' >후진공격</xsl:when>
                     <xsl:when test='@param1 = 210701313' >분쇄</xsl:when>
                     <xsl:when test='@param1 = 210702001' >지팡이휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210702002' >전진공격</xsl:when>
                     <xsl:when test='@param1 = 210702003' >후진공격</xsl:when>
                     <xsl:when test='@param1 = 210702004' >화염채찍</xsl:when>
                     <xsl:when test='@param1 = 210702005' >지팡이2연타</xsl:when>
                     <xsl:when test='@param1 = 210702006' >화염구</xsl:when>
                     <xsl:when test='@param1 = 210702007' >프레임게이저</xsl:when>
                     <xsl:when test='@param1 = 210702008' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 210702009' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 210702101' >1타</xsl:when>
                     <xsl:when test='@param1 = 210702102' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210702103' >회전베기</xsl:when>
                     <xsl:when test='@param1 = 210702104' >회피베기</xsl:when>
                     <xsl:when test='@param1 = 210702105' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210702106' >전진공격</xsl:when>
                     <xsl:when test='@param1 = 210702107' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 210702108' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 210702109' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210702110' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210702111' >녹턴</xsl:when>
                     <xsl:when test='@param1 = 210702112' >광폭화</xsl:when>
                     <xsl:when test='@param1 = 210703101' >1타</xsl:when>
                     <xsl:when test='@param1 = 210703102' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210703103' >3연타</xsl:when>
                     <xsl:when test='@param1 = 210703104' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210703105' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210703106' >반격</xsl:when>
                     <xsl:when test='@param1 = 210703107' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210703108' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210703109' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 210703110' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 210703701' >1타</xsl:when>
                     <xsl:when test='@param1 = 210703702' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210703703' >3연타</xsl:when>
                     <xsl:when test='@param1 = 210703704' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210703705' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210703706' >반격</xsl:when>
                     <xsl:when test='@param1 = 210703707' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210703708' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210702201' >대시공격</xsl:when>
                     <xsl:when test='@param1 = 210702202' >뿌리치기</xsl:when>
                     <xsl:when test='@param1 = 210702203' >화염숨결_직선</xsl:when>
                     <xsl:when test='@param1 = 210702204' >화염숨결_지속</xsl:when>
                     <xsl:when test='@param1 = 210702205' >화염숨결_좌우</xsl:when>
                     <xsl:when test='@param1 = 210702206' >회피</xsl:when>
                     <xsl:when test='@param1 = 210702207' >도발</xsl:when>
                     <xsl:when test='@param1 = 210702208' >idle1</xsl:when>
                     <xsl:when test='@param1 = 210702209' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210702301' >일반공격(근접)</xsl:when>
                     <xsl:when test='@param1 = 210702302' >일반활쏘기</xsl:when>
                     <xsl:when test='@param1 = 210702303' >빠른활쏘기</xsl:when>
                     <xsl:when test='@param1 = 210702304' >독화살</xsl:when>
                     <xsl:when test='@param1 = 210702305' >도발</xsl:when>
                     <xsl:when test='@param1 = 210702306' >idle1</xsl:when>
                     <xsl:when test='@param1 = 210702307' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210702401' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210702402' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 210702403' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210702404' >도발</xsl:when>
                     <xsl:when test='@param1 = 210702405' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210702406' >방어</xsl:when>
                     <xsl:when test='@param1 = 210705401' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 210705402' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210705403' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 210705404' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210705405' >좌절</xsl:when>
                     <xsl:when test='@param1 = 210702501' >일반공격(근접)</xsl:when>
                     <xsl:when test='@param1 = 210702502' >일반활쏘기</xsl:when>
                     <xsl:when test='@param1 = 210702503' >빠른활쏘기</xsl:when>
                     <xsl:when test='@param1 = 210702504' >불화살</xsl:when>
                     <xsl:when test='@param1 = 210702601' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210702602' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 210702603' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210702604' >전력질주</xsl:when>
                     <xsl:when test='@param1 = 210702605' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210702701' >일반공격(근접)</xsl:when>
                     <xsl:when test='@param1 = 210702702' >하급치유</xsl:when>
                     <xsl:when test='@param1 = 210702703' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 210702704' >맹독분사</xsl:when>
                     <xsl:when test='@param1 = 210702705' >도발</xsl:when>
                     <xsl:when test='@param1 = 210702706' >맹독폭팔</xsl:when>
                     <xsl:when test='@param1 = 210702801' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210702802' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 210702803' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210702804' >폭탄심기</xsl:when>
                     <xsl:when test='@param1 = 210702805' >가드모션</xsl:when>
                     <xsl:when test='@param1 = 210702806' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210702807' >방어</xsl:when>
                     <xsl:when test='@param1 = 210702901' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210702902' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 210702903' >강타(전진공격)</xsl:when>
                     <xsl:when test='@param1 = 210702904' >도발</xsl:when>
                     <xsl:when test='@param1 = 210702905' >방어</xsl:when>
                     <xsl:when test='@param1 = 210702906' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210703001' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 210703002' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210703003' >포이즌 버스트</xsl:when>
                     <xsl:when test='@param1 = 210703004' >포이즌 스프레이</xsl:when>
                     <xsl:when test='@param1 = 210703005' >idle3</xsl:when>
                     <xsl:when test='@param1 = 210703006' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210703007' >방어</xsl:when>
                     <xsl:when test='@param1 = 210703201' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210703202' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210703203' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 210703204' >idle1</xsl:when>
                     <xsl:when test='@param1 = 210703205' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210703206' >도발</xsl:when>
                     <xsl:when test='@param1 = 210703207' >해골던지기</xsl:when>
                     <xsl:when test='@param1 = 210703208' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 210704701' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210704702' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210704703' >뿌리묶기</xsl:when>
                     <xsl:when test='@param1 = 210704704' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 210921501' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210921502' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210921503' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 210921504' >idle1</xsl:when>
                     <xsl:when test='@param1 = 210921505' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210921506' >도발</xsl:when>
                     <xsl:when test='@param1 = 210921507' >해골던지기</xsl:when>
                     <xsl:when test='@param1 = 210921508' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 210700201' >약타</xsl:when>
                     <xsl:when test='@param1 = 210700202' >강타</xsl:when>
                     <xsl:when test='@param1 = 210700205' >Roar</xsl:when>
                     <xsl:when test='@param1 = 210700206' >삽질(Sleeping)</xsl:when>
                     <xsl:when test='@param1 = 210700207' >흡혈</xsl:when>
                     <xsl:when test='@param1 = 210700301' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210700302' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210700303' >맹독공격</xsl:when>
                     <xsl:when test='@param1 = 210700401' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210700402' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210700501' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210700502' >강타</xsl:when>
                     <xsl:when test='@param1 = 210700601' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210700602' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210700604' >맹독공격</xsl:when>
                     <xsl:when test='@param1 = 210700701' >찍어누르기</xsl:when>
                     <xsl:when test='@param1 = 210700702' >왼손 공격</xsl:when>
                     <xsl:when test='@param1 = 210700703' >점프 공격</xsl:when>
                     <xsl:when test='@param1 = 210700704' >몸통 돌려치기</xsl:when>
                     <xsl:when test='@param1 = 210700705' >테레시스의 입김</xsl:when>
                     <xsl:when test='@param1 = 210700706' >체력회복(흙먹기)</xsl:when>
                     <xsl:when test='@param1 = 210700707' >거미줄발사</xsl:when>
                     <xsl:when test='@param1 = 210700708' >테레시스의 포효</xsl:when>
                     <xsl:when test='@param1 = 210700709' >가드</xsl:when>
                     <xsl:when test='@param1 = 210700710' >회전 L</xsl:when>
                     <xsl:when test='@param1 = 210700711' >회전 R</xsl:when>
                     <xsl:when test='@param1 = 210700712' >pain2</xsl:when>
                     <xsl:when test='@param1 = 210700713' >루트 패턴 1 - 턴 #1</xsl:when>
                     <xsl:when test='@param1 = 210700714' >루트 패턴 2 - 턴 #2</xsl:when>
                     <xsl:when test='@param1 = 210700715' >pain1</xsl:when>
                     <xsl:when test='@param1 = 210705001' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 210705002' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210705003' >거미줄발사</xsl:when>
                     <xsl:when test='@param1 = 210705004' >흡혈</xsl:when>
                     <xsl:when test='@param1 = 210705005' >도발</xsl:when>
                     <xsl:when test='@param1 = 210705006' >거미독감염</xsl:when>
                     <xsl:when test='@param1 = 210722601' >화약 폭발</xsl:when>
                     <xsl:when test='@param1 = 210724701' >폭발</xsl:when>
                     <xsl:when test='@param1 = 210724702' >점화</xsl:when>
                     <xsl:when test='@param1 = 210705500' >idle2(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 210705501' >idle3(울기)</xsl:when>
                     <xsl:when test='@param1 = 210705502' >짖기</xsl:when>
                     <xsl:when test='@param1 = 210705503' >회전L</xsl:when>
                     <xsl:when test='@param1 = 210705504' >회전R</xsl:when>
                     <xsl:when test='@param1 = 210705511' >물기</xsl:when>
                     <xsl:when test='@param1 = 210705512' >물어뜯기</xsl:when>
                     <xsl:when test='@param1 = 210705513' >대쉬물기</xsl:when>
                     <xsl:when test='@param1 = 210705514' >회피회전L</xsl:when>
                     <xsl:when test='@param1 = 210705515' >회피회전R</xsl:when>
                     <xsl:when test='@param1 = 210705516' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 210705520' >모드전환1</xsl:when>
                     <xsl:when test='@param1 = 210705521' >모드전환0</xsl:when>
                     <xsl:when test='@param1 = 210723301' >들이받기</xsl:when>
                     <xsl:when test='@param1 = 210723302' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210723303' >idle1</xsl:when>
                     <xsl:when test='@param1 = 210723304' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210723305' >idle3</xsl:when>
                     <xsl:when test='@param1 = 210723306' >idle4</xsl:when>
                     <xsl:when test='@param1 = 210723307' >idle5</xsl:when>
                     <xsl:when test='@param1 = 210723308' >포효</xsl:when>
                     <xsl:when test='@param1 = 210724801' >idle</xsl:when>
                     <xsl:when test='@param1 = 211000101' >수타</xsl:when>
                     <xsl:when test='@param1 = 211000102' >몽둥이내려치기</xsl:when>
                     <xsl:when test='@param1 = 211000103' >뭉동이후리기</xsl:when>
                     <xsl:when test='@param1 = 211000104' >밀어내기</xsl:when>
                     <xsl:when test='@param1 = 211000105' >강베기</xsl:when>
                     <xsl:when test='@param1 = 211000106' >대시</xsl:when>
                     <xsl:when test='@param1 = 211000107' >풍차돌리기</xsl:when>
                     <xsl:when test='@param1 = 211000108' >돌던지기</xsl:when>
                     <xsl:when test='@param1 = 211000109' >울부짖기#1</xsl:when>
                     <xsl:when test='@param1 = 211000110' >울부짖기#2</xsl:when>
                     <xsl:when test='@param1 = 211000111' >엉덩방아</xsl:when>
                     <xsl:when test='@param1 = 211000112' >도발1-엉덩이치기</xsl:when>
                     <xsl:when test='@param1 = 211000113' >도발2-머리긁적</xsl:when>
                     <xsl:when test='@param1 = 211000114' >도발3-냄새맡기</xsl:when>
                     <xsl:when test='@param1 = 211000115' >OTL</xsl:when>
                     <xsl:when test='@param1 = 211000116' >뒤로벌렁</xsl:when>
                     <xsl:when test='@param1 = 211000117' >아파하기</xsl:when>
                     <xsl:when test='@param1 = 211000146' >잡아 던지기</xsl:when>
                     <xsl:when test='@param1 = 211000148' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211000149' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211000150' >콤보 어택</xsl:when>
                     <xsl:when test='@param1 = 211000201' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211000202' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211000203' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 211000204' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211000205' >방어</xsl:when>
                     <xsl:when test='@param1 = 211000206' >도발</xsl:when>
                     <xsl:when test='@param1 = 211000207' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211000401' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211000402' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211000403' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 211000404' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211000405' >방어</xsl:when>
                     <xsl:when test='@param1 = 211000501' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211000502' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211000503' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 211000504' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211000505' >방어</xsl:when>
                     <xsl:when test='@param1 = 211000601' >포이즌 미사일</xsl:when>
                     <xsl:when test='@param1 = 211000602' >근접 공격</xsl:when>
                     <xsl:when test='@param1 = 211000603' >방어</xsl:when>
                     <xsl:when test='@param1 = 211000604' >도발</xsl:when>
                     <xsl:when test='@param1 = 211000701' >근접공격</xsl:when>
                     <xsl:when test='@param1 = 211000702' >일반활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211000703' >빠른활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211000704' >방어</xsl:when>
                     <xsl:when test='@param1 = 211000705' >마비독공격</xsl:when>
                     <xsl:when test='@param1 = 211001101' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211001102' >근접공격</xsl:when>
                     <xsl:when test='@param1 = 211001103' >뒷발길질</xsl:when>
                     <xsl:when test='@param1 = 211001104' >손바닥치기</xsl:when>
                     <xsl:when test='@param1 = 211001105' >덮치기</xsl:when>
                     <xsl:when test='@param1 = 211001106' >폭탄던지기1</xsl:when>
                     <xsl:when test='@param1 = 211001107' >분노모션</xsl:when>
                     <xsl:when test='@param1 = 211001108' >충격파</xsl:when>
                     <xsl:when test='@param1 = 211001109' >잡기</xsl:when>
                     <xsl:when test='@param1 = 211001110' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211001111' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211001112' >고블린무시</xsl:when>
                     <xsl:when test='@param1 = 211001113' >폭탄던지기2</xsl:when>
                     <xsl:when test='@param1 = 211001114' >폭탄던지기3</xsl:when>
                     <xsl:when test='@param1 = 211001115' >폭탄던지기4</xsl:when>
                     <xsl:when test='@param1 = 211001116' >근접공격2</xsl:when>
                     <xsl:when test='@param1 = 211001117' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211001118' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211001121' >고블린던지기(모드전환)</xsl:when>
                     <xsl:when test='@param1 = 211001122' >근접공격</xsl:when>
                     <xsl:when test='@param1 = 211001123' >뒷발길질</xsl:when>
                     <xsl:when test='@param1 = 211001124' >손바닥치기</xsl:when>
                     <xsl:when test='@param1 = 211001125' >덮치기</xsl:when>
                     <xsl:when test='@param1 = 211001128' >충격파</xsl:when>
                     <xsl:when test='@param1 = 211001129' >잡기</xsl:when>
                     <xsl:when test='@param1 = 211001130' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211001131' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211001132' >근접공격2</xsl:when>
                     <xsl:when test='@param1 = 211001133' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211001134' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211001301' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211001302' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211001303' >대시 공격</xsl:when>
                     <xsl:when test='@param1 = 211001304' >방어</xsl:when>
                     <xsl:when test='@param1 = 211001401' >근접공격</xsl:when>
                     <xsl:when test='@param1 = 211001402' >일반활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211001403' >빠른활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211001404' >연발사격</xsl:when>
                     <xsl:when test='@param1 = 211001501' >포이즌 미사일</xsl:when>
                     <xsl:when test='@param1 = 211001502' >근접 공격</xsl:when>
                     <xsl:when test='@param1 = 211001503' >쇼크 웨이브</xsl:when>
                     <xsl:when test='@param1 = 211001900' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211001901' >화염구</xsl:when>
                     <xsl:when test='@param1 = 211001902' >근접 공격</xsl:when>
                     <xsl:when test='@param1 = 211001903' >화염구(곡사)</xsl:when>
                     <xsl:when test='@param1 = 211002001' >꿀꿀~</xsl:when>
                     <xsl:when test='@param1 = 211002101' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211002102' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211002103' >방어</xsl:when>
                     <xsl:when test='@param1 = 211002104' >태클</xsl:when>
                     <xsl:when test='@param1 = 211002105' >스턴미사일</xsl:when>
                     <xsl:when test='@param1 = 211002106' >삽질</xsl:when>
                     <xsl:when test='@param1 = 211002107' >영역공격</xsl:when>
                     <xsl:when test='@param1 = 211002201' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211002202' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211002203' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 211002204' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211002205' >방어</xsl:when>
                     <xsl:when test='@param1 = 211002301' >근접공격</xsl:when>
                     <xsl:when test='@param1 = 211002302' >일반활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211002303' >빠른활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211002304' >방어</xsl:when>
                     <xsl:when test='@param1 = 211002305' >마비독공격</xsl:when>
                     <xsl:when test='@param1 = 211002306' >폭팔사격</xsl:when>
                     <xsl:when test='@param1 = 211002401' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 211002402' >좌측 공격</xsl:when>
                     <xsl:when test='@param1 = 211002403' >대시 공격</xsl:when>
                     <xsl:when test='@param1 = 211002404' >방어</xsl:when>
                     <xsl:when test='@param1 = 211002501' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211002502' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211002503' >가드</xsl:when>
                     <xsl:when test='@param1 = 211002505' >스턴미사일 II</xsl:when>
                     <xsl:when test='@param1 = 211002507' >영역공격</xsl:when>
                     <xsl:when test='@param1 = 211002508' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 211002601' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211002602' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211002603' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 211002604' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211002605' >방어</xsl:when>
                     <xsl:when test='@param1 = 211002606' >곡굉이질</xsl:when>
                     <xsl:when test='@param1 = 211002701' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211002702' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211002703' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 211002704' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211002705' >방어</xsl:when>
                     <xsl:when test='@param1 = 211002706' >곡굉이질</xsl:when>
                     <xsl:when test='@param1 = 211002801' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211002802' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211002803' >가드</xsl:when>
                     <xsl:when test='@param1 = 211002804' >스턴미사일</xsl:when>
                     <xsl:when test='@param1 = 211002805' >영역공격</xsl:when>
                     <xsl:when test='@param1 = 211002806' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 211002807' >연쇄폭발</xsl:when>
                     <xsl:when test='@param1 = 211002808' >약화의주술</xsl:when>
                     <xsl:when test='@param1 = 211002901' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211002902' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211002903' >가드</xsl:when>
                     <xsl:when test='@param1 = 211002904' >스턴미사일</xsl:when>
                     <xsl:when test='@param1 = 211002905' >영역공격</xsl:when>
                     <xsl:when test='@param1 = 211002906' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 211002907' >연쇄폭발</xsl:when>
                     <xsl:when test='@param1 = 211002908' >약화의주술</xsl:when>
                     <xsl:when test='@param1 = 211003001' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211003002' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211003003' >가드</xsl:when>
                     <xsl:when test='@param1 = 211003004' >스턴미사일</xsl:when>
                     <xsl:when test='@param1 = 211003005' >영역공격</xsl:when>
                     <xsl:when test='@param1 = 211003006' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 211003007' >연쇄폭발</xsl:when>
                     <xsl:when test='@param1 = 211003008' >약화의주술</xsl:when>
                     <xsl:when test='@param1 = 211003101' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211003102' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211003103' >가드</xsl:when>
                     <xsl:when test='@param1 = 211003104' >스턴미사일</xsl:when>
                     <xsl:when test='@param1 = 211003105' >영역공격</xsl:when>
                     <xsl:when test='@param1 = 211003106' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 211003107' >연쇄폭발</xsl:when>
                     <xsl:when test='@param1 = 211003108' >약화의주술</xsl:when>
                     <xsl:when test='@param1 = 211003201' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211003202' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211003203' >가드</xsl:when>
                     <xsl:when test='@param1 = 211003204' >스턴미사일</xsl:when>
                     <xsl:when test='@param1 = 211003205' >영역공격</xsl:when>
                     <xsl:when test='@param1 = 211003206' >하급재생</xsl:when>
                     <xsl:when test='@param1 = 211003207' >연쇄폭발</xsl:when>
                     <xsl:when test='@param1 = 211003208' >약화의주술</xsl:when>
                     <xsl:when test='@param1 = 211003301' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211003302' >독침공격1</xsl:when>
                     <xsl:when test='@param1 = 211003400' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211003401' >idle3</xsl:when>
                     <xsl:when test='@param1 = 211003402' >idle4</xsl:when>
                     <xsl:when test='@param1 = 211003403' >뿔공격</xsl:when>
                     <xsl:when test='@param1 = 211003404' >돌진</xsl:when>
                     <xsl:when test='@param1 = 211003405' >앞발공격</xsl:when>
                     <xsl:when test='@param1 = 211003406' >뒷발공격</xsl:when>
                     <xsl:when test='@param1 = 211003407' >후방회피</xsl:when>
                     <xsl:when test='@param1 = 211003408' >가드</xsl:when>
                     <xsl:when test='@param1 = 211003409' >돌진2(뿔없음)</xsl:when>
                     <xsl:when test='@param1 = 211003500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211003501' >idle3</xsl:when>
                     <xsl:when test='@param1 = 211003502' >idle4</xsl:when>
                     <xsl:when test='@param1 = 211003503' >물기</xsl:when>
                     <xsl:when test='@param1 = 211003504' >점프공격</xsl:when>
                     <xsl:when test='@param1 = 211003505' >후방회피</xsl:when>
                     <xsl:when test='@param1 = 211003506' >포효</xsl:when>
                     <xsl:when test='@param1 = 211003600' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211003601' >idle3</xsl:when>
                     <xsl:when test='@param1 = 211003602' >방전</xsl:when>
                     <xsl:when test='@param1 = 211003603' >돌진</xsl:when>
                     <xsl:when test='@param1 = 211004100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211004101' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 211004102' >연타공격</xsl:when>
                     <xsl:when test='@param1 = 211004103' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211004104' >폭탄던지기</xsl:when>
                     <xsl:when test='@param1 = 211004105' >가드모션</xsl:when>
                     <xsl:when test='@param1 = 211004106' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211004107' >방어</xsl:when>
                     <xsl:when test='@param1 = 211004108' >놀리기</xsl:when>
                     <xsl:when test='@param1 = 211004201' >폭발</xsl:when>
                     <xsl:when test='@param1 = 211004202' >점화</xsl:when>
                     <xsl:when test='@param1 = 211021801' >모드전환(1-0)</xsl:when>
                     <xsl:when test='@param1 = 211022001' >1타</xsl:when>
                     <xsl:when test='@param1 = 211022002' >2연타</xsl:when>
                     <xsl:when test='@param1 = 211022003' >3연타</xsl:when>
                     <xsl:when test='@param1 = 211022004' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211022005' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211022006' >반격</xsl:when>
                     <xsl:when test='@param1 = 211022007' >회피L</xsl:when>
                     <xsl:when test='@param1 = 211022008' >회피R</xsl:when>
                     <xsl:when test='@param1 = 211022009' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 211022010' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 211030101' >1타</xsl:when>
                     <xsl:when test='@param1 = 211030102' >2연타</xsl:when>
                     <xsl:when test='@param1 = 211030103' >3연타</xsl:when>
                     <xsl:when test='@param1 = 211030104' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211030105' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211030106' >반격</xsl:when>
                     <xsl:when test='@param1 = 211030107' >회피L</xsl:when>
                     <xsl:when test='@param1 = 211030108' >회피R</xsl:when>
                     <xsl:when test='@param1 = 211030201' >1타</xsl:when>
                     <xsl:when test='@param1 = 211030202' >2연타</xsl:when>
                     <xsl:when test='@param1 = 211030203' >3연타</xsl:when>
                     <xsl:when test='@param1 = 211030204' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211030205' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211030206' >반격</xsl:when>
                     <xsl:when test='@param1 = 211030207' >회피L</xsl:when>
                     <xsl:when test='@param1 = 211030208' >회피R</xsl:when>
                     <xsl:when test='@param1 = 211030500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211030501' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211030502' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211030503' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211030504' >포효</xsl:when>
                     <xsl:when test='@param1 = 211004300' >으악</xsl:when>
                     <xsl:when test='@param1 = 211004301' >충전</xsl:when>
                     <xsl:when test='@param1 = 211004302' >돌진</xsl:when>
                     <xsl:when test='@param1 = 211004303' >돌진2</xsl:when>
                     <xsl:when test='@param1 = 211004304' >회피</xsl:when>
                     <xsl:when test='@param1 = 211300101' >오른손 내려찍기</xsl:when>
                     <xsl:when test='@param1 = 211300102' >점프내려찍기</xsl:when>
                     <xsl:when test='@param1 = 211300103' >튕겨내기</xsl:when>
                     <xsl:when test='@param1 = 211300106' >두리번거리기</xsl:when>
                     <xsl:when test='@param1 = 211300107' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 211300108' >울부짖기 #2</xsl:when>
                     <xsl:when test='@param1 = 211300109' >두리번거리기#2</xsl:when>
                     <xsl:when test='@param1 = 211300110' >도발</xsl:when>
                     <xsl:when test='@param1 = 211301000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211301001' >위협모션</xsl:when>
                     <xsl:when test='@param1 = 211301002' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 211301003' >덥치기</xsl:when>
                     <xsl:when test='@param1 = 211301004' >토하기</xsl:when>
                     <xsl:when test='@param1 = 211301100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211301101' >위협모션</xsl:when>
                     <xsl:when test='@param1 = 211301102' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 211301103' >덥치기</xsl:when>
                     <xsl:when test='@param1 = 211301104' >토하기</xsl:when>
                     <xsl:when test='@param1 = 211301105' >시체 이그서 특수공격</xsl:when>
                     <xsl:when test='@param1 = 211301500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211301501' >점프공격</xsl:when>
                     <xsl:when test='@param1 = 211301502' >우측강타</xsl:when>
                     <xsl:when test='@param1 = 211301503' >연타</xsl:when>
                     <xsl:when test='@param1 = 211301504' >어께치기</xsl:when>
                     <xsl:when test='@param1 = 211301505' >발차기</xsl:when>
                     <xsl:when test='@param1 = 211301600' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211301601' >활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211301602' >강하게쏘기</xsl:when>
                     <xsl:when test='@param1 = 211301603' >활쏘기 (약)</xsl:when>
                     <xsl:when test='@param1 = 211303001' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 211303002' >물약먹기</xsl:when>
                     <xsl:when test='@param1 = 211303003' >얼음화살</xsl:when>
                     <xsl:when test='@param1 = 211303004' >어둠의보호막</xsl:when>
                     <xsl:when test='@param1 = 211303005' >해골소환</xsl:when>
                     <xsl:when test='@param1 = 211303500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211303501' >머리공격</xsl:when>
                     <xsl:when test='@param1 = 211303502' >휘두르기</xsl:when>
                     <xsl:when test='@param1 = 211303503' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211303600' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211303601' >머리공격</xsl:when>
                     <xsl:when test='@param1 = 211303602' >휘두르기</xsl:when>
                     <xsl:when test='@param1 = 211303603' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211304000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211304001' >일반공격1( 발구르기 )</xsl:when>
                     <xsl:when test='@param1 = 211304002' >일반공격2( 돌진 )</xsl:when>
                     <xsl:when test='@param1 = 211304100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211304101' >일반공격1( 발구르기 )</xsl:when>
                     <xsl:when test='@param1 = 211304102' >일반공격2( 돌진 )</xsl:when>
                     <xsl:when test='@param1 = 211304500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211304501' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211304502' >회전찌르기</xsl:when>
                     <xsl:when test='@param1 = 211304600' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211304601' >활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211304602' >강쏘기</xsl:when>
                     <xsl:when test='@param1 = 211304603' >활로치기</xsl:when>
                     <xsl:when test='@param1 = 211304700' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211304701' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211304702' >회전찌르기</xsl:when>
                     <xsl:when test='@param1 = 211305000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211305001' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 211305002' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211305003' >특수공격1</xsl:when>
                     <xsl:when test='@param1 = 211305004' >특수공격2</xsl:when>
                     <xsl:when test='@param1 = 211305005' >방어</xsl:when>
                     <xsl:when test='@param1 = 211305100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211305101' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 211305102' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211305103' >특수공격1</xsl:when>
                     <xsl:when test='@param1 = 211305104' >특수공격2</xsl:when>
                     <xsl:when test='@param1 = 211305105' >방어</xsl:when>
                     <xsl:when test='@param1 = 211305500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211305501' >모드0전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 211305502' >모드1전환(땅속으로)</xsl:when>
                     <xsl:when test='@param1 = 211305503' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211305504' >띄우기</xsl:when>
                     <xsl:when test='@param1 = 211305505' >스윙2타</xsl:when>
                     <xsl:when test='@param1 = 211305506' >점프찍기</xsl:when>
                     <xsl:when test='@param1 = 211305507' >박치기</xsl:when>
                     <xsl:when test='@param1 = 211305508' >도발</xsl:when>
                     <xsl:when test='@param1 = 211305600' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211305601' >모드0전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 211305602' >모드1전환(땅속으로)</xsl:when>
                     <xsl:when test='@param1 = 211305603' >근접공격</xsl:when>
                     <xsl:when test='@param1 = 211305604' >독침쏘기</xsl:when>
                     <xsl:when test='@param1 = 211305605' >수면침쏘기</xsl:when>
                     <xsl:when test='@param1 = 211305606' >박치기</xsl:when>
                     <xsl:when test='@param1 = 211305607' >도발</xsl:when>
                     <xsl:when test='@param1 = 211305700' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211305701' >모드0전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 211305702' >모드1전환(땅속으로)</xsl:when>
                     <xsl:when test='@param1 = 211305703' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 211305704' >얼음화살</xsl:when>
                     <xsl:when test='@param1 = 211305705' >힐링</xsl:when>
                     <xsl:when test='@param1 = 211305706' >박치기</xsl:when>
                     <xsl:when test='@param1 = 211305707' >도발</xsl:when>
                     <xsl:when test='@param1 = 211306000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211306001' >오른손공격</xsl:when>
                     <xsl:when test='@param1 = 211306002' >양손공격</xsl:when>
                     <xsl:when test='@param1 = 211306003' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 211306004' >포효</xsl:when>
                     <xsl:when test='@param1 = 211306005' >뿌리묶기</xsl:when>
                     <xsl:when test='@param1 = 211306100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211306101' >오른손공격</xsl:when>
                     <xsl:when test='@param1 = 211306102' >양손공격</xsl:when>
                     <xsl:when test='@param1 = 211306103' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 211306104' >포효</xsl:when>
                     <xsl:when test='@param1 = 211306200' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211306201' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211306202' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211306203' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211306204' >포효</xsl:when>
                     <xsl:when test='@param1 = 211306900' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211306901' >모드0전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 211306902' >모드1전환(땅속으로)</xsl:when>
                     <xsl:when test='@param1 = 211306903' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 211306904' >얼음화살</xsl:when>
                     <xsl:when test='@param1 = 211306905' >힐링</xsl:when>
                     <xsl:when test='@param1 = 211306906' >박치기</xsl:when>
                     <xsl:when test='@param1 = 211306907' >도발</xsl:when>
                     <xsl:when test='@param1 = 211306908' >수면가스</xsl:when>
                     <xsl:when test='@param1 = 211307300' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211307301' >1타</xsl:when>
                     <xsl:when test='@param1 = 211307302' >2연타</xsl:when>
                     <xsl:when test='@param1 = 211307303' >3연타</xsl:when>
                     <xsl:when test='@param1 = 211307304' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211307305' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211307306' >반격</xsl:when>
                     <xsl:when test='@param1 = 211307307' >회피L</xsl:when>
                     <xsl:when test='@param1 = 211307308' >회피R</xsl:when>
                     <xsl:when test='@param1 = 211307309' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 211307310' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 211307700' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211307701' >1타</xsl:when>
                     <xsl:when test='@param1 = 211307702' >2연타</xsl:when>
                     <xsl:when test='@param1 = 211307703' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211307704' >회피배기</xsl:when>
                     <xsl:when test='@param1 = 211307705' >돌진</xsl:when>
                     <xsl:when test='@param1 = 211307706' >전진공격</xsl:when>
                     <xsl:when test='@param1 = 211307707' >회피L</xsl:when>
                     <xsl:when test='@param1 = 211307708' >회피R</xsl:when>
                     <xsl:when test='@param1 = 211307709' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 211307710' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 211308000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211308001' >일반공격1( 발구르기 )</xsl:when>
                     <xsl:when test='@param1 = 211308002' >일반공격2( 돌진 )</xsl:when>
                     <xsl:when test='@param1 = 211308003' >얼리기</xsl:when>
                     <xsl:when test='@param1 = 211316001' >포효</xsl:when>
                     <xsl:when test='@param1 = 211316002' >도발</xsl:when>
                     <xsl:when test='@param1 = 211316003' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211316004' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211316010' >정면공격</xsl:when>
                     <xsl:when test='@param1 = 211316011' >좌측공격</xsl:when>
                     <xsl:when test='@param1 = 211316012' >우측공격</xsl:when>
                     <xsl:when test='@param1 = 211316013' >죽음의징표</xsl:when>
                     <xsl:when test='@param1 = 211316014' >뒷발공격</xsl:when>
                     <xsl:when test='@param1 = 211316015' >화염길</xsl:when>
                     <xsl:when test='@param1 = 211316016' >화염폭풍</xsl:when>
                     <xsl:when test='@param1 = 211316017' >돌진시작</xsl:when>
                     <xsl:when test='@param1 = 211316018' >화염발굽(점프) 시작</xsl:when>
                     <xsl:when test='@param1 = 211316019' >최후의돌진시작</xsl:when>
                     <xsl:when test='@param1 = 211316020' >돌진계속</xsl:when>
                     <xsl:when test='@param1 = 211316021' >돌진종료</xsl:when>
                     <xsl:when test='@param1 = 211316022' >돌진강제종료</xsl:when>
                     <xsl:when test='@param1 = 211316023' >최후의돌진종료(노쿨)</xsl:when>
                     <xsl:when test='@param1 = 211316024' >최후의돌진강제종료</xsl:when>
                     <xsl:when test='@param1 = 211316025' >돌진강제종료(제자리)</xsl:when>
                     <xsl:when test='@param1 = 211316026' >최후의돌진강제종료(제자리)</xsl:when>
                     <xsl:when test='@param1 = 211316031' >화염발굽(점프)종료</xsl:when>
                     <xsl:when test='@param1 = 211316040' >참수</xsl:when>
                     <xsl:when test='@param1 = 211316041' >참수 ( camera )</xsl:when>
                     <xsl:when test='@param1 = 211316050' >모드전환0( noani )</xsl:when>
                     <xsl:when test='@param1 = 211316051' >모드전환0</xsl:when>
                     <xsl:when test='@param1 = 211316101' >화염폭풍</xsl:when>
                     <xsl:when test='@param1 = 211316102' >파이어웨이브2</xsl:when>
                     <xsl:when test='@param1 = 211316103' >파이어웨이브3</xsl:when>
                     <xsl:when test='@param1 = 211316104' >파이어웨이브4</xsl:when>
                     <xsl:when test='@param1 = 211316201' >돌진</xsl:when>
                     <xsl:when test='@param1 = 211316202' >자폭</xsl:when>
                     <xsl:when test='@param1 = 211308201' >1타</xsl:when>
                     <xsl:when test='@param1 = 211308202' >2연타</xsl:when>
                     <xsl:when test='@param1 = 211308203' >3연타</xsl:when>
                     <xsl:when test='@param1 = 211308204' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211308205' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 211308206' >반격</xsl:when>
                     <xsl:when test='@param1 = 211308207' >칼뽑기</xsl:when>
                     <xsl:when test='@param1 = 211308208' >발도공격</xsl:when>
                     <xsl:when test='@param1 = 211308209' >칼넣기</xsl:when>
                     <xsl:when test='@param1 = 211308210' >회피L</xsl:when>
                     <xsl:when test='@param1 = 211308211' >회피R</xsl:when>
                     <xsl:when test='@param1 = 211308212' >3타</xsl:when>
                     <xsl:when test='@param1 = 211308300' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211308301' >내려찍기</xsl:when>
                     <xsl:when test='@param1 = 211308302' >휘둘러치기</xsl:when>
                     <xsl:when test='@param1 = 211308303' >올려치기</xsl:when>
                     <xsl:when test='@param1 = 211308304' >잡기</xsl:when>
                     <xsl:when test='@param1 = 211308305' >벌레숨결</xsl:when>
                     <xsl:when test='@param1 = 211308306' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211308307' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211308308' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211308309' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211308310' >tomode1</xsl:when>
                     <xsl:when test='@param1 = 211308311' >tomode0</xsl:when>
                     <xsl:when test='@param1 = 211308320' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211308321' >내려찍기</xsl:when>
                     <xsl:when test='@param1 = 211308322' >휘둘러치기</xsl:when>
                     <xsl:when test='@param1 = 211308323' >올려치기</xsl:when>
                     <xsl:when test='@param1 = 211308324' >잡기</xsl:when>
                     <xsl:when test='@param1 = 211308325' >벌레숨결</xsl:when>
                     <xsl:when test='@param1 = 211308326' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211308327' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211308328' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211308329' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211308330' >tomode0(no ani)</xsl:when>
                     <xsl:when test='@param1 = 211308331' >tomode2(no ani)</xsl:when>
                     <xsl:when test='@param1 = 211308332' >tomode3(no ani)</xsl:when>
                     <xsl:when test='@param1 = 211308400' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211308401' >idle3</xsl:when>
                     <xsl:when test='@param1 = 211308402' >idle4</xsl:when>
                     <xsl:when test='@param1 = 211308403' >뿔공격</xsl:when>
                     <xsl:when test='@param1 = 211308404' >돌진</xsl:when>
                     <xsl:when test='@param1 = 211308405' >앞발공격</xsl:when>
                     <xsl:when test='@param1 = 211308406' >뒷발공격</xsl:when>
                     <xsl:when test='@param1 = 211308407' >후방회피</xsl:when>
                     <xsl:when test='@param1 = 211308408' >가드</xsl:when>
                     <xsl:when test='@param1 = 211308409' >돌진2(뿔없음)</xsl:when>
                     <xsl:when test='@param1 = 211310500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211310501' >활쏘기</xsl:when>
                     <xsl:when test='@param1 = 211310502' >강쏘기</xsl:when>
                     <xsl:when test='@param1 = 211310503' >활로치기</xsl:when>
                     <xsl:when test='@param1 = 211310504' >되살아나기</xsl:when>
                     <xsl:when test='@param1 = 211310600' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211310601' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 211310602' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211310603' >점프연타</xsl:when>
                     <xsl:when test='@param1 = 211310604' >내려찍기</xsl:when>
                     <xsl:when test='@param1 = 211310605' >방어</xsl:when>
                     <xsl:when test='@param1 = 211310606' >되살아나기</xsl:when>
                     <xsl:when test='@param1 = 211315100' >idle2(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 211315101' >idle3(울기)</xsl:when>
                     <xsl:when test='@param1 = 211315102' >짖기</xsl:when>
                     <xsl:when test='@param1 = 211315103' >회전L</xsl:when>
                     <xsl:when test='@param1 = 211315104' >회전R</xsl:when>
                     <xsl:when test='@param1 = 211315111' >물기</xsl:when>
                     <xsl:when test='@param1 = 211315112' >물어뜯기</xsl:when>
                     <xsl:when test='@param1 = 211315113' >대쉬물기</xsl:when>
                     <xsl:when test='@param1 = 211315114' >회피회전L</xsl:when>
                     <xsl:when test='@param1 = 211315115' >회피회전R</xsl:when>
                     <xsl:when test='@param1 = 211315116' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 211315200' >idle2(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 211315201' >idle3(울기)</xsl:when>
                     <xsl:when test='@param1 = 211315202' >짖기</xsl:when>
                     <xsl:when test='@param1 = 211315203' >회전L</xsl:when>
                     <xsl:when test='@param1 = 211315204' >회전R</xsl:when>
                     <xsl:when test='@param1 = 211315211' >물기</xsl:when>
                     <xsl:when test='@param1 = 211315212' >물어뜯기</xsl:when>
                     <xsl:when test='@param1 = 211315213' >대쉬물기</xsl:when>
                     <xsl:when test='@param1 = 211315214' >회피회전L</xsl:when>
                     <xsl:when test='@param1 = 211315215' >회피회전R</xsl:when>
                     <xsl:when test='@param1 = 211315216' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 211315220' >모드전환1</xsl:when>
                     <xsl:when test='@param1 = 211315221' >모드전환0</xsl:when>
                     <xsl:when test='@param1 = 212100600' >idle2</xsl:when>
                     <xsl:when test='@param1 = 212100601' >모드0전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 212100602' >모드1전환(땅속으로)</xsl:when>
                     <xsl:when test='@param1 = 212100603' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 212100604' >띄우기</xsl:when>
                     <xsl:when test='@param1 = 212100605' >스윙2타</xsl:when>
                     <xsl:when test='@param1 = 212100606' >점프찍기</xsl:when>
                     <xsl:when test='@param1 = 212100607' >박치기</xsl:when>
                     <xsl:when test='@param1 = 212100608' >도발</xsl:when>
                     <xsl:when test='@param1 = 212100700' >idle2</xsl:when>
                     <xsl:when test='@param1 = 212100701' >모드0전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 212100702' >모드1전환(땅속으로)</xsl:when>
                     <xsl:when test='@param1 = 212100703' >근접공격</xsl:when>
                     <xsl:when test='@param1 = 212100704' >독침쏘기</xsl:when>
                     <xsl:when test='@param1 = 212100705' >수면침쏘기</xsl:when>
                     <xsl:when test='@param1 = 212100706' >박치기</xsl:when>
                     <xsl:when test='@param1 = 212100707' >도발</xsl:when>
                     <xsl:when test='@param1 = 212100800' >idle2</xsl:when>
                     <xsl:when test='@param1 = 212100801' >모드0전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 212100802' >모드1전환(땅속으로)</xsl:when>
                     <xsl:when test='@param1 = 212100803' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 212100804' >얼음화살</xsl:when>
                     <xsl:when test='@param1 = 212100805' >힐링</xsl:when>
                     <xsl:when test='@param1 = 212100806' >박치기</xsl:when>
                     <xsl:when test='@param1 = 212100807' >도발</xsl:when>
                     <xsl:when test='@param1 = 212100901' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 212100902' >밀쳐내기</xsl:when>
                     <xsl:when test='@param1 = 212100903' >박치기</xsl:when>
                     <xsl:when test='@param1 = 212100904' >한숨</xsl:when>
                     <xsl:when test='@param1 = 212100905' >도발1</xsl:when>
                     <xsl:when test='@param1 = 212100906' >도발2</xsl:when>
                     <xsl:when test='@param1 = 212100907' >가드</xsl:when>
                     <xsl:when test='@param1 = 212100908' >대시 (작은 포물선)</xsl:when>
                     <xsl:when test='@param1 = 212100909' >대시 (큰 포물선)</xsl:when>
                     <xsl:when test='@param1 = 212100910' >대시 (직선)</xsl:when>
                     <xsl:when test='@param1 = 212100911' >회오리 베기</xsl:when>
                     <xsl:when test='@param1 = 212100912' >파이어볼</xsl:when>
                     <xsl:when test='@param1 = 212100913' >수면가스</xsl:when>
                     <xsl:when test='@param1 = 212100914' >모드전환(튀어나오기)</xsl:when>
                     <xsl:when test='@param1 = 212100915' >모드전환(들어가기)</xsl:when>
                     <xsl:when test='@param1 = 212100916' >튀어나오기(연출1)</xsl:when>
                     <xsl:when test='@param1 = 212100917' >수면가스</xsl:when>
                     <xsl:when test='@param1 = 212100918' >도발2(연출3)</xsl:when>
                     <xsl:when test='@param1 = 212100930' >등장</xsl:when>
                     <xsl:when test='@param1 = 212100931' >튀어나오기(ToMode0)</xsl:when>
                     <xsl:when test='@param1 = 212100932' >수면가스</xsl:when>
                     <xsl:when test='@param1 = 212100933' >하품</xsl:when>
                     <xsl:when test='@param1 = 212101900' >idle2</xsl:when>
                     <xsl:when test='@param1 = 212101901' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 212101902' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 212101903' >모드전환(Root)</xsl:when>
                     <xsl:when test='@param1 = 212101904' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 212101905' >대쉬공격</xsl:when>
                     <xsl:when test='@param1 = 212101906' >뿌리공격</xsl:when>
                     <xsl:when test='@param1 = 212101907' >뿌리묶기</xsl:when>
                     <xsl:when test='@param1 = 212101908' >잡기</xsl:when>
                     <xsl:when test='@param1 = 212101909' >화원의균열1</xsl:when>
                     <xsl:when test='@param1 = 212101910' >화원의균열2</xsl:when>
                     <xsl:when test='@param1 = 212101911' >화원의균열3</xsl:when>
                     <xsl:when test='@param1 = 212101912' >pain1( 짧은 )</xsl:when>
                     <xsl:when test='@param1 = 212101913' >pain2( 긴 )</xsl:when>
                     <xsl:when test='@param1 = 212101914' >pain3( 머리 )</xsl:when>
                     <xsl:when test='@param1 = 212101920' >idle3</xsl:when>
                     <xsl:when test='@param1 = 212101921' >좌측 회전(mode1)</xsl:when>
                     <xsl:when test='@param1 = 212101922' >우측 회전(mode1)</xsl:when>
                     <xsl:when test='@param1 = 212101923' >모드전환(Unroot)</xsl:when>
                     <xsl:when test='@param1 = 212101924' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 212101925' >양손공격</xsl:when>
                     <xsl:when test='@param1 = 212101926' >포자숨결</xsl:when>
                     <xsl:when test='@param1 = 212101927' >포자날리기1</xsl:when>
                     <xsl:when test='@param1 = 212101928' >잡기</xsl:when>
                     <xsl:when test='@param1 = 212101929' >활력</xsl:when>
                     <xsl:when test='@param1 = 212101930' >뿌리묶기</xsl:when>
                     <xsl:when test='@param1 = 212101931' >pain1( mode1 )</xsl:when>
                     <xsl:when test='@param1 = 212101932' >포효</xsl:when>
                     <xsl:when test='@param1 = 212101933' >포자날리기2</xsl:when>
                     <xsl:when test='@param1 = 212101934' >포자날리기3</xsl:when>
                     <xsl:when test='@param1 = 212101935' >포자날리기4</xsl:when>
                     <xsl:when test='@param1 = 212101940' >모드전환(꼬리잘림)</xsl:when>
                     <xsl:when test='@param1 = 212101949' >화원의균열1</xsl:when>
                     <xsl:when test='@param1 = 212101950' >화원의균열2</xsl:when>
                     <xsl:when test='@param1 = 212101951' >화원의균열3</xsl:when>
                     <xsl:when test='@param1 = 212101960' >포효(연출1)</xsl:when>
                     <xsl:when test='@param1 = 212101961' >모드전환(Unroot(연출2))</xsl:when>
                     <xsl:when test='@param1 = 212101962' >화원의균열1(연출3)</xsl:when>
                     <xsl:when test='@param1 = 212102101' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 212102102' >독침공격1</xsl:when>
                     <xsl:when test='@param1 = 212102103' >밀쳐내기 공격</xsl:when>
                     <xsl:when test='@param1 = 212102201' >모드전환(문열기)</xsl:when>
                     <xsl:when test='@param1 = 212102202' >모드전환(문닫기)</xsl:when>
                     <xsl:when test='@param1 = 212103301' >open</xsl:when>
                     <xsl:when test='@param1 = 212103302' >close</xsl:when>
                     <xsl:when test='@param1 = 212104401' >레버돌리기</xsl:when>
                     <xsl:when test='@param1 = 212110001' >독뿜기</xsl:when>
                     <xsl:when test='@param1 = 212110002' >독뿜기(이펙트)</xsl:when>
                     <xsl:when test='@param1 = 212110003' >가시덩굴(직선형)</xsl:when>
                     <xsl:when test='@param1 = 212110004' >가시덩굴(낱개형)</xsl:when>
                     <xsl:when test='@param1 = 212120101' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 212120102' >독침공격</xsl:when>
                     <xsl:when test='@param1 = 212120103' >말벌의 독침공격</xsl:when>
                     <xsl:when test='@param1 = 251200001' >pain1</xsl:when>
                     <xsl:when test='@param1 = 251200002' >pain2</xsl:when>
                     <xsl:when test='@param1 = 251200003' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200004' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200005' >종휘두르기1</xsl:when>
                     <xsl:when test='@param1 = 251200006' >종휘두르기2</xsl:when>
                     <xsl:when test='@param1 = 251200007' >소환의종소리</xsl:when>
                     <xsl:when test='@param1 = 251200008' >시끄러운종소리</xsl:when>
                     <xsl:when test='@param1 = 251200010' >돌진하는균열1</xsl:when>
                     <xsl:when test='@param1 = 251200011' >돌진하는균열2</xsl:when>
                     <xsl:when test='@param1 = 251200012' >돌진하는균열3</xsl:when>
                     <xsl:when test='@param1 = 251200013' >돌진하는균열4</xsl:when>
                     <xsl:when test='@param1 = 251200020' >어둠의대지</xsl:when>
                     <xsl:when test='@param1 = 251200022' >공포의장막</xsl:when>
                     <xsl:when test='@param1 = 251200030' >모드전환1(noani)</xsl:when>
                     <xsl:when test='@param1 = 251200031' >모드전환2(noani)</xsl:when>
                     <xsl:when test='@param1 = 251200040' >소환의종소리(연출)</xsl:when>
                     <xsl:when test='@param1 = 251200041' >공포의장막(연출)</xsl:when>
                     <xsl:when test='@param1 = 251200300' >어둠의대지</xsl:when>
                     <xsl:when test='@param1 = 251200301' >실체화</xsl:when>
                     <xsl:when test='@param1 = 251200302' >돌진하는균열1</xsl:when>
                     <xsl:when test='@param1 = 251200303' >돌진하는균열2</xsl:when>
                     <xsl:when test='@param1 = 251200304' >돌진하는균열3</xsl:when>
                     <xsl:when test='@param1 = 251200305' >돌진하는균열4</xsl:when>
                     <xsl:when test='@param1 = 251200400' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251200401' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200402' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200403' >뒤로 튕기기</xsl:when>
                     <xsl:when test='@param1 = 251200404' >포효</xsl:when>
                     <xsl:when test='@param1 = 251200410' >휘두르기</xsl:when>
                     <xsl:when test='@param1 = 251200411' >올려치기</xsl:when>
                     <xsl:when test='@param1 = 251200101' >pain1</xsl:when>
                     <xsl:when test='@param1 = 251200102' >pain2</xsl:when>
                     <xsl:when test='@param1 = 251200103' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200104' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200105' >지목(mode1)</xsl:when>
                     <xsl:when test='@param1 = 251200106' >지목(mode2)</xsl:when>
                     <xsl:when test='@param1 = 251200107' >지침1(mode0)</xsl:when>
                     <xsl:when test='@param1 = 251200108' >지침2(mode0)</xsl:when>
                     <xsl:when test='@param1 = 251200109' >광폭화+분노폭팔(mode3)</xsl:when>
                     <xsl:when test='@param1 = 251200110' >세로베기</xsl:when>
                     <xsl:when test='@param1 = 251200111' >올려치기</xsl:when>
                     <xsl:when test='@param1 = 251200112' >빗겨치기</xsl:when>
                     <xsl:when test='@param1 = 251200113' >세로베기(광폭화)</xsl:when>
                     <xsl:when test='@param1 = 251200114' >올려치기(광폭화)</xsl:when>
                     <xsl:when test='@param1 = 251200115' >빗겨치기(광폭화)</xsl:when>
                     <xsl:when test='@param1 = 251200120' >러쉬세로베기(제자리)</xsl:when>
                     <xsl:when test='@param1 = 251200121' >러쉬세로베기(광폭화)</xsl:when>
                     <xsl:when test='@param1 = 251200122' >러쉬세로베기(전투종료)</xsl:when>
                     <xsl:when test='@param1 = 251200130' >러쉬가로베기(제자리)</xsl:when>
                     <xsl:when test='@param1 = 251200131' >러쉬가로베기(광폭화)</xsl:when>
                     <xsl:when test='@param1 = 251200132' >러쉬가로베기(전투종료)</xsl:when>
                     <xsl:when test='@param1 = 251200140' >지침3(모드전환없음)</xsl:when>
                     <xsl:when test='@param1 = 251200141' >지침4(모드전환없음)</xsl:when>
                     <xsl:when test='@param1 = 251200150' >분노폭팔(모드전환없음)</xsl:when>
                     <xsl:when test='@param1 = 251200151' >모드전환0(no ani)</xsl:when>
                     <xsl:when test='@param1 = 251200160' >지목(mode1)연출</xsl:when>
                     <xsl:when test='@param1 = 251200161' >러쉬세로베기(전투종료)연출</xsl:when>
                     <xsl:when test='@param1 = 251200162' >분노폭팔(모드전환없음)연출</xsl:when>
                     <xsl:when test='@param1 = 251200200' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251200201' >pain1</xsl:when>
                     <xsl:when test='@param1 = 251200202' >pain2</xsl:when>
                     <xsl:when test='@param1 = 251200203' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200204' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 251200205' >영혼 흡수</xsl:when>
                     <xsl:when test='@param1 = 251200206' >게리롱푸리롱</xsl:when>
                     <xsl:when test='@param1 = 251200207' >닌자짓</xsl:when>
                     <xsl:when test='@param1 = 251200208' >융합중</xsl:when>
                     <xsl:when test='@param1 = 251200210' >지팡이휘두르기</xsl:when>
                     <xsl:when test='@param1 = 251200211' >빔발사</xsl:when>
                     <xsl:when test='@param1 = 251200212' >가장검은밤(광역공격)</xsl:when>
                     <xsl:when test='@param1 = 251200213' >가장붉은밤(광역공격)</xsl:when>
                     <xsl:when test='@param1 = 251200214' >어둠의선언</xsl:when>
                     <xsl:when test='@param1 = 251200215' >구슬소환+</xsl:when>
                     <xsl:when test='@param1 = 251200216' >구슬소환-</xsl:when>
                     <xsl:when test='@param1 = 251200217' >구슬소환+-</xsl:when>
                     <xsl:when test='@param1 = 251200218' >어둠의보호막</xsl:when>
                     <xsl:when test='@param1 = 251200220' >모드전환1</xsl:when>
                     <xsl:when test='@param1 = 251200221' >모드전환2</xsl:when>
                     <xsl:when test='@param1 = 251200222' >모드전환3</xsl:when>
                     <xsl:when test='@param1 = 251200230' >어둠의선언(연출)</xsl:when>
                     <xsl:when test='@param1 = 251220200' >문열기</xsl:when>
                     <xsl:when test='@param1 = 251220800' >레버돌리기</xsl:when>
                     <xsl:when test='@param1 = 251210000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251210001' >점프공격</xsl:when>
                     <xsl:when test='@param1 = 251210002' >우측강타</xsl:when>
                     <xsl:when test='@param1 = 251210003' >연타</xsl:when>
                     <xsl:when test='@param1 = 251210004' >어깨치기</xsl:when>
                     <xsl:when test='@param1 = 251210005' >발차기</xsl:when>
                     <xsl:when test='@param1 = 251210006' >방어</xsl:when>
                     <xsl:when test='@param1 = 251210101' >찌르고어퍼컷</xsl:when>
                     <xsl:when test='@param1 = 251210102' >베기</xsl:when>
                     <xsl:when test='@param1 = 251210103' >발목절단</xsl:when>
                     <xsl:when test='@param1 = 251210201' >배기</xsl:when>
                     <xsl:when test='@param1 = 251210202' >잡기</xsl:when>
                     <xsl:when test='@param1 = 251210203' >방어</xsl:when>
                     <xsl:when test='@param1 = 251210301' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 251210302' >물약먹기</xsl:when>
                     <xsl:when test='@param1 = 251210303' >얼음화살</xsl:when>
                     <xsl:when test='@param1 = 251210304' >마나보호막</xsl:when>
                     <xsl:when test='@param1 = 251210305' >해골소환</xsl:when>
                     <xsl:when test='@param1 = 251210500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251210501' >머리공격</xsl:when>
                     <xsl:when test='@param1 = 251210502' >휘두르기</xsl:when>
                     <xsl:when test='@param1 = 251210503' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 251210800' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251210801' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 251210802' >회전찌르기</xsl:when>
                     <xsl:when test='@param1 = 251211000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251211001' >활쏘기</xsl:when>
                     <xsl:when test='@param1 = 251211002' >강쏘기</xsl:when>
                     <xsl:when test='@param1 = 251211003' >활로치기</xsl:when>
                     <xsl:when test='@param1 = 251211100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251211101' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 251211102' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 251211103' >특수공격1</xsl:when>
                     <xsl:when test='@param1 = 251211104' >특수공격2</xsl:when>
                     <xsl:when test='@param1 = 251211105' >방어</xsl:when>
                     <xsl:when test='@param1 = 210200300' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210200301' >포효1</xsl:when>
                     <xsl:when test='@param1 = 210200302' >포효2</xsl:when>
                     <xsl:when test='@param1 = 210200303' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 210200304' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210200305' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210200306' >대쉬공격</xsl:when>
                     <xsl:when test='@param1 = 210200307' >돌던지기</xsl:when>
                     <xsl:when test='@param1 = 210200308' >엉덩방아</xsl:when>
                     <xsl:when test='@param1 = 210200309' >포효</xsl:when>
                     <xsl:when test='@param1 = 210200310' >점화</xsl:when>
                     <xsl:when test='@param1 = 210210000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210210001' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 210210002' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 210210100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210210101' >망치공격</xsl:when>
                     <xsl:when test='@param1 = 210210102' >방패공격</xsl:when>
                     <xsl:when test='@param1 = 210210103' >헤딩</xsl:when>
                     <xsl:when test='@param1 = 210210104' >방어</xsl:when>
                     <xsl:when test='@param1 = 210210105' >포효</xsl:when>
                     <xsl:when test='@param1 = 210210201' >총쏘기</xsl:when>
                     <xsl:when test='@param1 = 210210202' >총돌려쏘기</xsl:when>
                     <xsl:when test='@param1 = 210210203' >폭팔사격</xsl:when>
                     <xsl:when test='@param1 = 210210301' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 210210302' >화염구</xsl:when>
                     <xsl:when test='@param1 = 210210400' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210210401' >idle3</xsl:when>
                     <xsl:when test='@param1 = 210210402' >idle4</xsl:when>
                     <xsl:when test='@param1 = 210210403' >물기</xsl:when>
                     <xsl:when test='@param1 = 210210404' >점프공격</xsl:when>
                     <xsl:when test='@param1 = 210210405' >후방회피</xsl:when>
                     <xsl:when test='@param1 = 210210406' >포효</xsl:when>
                     <xsl:when test='@param1 = 210210407' >깜놀</xsl:when>
                     <xsl:when test='@param1 = 210210500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210210501' >idle3</xsl:when>
                     <xsl:when test='@param1 = 210210502' >idle4</xsl:when>
                     <xsl:when test='@param1 = 210210503' >물기</xsl:when>
                     <xsl:when test='@param1 = 210210504' >점프공격</xsl:when>
                     <xsl:when test='@param1 = 210210505' >후방회피</xsl:when>
                     <xsl:when test='@param1 = 210210506' >포효</xsl:when>
                     <xsl:when test='@param1 = 210211601' >찌르기공격</xsl:when>
                     <xsl:when test='@param1 = 210211602' >휘두르기 공격</xsl:when>
                     <xsl:when test='@param1 = 210211603' >방어</xsl:when>
                     <xsl:when test='@param1 = 210211604' >포효</xsl:when>
                     <xsl:when test='@param1 = 210210600' >발톱강하1( 수직복귀 )</xsl:when>
                     <xsl:when test='@param1 = 210210601' >발톱강하1( 점프복귀 )</xsl:when>
                     <xsl:when test='@param1 = 210210602' >2단할퀴기</xsl:when>
                     <xsl:when test='@param1 = 210210603' >2단할퀴기</xsl:when>
                     <xsl:when test='@param1 = 210210604' >비명</xsl:when>
                     <xsl:when test='@param1 = 210210605' >돌개바람</xsl:when>
                     <xsl:when test='@param1 = 210210606' >대쉬</xsl:when>
                     <xsl:when test='@param1 = 210211001' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 210211002' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 210211003' >분노</xsl:when>
                     <xsl:when test='@param1 = 210211004' >냉기포효</xsl:when>
                     <xsl:when test='@param1 = 210211005' >pain1(2초)</xsl:when>
                     <xsl:when test='@param1 = 210211006' >pain2(5초)</xsl:when>
                     <xsl:when test='@param1 = 210211007' >오른손내려치기</xsl:when>
                     <xsl:when test='@param1 = 210211008' >왼손휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211009' >앞점프찍기</xsl:when>
                     <xsl:when test='@param1 = 210211010' >앞점프휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211011' >왼점프찍기</xsl:when>
                     <xsl:when test='@param1 = 210211012' >왼점프휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211013' >오른점프찍기</xsl:when>
                     <xsl:when test='@param1 = 210211014' >오른점프휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211015' >뒤점프찍기</xsl:when>
                     <xsl:when test='@param1 = 210211016' >뒤점프휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211017' >제자리점프찍기</xsl:when>
                     <xsl:when test='@param1 = 210211018' >연속휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211019' >얼음던지기1</xsl:when>
                     <xsl:when test='@param1 = 210211020' >얼음던지기2</xsl:when>
                     <xsl:when test='@param1 = 210211021' >얼음던지기3</xsl:when>
                     <xsl:when test='@param1 = 210211022' >얼음던지기4</xsl:when>
                     <xsl:when test='@param1 = 210211023' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210211024' >두리번</xsl:when>
                     <xsl:when test='@param1 = 210211025' >냉기포효(빠른)</xsl:when>
                     <xsl:when test='@param1 = 210211031' >왼손휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211032' >연속휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210211033' >냉기포효(쿨타임짧은)</xsl:when>
                     <xsl:when test='@param1 = 210211101' >물기</xsl:when>
                     <xsl:when test='@param1 = 210211102' >오른손공격</xsl:when>
                     <xsl:when test='@param1 = 210211103' >왼손공격</xsl:when>
                     <xsl:when test='@param1 = 210211104' >흙뿌리기</xsl:when>
                     <xsl:when test='@param1 = 210211105' >회전공격</xsl:when>
                     <xsl:when test='@param1 = 210211106' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 210211107' >도발 - 으르렁대기</xsl:when>
                     <xsl:when test='@param1 = 210211108' >도발 - 짖기</xsl:when>
                     <xsl:when test='@param1 = 210211109' >아파하기 #1( 복제 )</xsl:when>
                     <xsl:when test='@param1 = 210211110' >아파하기 #2</xsl:when>
                     <xsl:when test='@param1 = 210211111' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 210211112' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 210211113' >부름</xsl:when>
                     <xsl:when test='@param1 = 210212001' >1타</xsl:when>
                     <xsl:when test='@param1 = 210212002' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210212003' >3연타</xsl:when>
                     <xsl:when test='@param1 = 210212005' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210212006' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 210212007' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 210212008' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210212009' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210212011' >역습 포커스</xsl:when>
                     <xsl:when test='@param1 = 210212012' >강격</xsl:when>
                     <xsl:when test='@param1 = 210212013' >충격 반사</xsl:when>
                     <xsl:when test='@param1 = 210212014' >보루</xsl:when>
                     <xsl:when test='@param1 = 210212015' >파멸의 일격</xsl:when>
                     <xsl:when test='@param1 = 210212016' >방패 가격: 기절</xsl:when>
                     <xsl:when test='@param1 = 210212017' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210212018' >방어</xsl:when>
                     <xsl:when test='@param1 = 210222301' >1타</xsl:when>
                     <xsl:when test='@param1 = 210222302' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210222303' >3연타</xsl:when>
                     <xsl:when test='@param1 = 210222304' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210222305' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210222306' >반격</xsl:when>
                     <xsl:when test='@param1 = 210222307' >칼뽑기</xsl:when>
                     <xsl:when test='@param1 = 210222308' >발도공격</xsl:when>
                     <xsl:when test='@param1 = 210222309' >칼넣기</xsl:when>
                     <xsl:when test='@param1 = 210222310' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210222311' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210222312' >3타</xsl:when>
                     <xsl:when test='@param1 = 210215001' >의식치루기</xsl:when>
                     <xsl:when test='@param1 = 210215002' >짧은 의식치루기</xsl:when>
                     <xsl:when test='@param1 = 210215003' >짧은 의식치루기2</xsl:when>
                     <xsl:when test='@param1 = 211100301' >찍어누르기</xsl:when>
                     <xsl:when test='@param1 = 211100302' >왼손 공격</xsl:when>
                     <xsl:when test='@param1 = 211100303' >점프 공격</xsl:when>
                     <xsl:when test='@param1 = 211100304' >몸통 돌려치기</xsl:when>
                     <xsl:when test='@param1 = 211100305' >테레시스의 입김</xsl:when>
                     <xsl:when test='@param1 = 211100306' >체력회복(흙먹기)</xsl:when>
                     <xsl:when test='@param1 = 211100307' >독발사</xsl:when>
                     <xsl:when test='@param1 = 211100308' >테레시스의 포효</xsl:when>
                     <xsl:when test='@param1 = 211100309' >가드</xsl:when>
                     <xsl:when test='@param1 = 211100310' >회전 L</xsl:when>
                     <xsl:when test='@param1 = 211100311' >회전 R</xsl:when>
                     <xsl:when test='@param1 = 211100312' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211100313' >루트 패턴 1 - 턴 #1</xsl:when>
                     <xsl:when test='@param1 = 211100314' >루트 패턴 2 - 턴 #2</xsl:when>
                     <xsl:when test='@param1 = 211100315' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211100316' >독구름</xsl:when>
                     <xsl:when test='@param1 = 211100317' >자기 독구름</xsl:when>
                     <xsl:when test='@param1 = 211100318' >넘어지기</xsl:when>
                     <xsl:when test='@param1 = 211100319' >유저에게 거미줄</xsl:when>
                     <xsl:when test='@param1 = 211100320' >독구름필살기</xsl:when>
                     <xsl:when test='@param1 = 211100321' >페이즈변화</xsl:when>
                     <xsl:when test='@param1 = 211103401' >오른발 치기</xsl:when>
                     <xsl:when test='@param1 = 211103402' >왼발 치기</xsl:when>
                     <xsl:when test='@param1 = 211103403' >머리 올리기</xsl:when>
                     <xsl:when test='@param1 = 211103404' >머리 좌우 치기</xsl:when>
                     <xsl:when test='@param1 = 211103405' >날기_바람날리기</xsl:when>
                     <xsl:when test='@param1 = 211103406' >점프_찍기</xsl:when>
                     <xsl:when test='@param1 = 211103407' >독 발사</xsl:when>
                     <xsl:when test='@param1 = 211103408' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211103409' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211103410' >pain3</xsl:when>
                     <xsl:when test='@param1 = 211103411' >주변에독구름_생성</xsl:when>
                     <xsl:when test='@param1 = 211103412' >자기한테독구름_생성</xsl:when>
                     <xsl:when test='@param1 = 211103413' >독구름폭풍</xsl:when>
                     <xsl:when test='@param1 = 211103414' >성스런폭발</xsl:when>
                     <xsl:when test='@param1 = 211103415' >러쉬</xsl:when>
                     <xsl:when test='@param1 = 211103417' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211103418' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211103419' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211103420' >빠른 머리 올리기</xsl:when>
                     <xsl:when test='@param1 = 211103423' >성스런폭발</xsl:when>
                     <xsl:when test='@param1 = 211103421' >아주 빠른 머리 올리기</xsl:when>
                     <xsl:when test='@param1 = 211103422' >아주 빠른 머리 좌우치기</xsl:when>
                     <xsl:when test='@param1 = 211103424' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211103425' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211103430' >분노모드전환(noani)</xsl:when>
                     <xsl:when test='@param1 = 211103431' >일반모드전환(noani)</xsl:when>
                     <xsl:when test='@param1 = 211103450' >주변에독구름_생성</xsl:when>
                     <xsl:when test='@param1 = 211103451' >자기한테독구름_생성</xsl:when>
                     <xsl:when test='@param1 = 211103452' >유저따라가기</xsl:when>
                     <xsl:when test='@param1 = 211101001' >idle</xsl:when>
                     <xsl:when test='@param1 = 211101002' >내려찍기</xsl:when>
                     <xsl:when test='@param1 = 211101003' >왼손휘두르기</xsl:when>
                     <xsl:when test='@param1 = 211101004' >오른손휘두르기</xsl:when>
                     <xsl:when test='@param1 = 211101005' >양손휘두르기</xsl:when>
                     <xsl:when test='@param1 = 211101006' >태클</xsl:when>
                     <xsl:when test='@param1 = 211101007' >포효</xsl:when>
                     <xsl:when test='@param1 = 211101101' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 211101102' >화염구</xsl:when>
                     <xsl:when test='@param1 = 211101200' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211101201' >망치공격</xsl:when>
                     <xsl:when test='@param1 = 211101202' >방패공격</xsl:when>
                     <xsl:when test='@param1 = 211101203' >헤딩</xsl:when>
                     <xsl:when test='@param1 = 211101204' >방어</xsl:when>
                     <xsl:when test='@param1 = 211101205' >포효</xsl:when>
                     <xsl:when test='@param1 = 211101301' >찌르기공격</xsl:when>
                     <xsl:when test='@param1 = 211101302' >휘두르기 공격</xsl:when>
                     <xsl:when test='@param1 = 211101304' >포효</xsl:when>
                     <xsl:when test='@param1 = 211101401' >총쏘기</xsl:when>
                     <xsl:when test='@param1 = 211101402' >총돌려쏘기</xsl:when>
                     <xsl:when test='@param1 = 211101403' >폭팔사격</xsl:when>
                     <xsl:when test='@param1 = 211101501' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211101502' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211101503' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211103000' >idle</xsl:when>
                     <xsl:when test='@param1 = 211103001' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211103002' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211103003' >회전공격L</xsl:when>
                     <xsl:when test='@param1 = 211103004' >회전공격R</xsl:when>
                     <xsl:when test='@param1 = 211103005' >마법</xsl:when>
                     <xsl:when test='@param1 = 211103101' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 211103102' >일반공격2</xsl:when>
                     <xsl:when test='@param1 = 211103103' >잡기</xsl:when>
                     <xsl:when test='@param1 = 211103104' >공포의 스크림</xsl:when>
                     <xsl:when test='@param1 = 211103201' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 211103202' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 211103203' >거미줄</xsl:when>
                     <xsl:when test='@param1 = 211103204' >거미줄</xsl:when>
                     <xsl:when test='@param1 = 211103211' >tomode0</xsl:when>
                     <xsl:when test='@param1 = 211103212' >tomode1 (no ani)</xsl:when>
                     <xsl:when test='@param1 = 211103500' >idle</xsl:when>
                     <xsl:when test='@param1 = 211103501' >1타</xsl:when>
                     <xsl:when test='@param1 = 211103502' >2연타</xsl:when>
                     <xsl:when test='@param1 = 211103503' >3연타</xsl:when>
                     <xsl:when test='@param1 = 211103504' >roar</xsl:when>
                     <xsl:when test='@param1 = 211103601' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 211103602' >화염구</xsl:when>
                     <xsl:when test='@param1 = 211101700' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211101701' >망치공격</xsl:when>
                     <xsl:when test='@param1 = 211101702' >방패공격</xsl:when>
                     <xsl:when test='@param1 = 211101703' >헤딩</xsl:when>
                     <xsl:when test='@param1 = 211101704' >방어</xsl:when>
                     <xsl:when test='@param1 = 211101705' >포효</xsl:when>
                     <xsl:when test='@param1 = 211125601' >방어</xsl:when>
                     <xsl:when test='@param1 = 211125602' >반격</xsl:when>
                     <xsl:when test='@param1 = 211125603' >강타</xsl:when>
                     <xsl:when test='@param1 = 211125701' >망치공격</xsl:when>
                     <xsl:when test='@param1 = 211125801' >총쏘기</xsl:when>
                     <xsl:when test='@param1 = 211125802' >기절탄</xsl:when>
                     <xsl:when test='@param1 = 211125803' >총돌려쏘기</xsl:when>
                     <xsl:when test='@param1 = 210901701' >1타</xsl:when>
                     <xsl:when test='@param1 = 210901702' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210901703' >3연타</xsl:when>
                     <xsl:when test='@param1 = 210901704' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210901705' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210901706' >반격</xsl:when>
                     <xsl:when test='@param1 = 210901707' >칼뽑기</xsl:when>
                     <xsl:when test='@param1 = 210901708' >발도공격</xsl:when>
                     <xsl:when test='@param1 = 210901709' >칼넣기</xsl:when>
                     <xsl:when test='@param1 = 210901710' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210901711' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210901712' >3타</xsl:when>
                     <xsl:when test='@param1 = 210901713' >모켄의 사자후</xsl:when>
                     <xsl:when test='@param1 = 210901714' >모켄의 사자후2</xsl:when>
                     <xsl:when test='@param1 = 210901715' >제일스의 사자후</xsl:when>
                     <xsl:when test='@param1 = 210901716' >제일스의 지배</xsl:when>
                     <xsl:when test='@param1 = 210901730' >파멸의 일격</xsl:when>
                     <xsl:when test='@param1 = 210901801' >1타</xsl:when>
                     <xsl:when test='@param1 = 210901802' >2연타</xsl:when>
                     <xsl:when test='@param1 = 210901803' >3연타</xsl:when>
                     <xsl:when test='@param1 = 210901804' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 210901805' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210901806' >반격</xsl:when>
                     <xsl:when test='@param1 = 210901807' >칼뽑기</xsl:when>
                     <xsl:when test='@param1 = 210901808' >발도공격</xsl:when>
                     <xsl:when test='@param1 = 210901809' >칼넣기</xsl:when>
                     <xsl:when test='@param1 = 210901810' >회피L</xsl:when>
                     <xsl:when test='@param1 = 210901811' >회피R</xsl:when>
                     <xsl:when test='@param1 = 210901812' >3타</xsl:when>
                     <xsl:when test='@param1 = 210901813' >티안의 일격</xsl:when>
                     <xsl:when test='@param1 = 210902602' >idle1</xsl:when>
                     <xsl:when test='@param1 = 210902603' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210909800' >안간힘쓰기</xsl:when>
                     <xsl:when test='@param1 = 210909801' >포효</xsl:when>
                     <xsl:when test='@param1 = 210909802' >꼬리치기</xsl:when>
                     <xsl:when test='@param1 = 210909803' >침뱉기</xsl:when>
                     <xsl:when test='@param1 = 210909900' >두리번(idle2)</xsl:when>
                     <xsl:when test='@param1 = 210909901' >도발</xsl:when>
                     <xsl:when test='@param1 = 210909902' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 210909910' >할퀴기</xsl:when>
                     <xsl:when test='@param1 = 210909911' >양손펀치</xsl:when>
                     <xsl:when test='@param1 = 210909912' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 210909913' >해골던지기</xsl:when>
                     <xsl:when test='@param1 = 210909914' >뿌리묶기</xsl:when>
                     <xsl:when test='@param1 = 210911800' >두리번(idle2)</xsl:when>
                     <xsl:when test='@param1 = 210911801' >도발</xsl:when>
                     <xsl:when test='@param1 = 210911802' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 210911810' >할퀴기</xsl:when>
                     <xsl:when test='@param1 = 210911811' >양손펀치</xsl:when>
                     <xsl:when test='@param1 = 210911812' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 210911813' >해골던지기</xsl:when>
                     <xsl:when test='@param1 = 210911814' >뿌리묶기</xsl:when>
                     <xsl:when test='@param1 = 210911900' >물기</xsl:when>
                     <xsl:when test='@param1 = 210911901' >우측 앞발 공격</xsl:when>
                     <xsl:when test='@param1 = 210911902' >좌측 앞발 공격</xsl:when>
                     <xsl:when test='@param1 = 210911903' >내려찍기 (제자리)</xsl:when>
                     <xsl:when test='@param1 = 210911904' >내려찍기 (4m)</xsl:when>
                     <xsl:when test='@param1 = 210911905' >내려찍기 (8m)</xsl:when>
                     <xsl:when test='@param1 = 210911906' >후진 (5m)</xsl:when>
                     <xsl:when test='@param1 = 210911907' >절대방어</xsl:when>
                     <xsl:when test='@param1 = 210910000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210910001' >좌회전</xsl:when>
                     <xsl:when test='@param1 = 210910002' >우회전</xsl:when>
                     <xsl:when test='@param1 = 210910003' >roar</xsl:when>
                     <xsl:when test='@param1 = 210910004' >pain1</xsl:when>
                     <xsl:when test='@param1 = 210910005' >pain2</xsl:when>
                     <xsl:when test='@param1 = 210910006' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210910007' >오른손찍기</xsl:when>
                     <xsl:when test='@param1 = 210910008' >왼손찍기</xsl:when>
                     <xsl:when test='@param1 = 210910009' >꼬리공격</xsl:when>
                     <xsl:when test='@param1 = 210910010' >거품뱉기</xsl:when>
                     <xsl:when test='@param1 = 210910011' >양손찍기</xsl:when>
                     <xsl:when test='@param1 = 210910012' >연속찍기(오른손시작)</xsl:when>
                     <xsl:when test='@param1 = 210910013' >연속찍기(왼손시작)</xsl:when>
                     <xsl:when test='@param1 = 210910014' >roar(모드전환0)</xsl:when>
                     <xsl:when test='@param1 = 210910015' >roar(모드전환1)</xsl:when>
                     <xsl:when test='@param1 = 210910028' >roar(연출1)</xsl:when>
                     <xsl:when test='@param1 = 210930000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210930001' >좌회전</xsl:when>
                     <xsl:when test='@param1 = 210930002' >우회전</xsl:when>
                     <xsl:when test='@param1 = 210930003' >roar</xsl:when>
                     <xsl:when test='@param1 = 210930004' >pain1</xsl:when>
                     <xsl:when test='@param1 = 210930005' >pain2</xsl:when>
                     <xsl:when test='@param1 = 210930006' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210930007' >오른손찍기</xsl:when>
                     <xsl:when test='@param1 = 210930008' >왼손찍기</xsl:when>
                     <xsl:when test='@param1 = 210930009' >꼬리공격</xsl:when>
                     <xsl:when test='@param1 = 210930010' >거품뱉기</xsl:when>
                     <xsl:when test='@param1 = 210930011' >양손찍기</xsl:when>
                     <xsl:when test='@param1 = 210930012' >연속찍기(오른손시작)</xsl:when>
                     <xsl:when test='@param1 = 210930013' >연속찍기(왼손시작)</xsl:when>
                     <xsl:when test='@param1 = 210930014' >roar(모드전환0)</xsl:when>
                     <xsl:when test='@param1 = 210930015' >roar(모드전환1)</xsl:when>
                     <xsl:when test='@param1 = 210910300' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210910301' >앞발공격</xsl:when>
                     <xsl:when test='@param1 = 210910302' >회전공격</xsl:when>
                     <xsl:when test='@param1 = 210910303' >거품공격</xsl:when>
                     <xsl:when test='@param1 = 210920500' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210920501' >우측 공격(약)</xsl:when>
                     <xsl:when test='@param1 = 210920502' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 210920503' >회피기 (좌)</xsl:when>
                     <xsl:when test='@param1 = 210920504' >회피기 (우)</xsl:when>
                     <xsl:when test='@param1 = 210920505' >가드</xsl:when>
                     <xsl:when test='@param1 = 210920506' >악화</xsl:when>
                     <xsl:when test='@param1 = 210920600' >우측 공격</xsl:when>
                     <xsl:when test='@param1 = 210920601' >화염구</xsl:when>
                     <xsl:when test='@param1 = 210920602' >악화</xsl:when>
                     <xsl:when test='@param1 = 210921900' >idle2(개굴)</xsl:when>
                     <xsl:when test='@param1 = 210921910' >체력회복(물약먹기)</xsl:when>
                     <xsl:when test='@param1 = 210921911' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 210921912' >길게찌르기</xsl:when>
                     <xsl:when test='@param1 = 210921913' >창휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210921914' >발차기</xsl:when>
                     <xsl:when test='@param1 = 210930101' >지팡이휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210930102' >전진공격</xsl:when>
                     <xsl:when test='@param1 = 210930103' >후진공격</xsl:when>
                     <xsl:when test='@param1 = 210930104' >화염채찍</xsl:when>
                     <xsl:when test='@param1 = 210930105' >지팡이2연타</xsl:when>
                     <xsl:when test='@param1 = 210930106' >화염구</xsl:when>
                     <xsl:when test='@param1 = 210930107' >프레임게이저</xsl:when>
                     <xsl:when test='@param1 = 210930108' >모드0전환(칼뽑기)</xsl:when>
                     <xsl:when test='@param1 = 210930109' >모드1전환(칼넣기)</xsl:when>
                     <xsl:when test='@param1 = 210932100' >비웃기</xsl:when>
                     <xsl:when test='@param1 = 210932101' >악화</xsl:when>
                     <xsl:when test='@param1 = 210932110' >가드</xsl:when>
                     <xsl:when test='@param1 = 210932111' >베기1</xsl:when>
                     <xsl:when test='@param1 = 210932112' >베기2</xsl:when>
                     <xsl:when test='@param1 = 210932113' >방패치기</xsl:when>
                     <xsl:when test='@param1 = 210932120' >모드전환(버로우)</xsl:when>
                     <xsl:when test='@param1 = 210932121' >모드전환(언버로)</xsl:when>
                     <xsl:when test='@param1 = 210932000' >비웃기</xsl:when>
                     <xsl:when test='@param1 = 210932001' >도토리먹기</xsl:when>
                     <xsl:when test='@param1 = 210932002' >악화</xsl:when>
                     <xsl:when test='@param1 = 210932010' >지팡이공격</xsl:when>
                     <xsl:when test='@param1 = 210932011' >화염구</xsl:when>
                     <xsl:when test='@param1 = 210932012' >치유</xsl:when>
                     <xsl:when test='@param1 = 210932201' >물기</xsl:when>
                     <xsl:when test='@param1 = 210932202' >우측 앞발 공격</xsl:when>
                     <xsl:when test='@param1 = 210932203' >좌측 앞발 공격</xsl:when>
                     <xsl:when test='@param1 = 210932204' >내려찍기 (제자리)</xsl:when>
                     <xsl:when test='@param1 = 210932205' >내려찍기 (4m)</xsl:when>
                     <xsl:when test='@param1 = 210932206' >내려찍기 (8m)</xsl:when>
                     <xsl:when test='@param1 = 210932207' >후진 (5m)</xsl:when>
                     <xsl:when test='@param1 = 210932208' >절대방어</xsl:when>
                     <xsl:when test='@param1 = 10906701' >일하기</xsl:when>
                     <xsl:when test='@param1 = 10906702' >쉬기</xsl:when>
                     <xsl:when test='@param1 = 10906703' >불평하기</xsl:when>
                     <xsl:when test='@param1 = 210912001' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 210912002' >독침공격1</xsl:when>
                     <xsl:when test='@param1 = 210912100' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210912101' >idle3</xsl:when>
                     <xsl:when test='@param1 = 210912102' >idle4</xsl:when>
                     <xsl:when test='@param1 = 210912103' >물기</xsl:when>
                     <xsl:when test='@param1 = 210912104' >점프공격</xsl:when>
                     <xsl:when test='@param1 = 210912105' >후방회피</xsl:when>
                     <xsl:when test='@param1 = 210912106' >포효</xsl:when>
                     <xsl:when test='@param1 = 210912200' >idle2(땅파기)</xsl:when>
                     <xsl:when test='@param1 = 210912201' >idle3(울기)</xsl:when>
                     <xsl:when test='@param1 = 210912202' >짖기</xsl:when>
                     <xsl:when test='@param1 = 210912203' >회전L</xsl:when>
                     <xsl:when test='@param1 = 210912204' >회전R</xsl:when>
                     <xsl:when test='@param1 = 210912211' >물기</xsl:when>
                     <xsl:when test='@param1 = 210912212' >물어뜯기</xsl:when>
                     <xsl:when test='@param1 = 210912213' >대쉬물기</xsl:when>
                     <xsl:when test='@param1 = 210912214' >회피회전L</xsl:when>
                     <xsl:when test='@param1 = 210912215' >회피회전R</xsl:when>
                     <xsl:when test='@param1 = 210912216' >늑대울음</xsl:when>
                     <xsl:when test='@param1 = 210912300' >idle2</xsl:when>
                     <xsl:when test='@param1 = 210912301' >idle3</xsl:when>
                     <xsl:when test='@param1 = 210912302' >idle4</xsl:when>
                     <xsl:when test='@param1 = 210912303' >뿔공격</xsl:when>
                     <xsl:when test='@param1 = 210912304' >돌진</xsl:when>
                     <xsl:when test='@param1 = 210912305' >앞발공격</xsl:when>
                     <xsl:when test='@param1 = 210912306' >뒷발공격</xsl:when>
                     <xsl:when test='@param1 = 210912307' >후방회피</xsl:when>
                     <xsl:when test='@param1 = 210912308' >가드</xsl:when>
                     <xsl:when test='@param1 = 210912309' >돌진2(뿔없음)</xsl:when>
                     <xsl:when test='@param1 = 211700210' >소용돌이_시작(to_mode1)</xsl:when>
                     <xsl:when test='@param1 = 211700220' >소용돌이_끝(to_mode0)</xsl:when>
                     <xsl:when test='@param1 = 211700300' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211700301' >idle3</xsl:when>
                     <xsl:when test='@param1 = 211700310' >포자떨구기</xsl:when>
                     <xsl:when test='@param1 = 211700311' >박치기</xsl:when>
                     <xsl:when test='@param1 = 211700400' >idle</xsl:when>
                     <xsl:when test='@param1 = 211700401' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211700410' >점프이동</xsl:when>
                     <xsl:when test='@param1 = 211700411' >점프공격</xsl:when>
                     <xsl:when test='@param1 = 211700412' >따라다니기</xsl:when>
                     <xsl:when test='@param1 = 211700413' >자폭</xsl:when>
                     <xsl:when test='@param1 = 211700414' >자폭페이크</xsl:when>
                     <xsl:when test='@param1 = 211700500' >신나는댄스</xsl:when>
                     <xsl:when test='@param1 = 211700501' >포자탄발사</xsl:when>
                     <xsl:when test='@param1 = 211700502' >포자탄연속발사</xsl:when>
                     <xsl:when test='@param1 = 250100000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 250100001' >변신 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100002' >도발</xsl:when>
                     <xsl:when test='@param1 = 250100003' >pain1</xsl:when>
                     <xsl:when test='@param1 = 250100004' >pain2</xsl:when>
                     <xsl:when test='@param1 = 250100005' >pain3</xsl:when>
                     <xsl:when test='@param1 = 250100010' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 250100011' >후진공격</xsl:when>
                     <xsl:when test='@param1 = 250100012' >전진찌르기</xsl:when>
                     <xsl:when test='@param1 = 250100014' >빛의고리</xsl:when>
                     <xsl:when test='@param1 = 250100015' >징벌의 성역</xsl:when>
                     <xsl:when test='@param1 = 250100016' >종말의예언</xsl:when>
                     <xsl:when test='@param1 = 250100017' >종말</xsl:when>
                     <xsl:when test='@param1 = 250100018' >죽음의오오라</xsl:when>
                     <xsl:when test='@param1 = 250100020' >이륙 (tomode1)</xsl:when>
                     <xsl:when test='@param1 = 250100021' >하강공격 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100022' >창 던지기</xsl:when>
                     <xsl:when test='@param1 = 250100100' >모드0전환(무기들기)</xsl:when>
                     <xsl:when test='@param1 = 250100101' >모드1전환(무기넣기)</xsl:when>
                     <xsl:when test='@param1 = 250100102' >변신</xsl:when>
                     <xsl:when test='@param1 = 250100110' >1타</xsl:when>
                     <xsl:when test='@param1 = 250100111' >2연타</xsl:when>
                     <xsl:when test='@param1 = 250100112' >찌르기</xsl:when>
                     <xsl:when test='@param1 = 250100113' >후진공격</xsl:when>
                     <xsl:when test='@param1 = 250100120' >빛의고리</xsl:when>
                     <xsl:when test='@param1 = 250100121' >징벌의 성역</xsl:when>
                     <xsl:when test='@param1 = 250100200' >idle</xsl:when>
                     <xsl:when test='@param1 = 250100201' >pain1</xsl:when>
                     <xsl:when test='@param1 = 250100202' >pain2</xsl:when>
                     <xsl:when test='@param1 = 250100203' >회전L</xsl:when>
                     <xsl:when test='@param1 = 250100204' >회전R</xsl:when>
                     <xsl:when test='@param1 = 250100205' >지침</xsl:when>
                     <xsl:when test='@param1 = 250100210' >2연타</xsl:when>
                     <xsl:when test='@param1 = 250100211' >3회전 휘두르기</xsl:when>
                     <xsl:when test='@param1 = 250100212' >후방 공격</xsl:when>
                     <xsl:when test='@param1 = 250100213' >내려치기</xsl:when>
                     <xsl:when test='@param1 = 250100214' >도발 페이크</xsl:when>
                     <xsl:when test='@param1 = 250100216' >휘두르기 시작 (tomode4)</xsl:when>
                     <xsl:when test='@param1 = 250100217' >휘두르기 내려치기 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100218' >휘두르기 휘두르기 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100219' >휘두르기 끝 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100220' >휠윈드 시작 (tomode1)</xsl:when>
                     <xsl:when test='@param1 = 250100221' >휠윈드 쉼</xsl:when>
                     <xsl:when test='@param1 = 250100222' >휠윈드 지침 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100230' >도발 시작 (tomode2)</xsl:when>
                     <xsl:when test='@param1 = 250100231' >도발 카운트어택 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100232' >도발 끝  (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100233' >도발 idle2</xsl:when>
                     <xsl:when test='@param1 = 250100302' >pain2</xsl:when>
                     <xsl:when test='@param1 = 250100303' >pain3</xsl:when>
                     <xsl:when test='@param1 = 250100304' >pain4</xsl:when>
                     <xsl:when test='@param1 = 250100310' >지팡이1타 1</xsl:when>
                     <xsl:when test='@param1 = 250100311' >지팡이1타 2</xsl:when>
                     <xsl:when test='@param1 = 250100312' >마법 발사</xsl:when>
                     <xsl:when test='@param1 = 250100320' >순간이동 시작 (tomode1)</xsl:when>
                     <xsl:when test='@param1 = 250100321' >순간이동 끝 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100313' >보호막1 (tomode2)</xsl:when>
                     <xsl:when test='@param1 = 250100314' >보호막2 (tomode2)</xsl:when>
                     <xsl:when test='@param1 = 250100315' >pain1 (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 250100316' >idle (tomode0)</xsl:when>
                     <xsl:when test='@param1 = 251100000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 251100001' >turn_l</xsl:when>
                     <xsl:when test='@param1 = 251100002' >turn_r</xsl:when>
                     <xsl:when test='@param1 = 251100003' >포효</xsl:when>
                     <xsl:when test='@param1 = 251100004' >pain2</xsl:when>
                     <xsl:when test='@param1 = 251100010' >왼발공격#0</xsl:when>
                     <xsl:when test='@param1 = 251100011' >왼발공격#1</xsl:when>
                     <xsl:when test='@param1 = 251100012' >오른발공격</xsl:when>
                     <xsl:when test='@param1 = 251100013' >들이받기</xsl:when>
                     <xsl:when test='@param1 = 251100014' >대쉬공격</xsl:when>
                     <xsl:when test='@param1 = 251100015' >후방점프</xsl:when>
                     <xsl:when test='@param1 = 251100016' >광역공격</xsl:when>
                     <xsl:when test='@param1 = 251100017' >형전환 #1</xsl:when>
                     <xsl:when test='@param1 = 251100018' >형전환 #0</xsl:when>
                     <xsl:when test='@param1 = 251100020' >저공비행_돌입</xsl:when>
                     <xsl:when test='@param1 = 251100021' >저공비행_양손공격</xsl:when>
                     <xsl:when test='@param1 = 251100022' >저공비행_슬라이딩공격</xsl:when>
                     <xsl:when test='@param1 = 251100023' >저공비행_꼬리물기</xsl:when>
                     <xsl:when test='@param1 = 251100024' >저공비행_볼파이어1</xsl:when>
                     <xsl:when test='@param1 = 251100025' >저공비행_볼파이어2</xsl:when>
                     <xsl:when test='@param1 = 251100026' >저공비행_꼬리낚기</xsl:when>
                     <xsl:when test='@param1 = 251100027' >저공비행_착지</xsl:when>
                     <xsl:when test='@param1 = 251100028' >flying_pain2</xsl:when>
                     <xsl:when test='@param1 = 251100029' >flying_pain_wakeup</xsl:when>
                     <xsl:when test='@param1 = 251100030' >고공비행_돌입</xsl:when>
                     <xsl:when test='@param1 = 251100031' >볼파이어1</xsl:when>
                     <xsl:when test='@param1 = 251100032' >볼파이어2</xsl:when>
                     <xsl:when test='@param1 = 251100033' >그레이트파이어1</xsl:when>
                     <xsl:when test='@param1 = 251100034' >그레이트파이어2</xsl:when>
                     <xsl:when test='@param1 = 251100035' >고공비행_착지</xsl:when>
                     <xsl:when test='@param1 = 211700000' >idle2</xsl:when>
                     <xsl:when test='@param1 = 211700001' >idle3</xsl:when>
                     <xsl:when test='@param1 = 211700002' >좌회전</xsl:when>
                     <xsl:when test='@param1 = 211700003' >우회전</xsl:when>
                     <xsl:when test='@param1 = 211700004' >촉수단타공격</xsl:when>
                     <xsl:when test='@param1 = 211700005' >연속주먹공격</xsl:when>
                     <xsl:when test='@param1 = 211700006' >구르기공격</xsl:when>
                     <xsl:when test='@param1 = 211700007' >내려치기</xsl:when>
                     <xsl:when test='@param1 = 211700008' >구토(마법진)</xsl:when>
                     <xsl:when test='@param1 = 211700009' >뒷발차기</xsl:when>
                     <xsl:when test='@param1 = 211700010' >연속촉수공격</xsl:when>
                     <xsl:when test='@param1 = 211700011' >잡기</xsl:when>
                     <xsl:when test='@param1 = 211700012' >양치</xsl:when>
                     <xsl:when test='@param1 = 211700013' >전진 뛰기</xsl:when>
                     <xsl:when test='@param1 = 211700014' >뒤로 빠지기</xsl:when>
                     <xsl:when test='@param1 = 211700015' >pain1</xsl:when>
                     <xsl:when test='@param1 = 211700016' >pain1-2</xsl:when>
                     <xsl:when test='@param1 = 211700017' >pain2</xsl:when>
                     <xsl:when test='@param1 = 211700018' >pain2-2</xsl:when>
                     <xsl:when test='@param1 = 211700019' >pain3</xsl:when>
                     <xsl:when test='@param1 = 211700020' >pain4</xsl:when>
                     <xsl:when test='@param1 = 211700021' >pain4-2</xsl:when>
                     <xsl:when test='@param1 = 211700022' >좌점프(우회전)</xsl:when>
                     <xsl:when test='@param1 = 211700023' >우점프(좌회전)</xsl:when>
                     <xsl:when test='@param1 = 211700101' >오른손 공격</xsl:when>
                     <xsl:when test='@param1 = 211700102' >왼손 공격</xsl:when>
                     <xsl:when test='@param1 = 211700103' >회오리치기</xsl:when>
                     <xsl:when test='@param1 = 211700104' >대시공격</xsl:when>
                     <xsl:when test='@param1 = 211700105' >점프공격(근)</xsl:when>
                     <xsl:when test='@param1 = 211700106' >점프공격(원)</xsl:when>
                     <xsl:when test='@param1 = 211700107' >점프공격-모드전환</xsl:when>
                     <xsl:when test='@param1 = 211700108' >어퍼컷</xsl:when>
                     <xsl:when test='@param1 = 211700109' >삽질 #1</xsl:when>
                     <xsl:when test='@param1 = 211700110' >삽질 #2</xsl:when>
                     <xsl:when test='@param1 = 211700111' >아파하기 #1</xsl:when>
                     <xsl:when test='@param1 = 211700112' >아파하기 #2</xsl:when>
                     <xsl:when test='@param1 = 211700113' >괴성</xsl:when>
                     <xsl:when test='@param1 = 211700114' >괴성 #2</xsl:when>
                     <xsl:when test='@param1 = 211700115' >브레스</xsl:when>
                     <xsl:when test='@param1 = 211700116' >땅파헤치고 나오기</xsl:when>
                     <xsl:when test='@param1 = 211700117' >왼쪽 돌기</xsl:when>
                     <xsl:when test='@param1 = 211700118' >오른쪽 돌기</xsl:when>
                     <xsl:when test='@param1 = 211700119' >왼손 공격 [삽질]</xsl:when>
                     <xsl:when test='@param1 = 211700120' >대시공격 [변칙 좌]</xsl:when>
                     <xsl:when test='@param1 = 211700121' >대시공격 [변칙 우]</xsl:when>
                     <xsl:when test='@param1 = 210500101' >물기</xsl:when>
                     <xsl:when test='@param1 = 210500102' >우측 앞발 공격</xsl:when>
                     <xsl:when test='@param1 = 210500103' >좌측 앞발 공격</xsl:when>
                     <xsl:when test='@param1 = 210500104' >내려찍기 (제자리)</xsl:when>
                     <xsl:when test='@param1 = 210500105' >내려찍기 (4m)</xsl:when>
                     <xsl:when test='@param1 = 210500106' >내려찍기 (8m)</xsl:when>
                     <xsl:when test='@param1 = 210500107' >후진 (5m)</xsl:when>
                     <xsl:when test='@param1 = 210500108' >절대방어</xsl:when>
                     <xsl:when test='@param1 = 210600101' >왼발 찍기 [염]</xsl:when>
                     <xsl:when test='@param1 = 210600102' >오른발 찍기 [염]</xsl:when>
                     <xsl:when test='@param1 = 210600103' >깔아뭉개기 [염]</xsl:when>
                     <xsl:when test='@param1 = 210600104' >대시공격 [염]</xsl:when>
                     <xsl:when test='@param1 = 210600105' >후방점프 [염]</xsl:when>
                     <xsl:when test='@param1 = 210600106' >전방소점프 [염]</xsl:when>
                     <xsl:when test='@param1 = 210600107' >전방대점프 [염]</xsl:when>
                     <xsl:when test='@param1 = 210600108' >짖기</xsl:when>
                     <xsl:when test='@param1 = 210600109' >짖기 2</xsl:when>
                     <xsl:when test='@param1 = 210600110' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 210600111' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 210600112' >점화</xsl:when>
                     <xsl:when test='@param1 = 210600113' >잡기</xsl:when>
                     <xsl:when test='@param1 = 210600114' >화염구 #1 (왼쪽)</xsl:when>
                     <xsl:when test='@param1 = 210600115' >화염구 #2 (가운데)</xsl:when>
                     <xsl:when test='@param1 = 210600116' >화염구 #3 (오른쪽)</xsl:when>
                     <xsl:when test='@param1 = 210600120' >파트 파괴</xsl:when>
                     <xsl:when test='@param1 = 210600121' >넉다운</xsl:when>
                     <xsl:when test='@param1 = 210600151' >왼발 찍기</xsl:when>
                     <xsl:when test='@param1 = 210600152' >오른발 찍기</xsl:when>
                     <xsl:when test='@param1 = 210600153' >깔아뭉개기</xsl:when>
                     <xsl:when test='@param1 = 210600154' >대시공격</xsl:when>
                     <xsl:when test='@param1 = 210600155' >후방점프</xsl:when>
                     <xsl:when test='@param1 = 210600156' >전방소점프</xsl:when>
                     <xsl:when test='@param1 = 210600157' >전방대점프</xsl:when>
                     <xsl:when test='@param1 = 210600158' >암흑 발산</xsl:when>
                     <xsl:when test='@param1 = 210500201' >착륙</xsl:when>
                     <xsl:when test='@param1 = 210500202' >이륙</xsl:when>
                     <xsl:when test='@param1 = 210500203' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 210500204' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 210500205' >뿔로 치기</xsl:when>
                     <xsl:when test='@param1 = 210500206' >대시</xsl:when>
                     <xsl:when test='@param1 = 210500207' >백대시</xsl:when>
                     <xsl:when test='@param1 = 210500208' >울부짖기 1</xsl:when>
                     <xsl:when test='@param1 = 210500209' >울부짖기 2</xsl:when>
                     <xsl:when test='@param1 = 210500210' >삽질하기</xsl:when>
                     <xsl:when test='@param1 = 210500211' >파리잡기</xsl:when>
                     <xsl:when test='@param1 = 210500212' >공중 대시</xsl:when>
                     <xsl:when test='@param1 = 210500213' >머리 아파하기</xsl:when>
                     <xsl:when test='@param1 = 210500214' >뿔 잘리기</xsl:when>
                     <xsl:when test='@param1 = 210500215' >아파서 기절하기</xsl:when>
                     <xsl:when test='@param1 = 210500216' >오른손 휘두르기</xsl:when>
                     <xsl:when test='@param1 = 210500217' >근접 콤보</xsl:when>
                     <xsl:when test='@param1 = 210500218' >분노</xsl:when>
                     <xsl:when test='@param1 = 210500219' >공중에서 날라와 잡기</xsl:when>
                     <xsl:when test='@param1 = 210500220' >모래 브레쓰</xsl:when>
                     <xsl:when test='@param1 = 210500221' >모래 뿌리기</xsl:when>
                     <xsl:when test='@param1 = 210500222' >샌드스톰</xsl:when>
                     <xsl:when test='@param1 = 210500223' >뿔 잘리기(New)</xsl:when>
                     <xsl:when test='@param1 = 210500224' >등장</xsl:when>
                     <xsl:when test='@param1 = 211200101' >착륙</xsl:when>
                     <xsl:when test='@param1 = 211200102' >이륙</xsl:when>
                     <xsl:when test='@param1 = 211200103' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 211200104' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 211200105' >울부 짖기</xsl:when>
                     <xsl:when test='@param1 = 211200106' >먹기</xsl:when>
                     <xsl:when test='@param1 = 211200107' >턱으로 어퍼컷</xsl:when>
                     <xsl:when test='@param1 = 211200108' >턱으로 밀기</xsl:when>
                     <xsl:when test='@param1 = 211200109' >꼬리치기</xsl:when>
                     <xsl:when test='@param1 = 211200110' >지상브레쓰 - Right Round</xsl:when>
                     <xsl:when test='@param1 = 211200111' >두리번거리기</xsl:when>
                     <xsl:when test='@param1 = 211200112' >아파하기 #1</xsl:when>
                     <xsl:when test='@param1 = 211200113' >아파하기 #2</xsl:when>
                     <xsl:when test='@param1 = 211200114' >냄새맡기</xsl:when>
                     <xsl:when test='@param1 = 211200115' >재채기</xsl:when>
                     <xsl:when test='@param1 = 211200116' >공중브레쓰 #1</xsl:when>
                     <xsl:when test='@param1 = 211200117' >공중브레쓰 #2 - 좌회전</xsl:when>
                     <xsl:when test='@param1 = 211200118' >공중브레쓰 #3 - 우회전</xsl:when>
                     <xsl:when test='@param1 = 211200119' >전진 공중브레쓰</xsl:when>
                     <xsl:when test='@param1 = 211200120' >공중회전</xsl:when>
                     <xsl:when test='@param1 = 211200121' >이륙브레쓰</xsl:when>
                     <xsl:when test='@param1 = 211200122' >지상브레쓰 #2 - 직선</xsl:when>
                     <xsl:when test='@param1 = 211200150' >콤보 1형</xsl:when>
                     <xsl:when test='@param1 = 211200151' >콤보 2형</xsl:when>
                     <xsl:when test='@param1 = 211200152' >콤보 3형</xsl:when>
                     <xsl:when test='@param1 = 211200153' >콤보 4형</xsl:when>
                     <xsl:when test='@param1 = 211200154' >콤보 5형</xsl:when>
                     <xsl:when test='@param1 = 211200155' >대시</xsl:when>
                     <xsl:when test='@param1 = 210100501' >물기</xsl:when>
                     <xsl:when test='@param1 = 210100502' >점프어택</xsl:when>
                     <xsl:when test='@param1 = 200000101' >idle</xsl:when>
                     <xsl:when test='@param1 = 200000201' >idle</xsl:when>
                     <xsl:when test='@param1 = 200000301' >idle1</xsl:when>
                     <xsl:when test='@param1 = 200000302' >idle2</xsl:when>
                     <xsl:when test='@param1 = 200000501' >idle</xsl:when>
                     <xsl:when test='@param1 = 200000701' >idle</xsl:when>
                     <xsl:when test='@param1 = 200000901' >idle</xsl:when>
                     <xsl:when test='@param1 = 290000101' >idle</xsl:when>
                     <xsl:when test='@param1 = 290000201' >idle</xsl:when>
                     <xsl:when test='@param1 = 290000301' >idle1</xsl:when>
                     <xsl:when test='@param1 = 290000302' >idle2</xsl:when>
                     <xsl:when test='@param1 = 290000501' >idle</xsl:when>
                     <xsl:when test='@param1 = 290000701' >idle</xsl:when>
                     <xsl:when test='@param1 = 290000901' >idle</xsl:when>
                     <xsl:when test='@param1 = 150050' >화염통 던지기</xsl:when>
                     <xsl:when test='@param1 = 150060' >성수 던지기</xsl:when>
                     <xsl:when test='@param1 = 300150090' >기생충 감염자 모드 변환</xsl:when>
                     <xsl:when test='@param1 = 300150100' >우솝의춤</xsl:when>
                     <xsl:when test='@param1 = 189400101' >일반공격</xsl:when>
                     <xsl:when test='@param1 = 189400102' >강한공격</xsl:when>
                     <xsl:when test='@param1 = 189400103' >울부짖기</xsl:when>
                     <xsl:when test='@param1 = 189400104' >idle1</xsl:when>
                     <xsl:when test='@param1 = 189400105' >idle2</xsl:when>
                     <xsl:when test='@param1 = 189400106' >도발</xsl:when>
                     <xsl:when test='@param1 = 189400107' >해골던지기</xsl:when>
                     <xsl:when test='@param1 = 189400108' >발구르기</xsl:when>
                     <xsl:when test='@param1 = 189402101' >수타</xsl:when>
                     <xsl:when test='@param1 = 189402102' >몽둥이내려치기</xsl:when>
                     <xsl:when test='@param1 = 189402103' >뭉동이후리기</xsl:when>
                     <xsl:when test='@param1 = 189402104' >밀어내기</xsl:when>
                     <xsl:when test='@param1 = 189402105' >강베기</xsl:when>
                     <xsl:when test='@param1 = 189402106' >대시</xsl:when>
                     <xsl:when test='@param1 = 189402107' >풍차돌리기</xsl:when>
                     <xsl:when test='@param1 = 189402108' >돌던지기</xsl:when>
                     <xsl:when test='@param1 = 189402109' >울부짖기#1</xsl:when>
                     <xsl:when test='@param1 = 189402110' >울부짖기#2</xsl:when>
                     <xsl:when test='@param1 = 189402111' >엉덩방아</xsl:when>
                     <xsl:when test='@param1 = 189402112' >도발1-엉덩이치기</xsl:when>
                     <xsl:when test='@param1 = 189402113' >도발2-머리긁적</xsl:when>
                     <xsl:when test='@param1 = 189402114' >도발3-냄새맡기</xsl:when>
                     <xsl:when test='@param1 = 189402115' >OTL</xsl:when>
                     <xsl:when test='@param1 = 189402116' >뒤로벌렁</xsl:when>
                     <xsl:when test='@param1 = 189402117' >아파하기</xsl:when>
                     <xsl:when test='@param1 = 189402146' >잡아 던지기</xsl:when>
                     <xsl:when test='@param1 = 189402148' >좌측 회전</xsl:when>
                     <xsl:when test='@param1 = 189402149' >우측 회전</xsl:when>
                     <xsl:when test='@param1 = 189402150' >콤보 어택</xsl:when>
                     <xsl:when test='@param1 = 189402201' >첫 등장후 울부짖기</xsl:when>
                     <xsl:when test='@param1 = 889402001' >충격파</xsl:when>
                     <xsl:when test='@param1 = 189402701' >일반공격1</xsl:when>
                     <xsl:when test='@param1 = 189402801' >1타</xsl:when>
                 <xsl:otherwise>
                     <xsl:value-of select='@param1'/>
                 </xsl:otherwise>
             </xsl:choose>
             </td>
             <td><xsl:value-of select='@param2' /></td>
             <td><xsl:value-of select='@rate' /></td>
             <td><xsl:value-of select='@cycle' /></td>
             <td><xsl:value-of select='@duration' /></td>
             <td><xsl:value-of select='@auto_run' /></td>
         </tr>
     </xsl:template>
</xsl:stylesheet>
