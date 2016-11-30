@echo off
If EXIST talent_ext.woman.xml GOTO ERROR
If EXIST talent_ext.man.xml GOTO WOMANMODE

:ERROR
@echo on
@echo ***** Already man mode!!
goto END

:WOMANMODE
@echo on
copy talent_ext.xml talent_ext.woman.xml /Y
copy talent_hit_info.xml talent_hit_info.woman.xml /Y
copy talent_pos_info.xml talent_pos_info.woman.xml /Y

copy talent_ext.man.xml talent_ext.xml /Y
copy talent_hit_info.man.xml talent_hit_info.xml /Y
copy talent_pos_info.man.xml talent_pos_info.xml /Y

copy ..\..\..\Data\system\talent_ext.xml ..\..\..\Data\system\talent_ext.woman.xml /Y
copy ..\..\..\Data\system\talent_hit_info.xml ..\..\..\Data\system\talent_hit_info.woman.xml /Y
copy ..\..\..\Data\system\talent_pos_info.xml ..\..\..\Data\system\talent_pos_info.woman.xml /Y

copy ..\..\..\Data\system\talent_ext.man.xml ..\..\..\Data\system\talent_ext.xml /Y
copy ..\..\..\Data\system\talent_hit_info.man.xml ..\..\..\Data\system\talent_hit_info.xml /Y
copy ..\..\..\Data\system\talent_pos_info.man.xml ..\..\..\Data\system\talent_pos_info.xml /Y

del talent_ext.man.xml /Q

:END
pause
BREAK
