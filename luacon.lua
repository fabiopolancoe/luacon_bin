-- Luacon 1.0 @ Coalio
-- Licensed under GNU Public License
-- License is available at this folder
-- If license is not available within this folder, please request a copy

local string = string
local xpcall = xpcall
local package = package
local tostring = tostring
local os = os
local require = require
local bit32 = bit32
local pairs = pairs
local next = next
local assert = assert
local rawlen = rawlen
local ipairs = ipairs
local io = io
local rawequal = rawequal
local collectgarbage = collectgarbage
local arg = arg
local load = load
local module = module
local rawset = rawset
local math = math
local pcall = pcall
local type = type
local debug = debug
local getmetatable = getmetatable
local select = select
local table = table
local rawget = rawget
local loadstring = loadstring
local print = print 
local coroutine = coroutine
local dofile = dofile
local tonumber = tonumber 
local setmetatable = setmetatable 
local error = error 
local loadfile = loadfile 
local _G = _G
unpack = unpack or table.unpack

local function cpath(a, mode) return ((mode==1 and string.gsub(a, [[/]], [[\]])) or string.gsub(a, [[\]], [[/]])) end
local memory_base = 37.3798828125
local script_path = script_path or ''
local isCompiled = cpath(arg[0], 0):match("/(%a+).exe") or false
luacon_path = cpath(arg[0], 0):match("@?(.*/)") or '.'
luacon_name = cpath(arg[0], 0):match("/(%a+).exe") or cpath(arg[0], 0):match("/(%a+).lua") or 'luacon'

local utils = io.open(luacon_path .. 'luacon_utils', 'r') or io.open(luacon_path .. '/luacon_utils', 'r')
local config = io.open(luacon_path .. 'luacon_config', 'r') or io.open(luacon_path .. '/luacon_utils', 'r')
local exit, validate, execute = unpack(load(utils:read('*a'))())
load(config:read('*a'))()

if luacon_name ~= 'luacon' and isCompiled~=false and CHANGED_NAME_WARNING==true then
  print('[LUACON] modifying the name of the binary is not recommended')
end

entries = {}
timestamp_en = os.clock()

local VERSION = VERSION or '1.0'
local ENVIRONMENT = ENVIRONMENT or nil

--[[ Init
  -- Load arguments
  -- Set the environment
]]

local indx = {}
for i=1,#arg do indx[#indx+1]=i end
print(_VERSION, '@')
print('Luacon '..VERSION, '@coal')
print('\n')
if (not indx and not arg) or #arg == 0 then
  print('[CON] no script specified')
  print('[CON] usage: ' .. luacon_name .. ' arg1 [ --set key value ] %script_path')
else
  for k,v in pairs(arg) do
    if v=='--set' then
      if arg[k+1] == nil or arg[k+2] == nil then
        print("[CON] incorrect --set")
        print("[CON] usage: --set %var %value")
        break
      end
      _G[arg[k+1]] = arg[k+2]
    end
  end
end
indx = nil

script_path = arg[#arg]
if #arg~=0 and script_path~=nil then
  local exec = io.open(cpath(script_path, 0), 'r')
  if exec == nil then
    print("[CON] Unable to open "..script_path)
  else timestamp_en = os.clock() execute(exec:read('*a')) end
end

local entry -- input by user

--[[ Main loop
  -- Collect garbage
  -- Wait for input
  -- Classify parameters and execute
  -- Output results
]]
local fe=true
collectgarbage()
local memory_base = collectgarbage('count')
while 1 do 
  if fe then
    print('[GC] ' .. memory_base)
    fe=nil
  else
    print('[GC] ' .. collectgarbage('count') - memory_base)
    
  end
  if EXIT_AFTER_EXECUTION == 'true' then exit(os.clock()) end
  collectgarbage()
  repeat
    io.write(">> ")
    io.flush()
    xpcall(function() entry = io.read() end, function(e) xpcall(function() entry = io.read() end, function(e) print('[ARG] ' .. e) end) end) -- avoid the infamous "interrupted!" error
  until entry
  local checkIfArg = validate(entry)
  if checkIfArg == false then execute(entry) end
end
