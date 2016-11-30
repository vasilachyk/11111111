@echo off
If EXIST talent_ext.man.xml GOTO ERROR
If EXIST talent_ext.woman.xml GOTO WOMANMODE

:ERROR
@echo on
@echo ***** Already woman mode!!
goto END

:WOMANMODE
@echo on
copy talent_ext.xml talent_ext.man.xml /Y
copy talent_hit_info.xml talent_hit_info.man.xml /Y
copy talent_pos_info.xml talent_pos_info.man.xml /Y

copy talent_ext.woman.xml talent_ext.xml /Y
copy talent_hit_info.woman.xml talent_hit_info.xml /Y
copy talent_pos_info.woman.xml talent_pos_info.xml /Y

copy ..\..\..\Data\system\talent_ext.xml ..\..\..\Data\system\talent_ext.man.xml /Y
copy ..\..\..\Data\system\talent_hit_info.xml ..\..\..\Data\system\talent_hit_info.man.xml /Y
copy ..\..\..\Data\system\talent_pos_info.xml ..\..\..\Data\system\talent_pos_info.man.xml /Y

copy ..\..\..\Data\system\talent_ext.woman.xml ..\..\..\Data\system\talent_ext.xml /Y
copy ..\..\..\Data\system\talent_hit_info.woman.xml ..\..\..\Data\system\talent_hit_info.xml /Y
copy ..\..\..\Data\system\talent_pos_info.woman.xml ..\..\..\Data\system\talent_pos_info.xml /Y

del talent_ext.woman.xml /Q

:END
pause
BREAK
