@echo off
set xv_path=D:\\vivado\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 8d2fbf37f46f4fc78c420ca78b599c1f -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot testbench_behav xil_defaultlib.testbench xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
