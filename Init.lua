--[[ 
◀ DO NOT'T USE IT ▶
If you use this and don't credit me, i can DMCA you.

◀ This Gui Make For Space M ▶
]]
-- ◀ Script ▶

print("Space M init Loaded !")

http_service = game:GetService("HttpService")
run_service = game:GetService("RunService")
-- start
_G.getgenv = function()
    return getfenv(0)
end
getgenv = _G.getgenv
--[[ 
Credits: 
rconsole, file system, crypt lib (except crypt.hash), mouse lib, renv, queue on teleport and closures: moreunc
almost the entire drawing lib: solara
]]


objs = {}
nilinst = {}
httpserv = game:GetService("HttpService")

getgenv().getnilinstances = function()
    return nilinst
end
getnilinstances = getgenv().getnilinstances

getgenv().getgc = function()
    return table.clone(nilinst)
end
getgc = getgenv().getgc

game.DescendantRemoving:Connect(function(des)
    table.insert(nilinst, des)
    delay(60, function() 
        local index = table.find(nilinst, des)
        if index then
            table.remove(nilinst, index)
        end
    end)
end)

getgenv().identifyexecutor = function()
    return "SkibidiSaladEnv", "SkidPoopSploit"
end
identifyexecutor = getgenv().identifyexecutor

getgenv().getexecutorname = function()
    return "Space M"
end
getexecutorname = getgenv().getexecutorname

getgenv().gethui = function()
    return game:GetService("CoreGui") -- REAL
end
gethui = getgenv().gethui
getgenv().cache = {}
cache = getgenv().cache
cached = {}
getgenv().cache.iscached = function(part) return cached[part] ~= 'nil' end
getgenv().cache.invalidate = function(part) cached[part] = 'nil'; part.Parent = nil end
getgenv().cache.replace = function(part, replacement)
    cached[part] = replacement
    replacement.Name, replacement.Parent, part.Parent = part.Name, part.Parent, nil
end

logserv = game:GetService("LogService")
log = logserv.MessageOut:Connect(function(msg)
    if msg:find("Current identity is") then identity = tonumber(msg:gsub('Current identity is', ''):match("%d+")) end 
end)

function disableprotections(table) 
    local prx = {}
    local mt = {
        __index = table,
        __newindex = function(t, key, value)
            rawset(t, key, value)  
        end
    }

    setmetatable(prx, mt)

    return prx
end

getgenv().getscriptbytecode = function(instance) -- REALRELAREAL!!!!
    assert(typeof(instance) == "Instance" and instance:IsA("LuaSourceContainer"), "arg 1 isn't a LuaSourceContainer")
    local success, bytecode = pcall(function() return instance.Source end)
    if not success then return error(string.format("getscriptbytecode failed getting the bytecode of: "..instance:GetFullName()), 2) end
    return bytecode 
end
getscriptbytecode = getgenv().getscriptbytecode

getgenv().debug = disableprotections(debug)
debug = getgenv().debug
getgenv().debug.getinfo = function(f, options)
    if type(options) == "string" then
        options = string.lower(options) 
    else
        options = "sflnu"
    end
    local result = {}
    for index = 1, #options do
        local option = string.sub(options, index, index)
        if "s" == option then
            local short_src = debug.info(f, "s")
            result.short_src = short_src
            result.source = "=" .. short_src
            result.what = if short_src == "[C]" then "C" else "Lua"
        elseif "f" == option then
            result.func = debug.info(f, "f")
        elseif "l" == option then
            result.currentline = debug.info(f, "l")
        elseif "n" == option then
            result.name = debug.info(f, "n")
        elseif "u" == option or option == "a" then
            local numparams, is_vararg = debug.info(f, "a")
            result.numparams = numparams
            result.is_vararg = if is_vararg then 1 else 0
            if "u" == option then
                result.nups = -1
            end
        end
    end
    return result
end

-- printidentity()

getgenv().getthreadidentity = function()
	identity = 8
    return identity 
end
getthreadidentity = getgenv().getthreadidentity

getgenv().printidentity = function() -- holy spoofing!!!
    print("Current identity is "..getthreadidentity()) 
end
printidentity = getgenv().printidentity

getgenv().newlclosure = function(fnc)
    return function(...) return fnc(...) end
end
newlclosure = getgenv().newlclosure

getgenv().base64 = {}
base64 = getgenv().base64
getgenv().base64.encode = function(data)
    local letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return letters:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
getgenv().base64.decode = function(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do
            r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
        end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c = 0
        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0)
        end
        return string.char(c)
    end))
end
getgenv().crypt = {
    base64 = base64,
    base64encode = base64.encode,
    base64_encode = base64.encode,
    base64decode = base64.decode,
    base64_decode = base64.decode,

    hex = {
        encode = function(txt)
            txt = tostring(txt)
            local hex = ''
            for i = 1, #txt do
                hex = hex .. string.format("%02x", string.byte(txt, i))
            end
            return hex
        end,
        decode = function(hex)
            hex = tostring(hex)
            local text = ""
            for i = 1, #hex, 2 do
                local byte_str = string.sub(hex, i, i+1)
                local byte = tonumber(byte_str, 16)
                text = text .. string.char(byte)
            end
            return text
        end
    },

    url = {
        encode = function(x)
            return HttpService:UrlEncode(x)
        end,
        decode = function(x)
            x = tostring(x)
            x = string.gsub(x, "+", " ")
            x = string.gsub(x, "%%(%x%x)", function(hex)
                return string.char(tonumber(hex, 16))
            end)
            x = string.gsub(x, "\r\n", "\n")
            return x
        end
    },

    generatekey = function(len)
        local key = ''
        local x = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        for i = 1, len or 32 do local n = math.random(1, #x) key = key .. x:sub(n, n) end
        return base64.encode(key)
    end,

    encrypt = function(a, b)
        local result = {}
        a = tostring(a) b = tostring(b)
        for i = 1, #a do
            local byte = string.byte(a, i)
            local keyByte = string.byte(b, (i - 1) % #b + 1)
            table.insert(result, string.char(bit32.bxor(byte, keyByte)))
        end
        return table.concat(result), b
    end
}
crypt = getgenv().crypt
getgenv().crypt.generatebytes = function(len)
    return getgenv().crypt.generatekey(len)
end
getgenv().crypt.random = function(len)
    return getgenv().crypt.generatekey(len)
end
getgenv().crypt.decrypt = getgenv().crypt.encrypt


getgenv().getidentity = getthreadidentity
getgenv().getthreadcontext = getthreadidentity
getgenv().setthreadidentity = function(newidentity) identity = newidentity end
getgenv().setidentity = setthreadidentity
getgenv().setthreadcontext = setthreadidentity
getgenv().isscriptable = function(instance, propertyName)
getidentity = getgenv().getidentity
getthreadcontext = getgenv().getthreadcontext
setthreadidentity = getgenv().setthreadidentity
setidentity = getgenv().setidentity
setthreadcontext = getgenv().setthreadcontext
isscriptable = getgenv().isscriptable



    if instance and instance.ClassName and instance:IsA("Instance") then
        local scriptableProperties = {
            Anchored = true,
            Archivable = true,
            BackgroundColor3 = true,
            BackgroundTransparency = true,
            BorderSizePixel = true,
            BrickColor = true,
            CFrame = true,
            CanCollide = true,
            CastShadow = true,
            Color = true,
            Color3 = true,
            DataCost = true,
            DepthOfField = true,
            EasingDirection = true,
            EasingStyle = true,
            Face = true,
            FieldOfView = true,
            FillDirection = true,
            FillParent = true,
            Image = true,
            ImageColor3 = true,
            ImageRectOffset = true,
            ImageRectSize = true,
            ImageTransparency = true,
            LayoutOrder = true,
            LightEmission = true,
            LightInfluence = true,
            LoadStringEnabled = true,
            Locked = true,
            MeshId = true,
            Offset = true,
            OutlineColor3 = true,
            OutlineSize = true,
            Part0 = true,
            Part1 = true,
            PhysicalProperties = true,
            Plane = true,
            PlayOnRemove = true,
            Position = true,
            PrimaryColor = true,
            ReflectionSize = true,
            Rotation = true,
            RotVelocity = true,
            Scale = true,
            Size = true,
            SizeConstraint = true,
            SliceCenter = true,
            Smooth = true,
            Source = true,
            Text = true,
            TextColor3 = true,
            TextScaled = true,
            TextSize = true,
            TextStrokeColor3 = true,
            TextStrokeTransparency = true,
            TextTransparency = true,
            TextWrapped = true,
            Thickness = true,
            TileSize = true,
            Tiling = true,
            TintColor3 = true,
            Transparency = true,
            Value = true,
            Velocity = true,
            Visible = true,
            Width = true,
            WorldAxis = true,
            ZIndex = true,
            ZIndexBehavior = true,
        }
        if scriptableProperties[propertyName] then
            return true
        else
            return false
        end
    end
    return false
end


gtsc = function(module)
	local env = getrenv()
	local constants = env.require(module)
	return function()
		local copy = {}
		for k, v in pairs(constants) do
			copy[k] = v
		end
		return copy
	end
end

getgenv().replaceclosure = function(module, newfunc)  
	local script = getrenv().require(module)
	local originalfunc = getscriptclosure(module)
	for k, v in pairs(script) do
		if v == originalfunc then
			script[k] = newfunc
			break
		end
	end
end
local replaceclosure = getgenv().replaceclosure

getgenv().getscriptclosure = function(scr)
	assert(typeof(scr) == 'Instance' and (scr.ClassName == 'LocalScript' or scr.ClassName == 'ModuleScript'), 'script expected as argument #1')
	for i,v in next, getgc() do
		if type(v) == 'function' then
			local env = getfenv(v)
			if type(env) == 'table' and rawget(env, 'script') == scr then
				return v
			end
		end
	end
end
local getscriptclosure = getgenv().getscriptclosure

getgenv().getscriptfunction = getgenv().getscriptclosure
local getscriptfunction = getgenv().getscriptfunction

getgenv().isrbxactive = function()
	return game:IsLoaded()
end
local isrbxactive = getgenv().isrbxactive

getgenv().isgameactive = function()
	return game and game:IsActive()
end
local isgameactive = getgenv().isgameactive

getgenv().getinstances = function()
	return game:GetDescendants()
end
local getinstances = getgenv().getinstances

local fpscap = math.huge
getgenv().setfpscap = function(cap)
	fpscap = tonumber(cap) and (cap > 0 and cap or math.huge) or math.huge
end
local setfpscap = getgenv().setfpscap
game:GetService("RunService").RenderStepped:Connect(function()
	local targetTime = tick() + 1 / fpscap
	while tick() < targetTime do end
end)

getgenv().getrunningscripts = function()
	local scripts = {}
	for _, script in ipairs(game:GetService("Players").LocalPlayer.PlayerScripts:GetChildren()) do
		if script:IsA("LocalScript") or script:IsA("ModuleScript") then
			table.insert(scripts, script)
		end
	end
	return scripts
end
local getrunningscripts = getgenv().getrunningscripts


getgenv().queue_on_teleport = function(scripttoexec) 
	local newTPService = {
		__index = function(self, key)
			if key == 'Teleport' then
				return function(gameId, player, teleportData, loadScreen)
					teleportData = {teleportData, MOREUNCSCRIPTQUEUE=scripttoexec}
					return oldGame:GetService("TeleportService"):Teleport(gameId, player, teleportData, loadScreen)
				end
			end
		end
	}
	local gameMeta = {
		__index = function(self, key)
			if key == 'GetService' then
				return function(name)
					if name == 'TeleportService' then return newTPService end
				end
			elseif key == 'TeleportService' then return newTPService end
			return game[key]
		end,
		__metatable = 'The metatable is protected'
	}
	getgenv().game = setmetatable({}, gameMeta)
end
getgenv().queueonteleport = getgenv().queue_on_teleport
local queueonteleport = getgenv().queueonteleport
local que_on_teleport = getgenv().que_on_teleport

getgenv().getscripts = function()
	local scripts = {}
	for _, script in pairs(game:GetDescendants()) do
		if script:IsA("ModuleScript") or script:IsA("LocalScript") then
			table.insert(scripts, script)
		end
	end
	return scripts
end
local getscripts = getgenv().getscripts

getgenv().fireclickdetector = function(part) --shitty ahh code
	assert(typeof(part) == "Instance", "invalid argument #1 to 'fireclickdetector' (Instance expected, got " .. type(part) .. ") ", 2)
	local clickDetector = part:FindFirstChild("ClickDetector") or part
	local previousParent = clickDetector.Parent
	local newPart = Instance.new("Part", workspace)
	do
		newPart.Transparency = 1
		newPart.Size = Vector3.new(30, 30, 30)
		newPart.Anchored = true
		newPart.CanCollide = false
		delay(15, function()
			if newPart:IsDescendantOf(game) then
				newPart:Destroy()
			end
		end)
		clickDetector.Parent = newPart
		clickDetector.MaxActivationDistance = math.huge
	end
	local vUser = game:FindService("VirtualUser") or game:GetService("VirtualUser")

	local connection = game:GetService("RunService").Heartbeat:Connect(function()
		local camera = workspace.CurrentCamera or workspace.Camera
		newPart.CFrame = camera.CFrame * CFrame.new(0, 0, -20) * CFrame.new(camera.CFrame.LookVector.X, camera.CFrame.LookVector.Y, camera.CFrame.LookVector.Z)
		vUser:ClickButton1(Vector2.new(20, 20), camera.CFrame)
	end)

	clickDetector.MouseClick:Once(function()
		connection:Disconnect()
		clickDetector.Parent = previousParent
		newPart:Destroy()
	end)
end
local fireclickdetector = getgenv().fireclickdetector


getgenv().getcallingscript = function()
	local Source = debug.info(1, 's')
	for i, v in next, game:GetDescendants() do if v:GetFullName() == Source then return v end end
end
local getcallingscript = getgenv().getcallingscript
local cclosures = {}
getgenv().newcclosure = function(a)
    assert(typeof(a) == "function", "argument #1 is not a 'function'", 0)
    local cclosure = function(...)
        local co = coroutine.create(a)
        local ok, result = coroutine.resume(co, ...)
        if not ok then
            error(result, 2)
        end
        return result
    end
    table.insert(cclosures, cclosure)
    return cclosure
end
local newcclosure = getgenv().newcclosure
getgenv().iscclosure = function(a)
    assert(typeof(a) == "function", "argument #1 is not a 'function'", 0)
	if a == newcclosure then return true end 
    for b, c in next, cclosures do
        if c == a then
            return true
        end
    end
    return debug.info(a, "s") == "[C]"
end
local iscclosure = getgenv().iscclosure
getgenv().isexecutorclosure = function(a)
    assert(typeof(a) == "function", "argument #1 is not a 'function'", 0)
    local result = false
    for b, c in next, getfenv() do
        if c == a then
            result = true
        end
    end 
    if not result then
        for b, c in next, cclosures do
            if c == a then
                result = true
            end
        end
    end
    return result or islclosure(a)
end
local isexecutorclosure = getgenv().isexecutorclosure
getgenv().get_calling_script = getcallingscript 
getgenv().isexecclosure = isexecutorclosure
getgenv().is_executor_closure = isexecclosure
getgenv().islclosure = function(func) return not getgenv().iscclosure(func) end
local get_calling_script = getgenv().get_calling_script
local isexecclosure = getgenv().isexecclosure
local is_executor_closure = getgenv().is_executor_closure
local islclosure = getgenv().islclosure

getgenv().getmodules = function()
	local modules = {}
	for i, obj in pairs(game:GetDescendants()) do 
		if obj:IsA("ModuleScript") then 
			table.insert(modules, obj) 
		end
	 end 
	return modules
end
local getmodules = getgenv().getmodules

getgenv().getloadedmodules = getgenv().getmodules
getgenv().isourclosure = getgenv().isexecutorclosure
getgenv().isexecclosure = getgenv().isexecutorclosure
getgenv().checkclosure = getgenv().isourclosure
local getloadedmodules = getgenv().getloadedmodules
local isourclosure = getgenv().isourclosure
local checkclosure = getgenv().checkclosure


local ipairs = ipairs
local bit32_band = bit32.band -- 2 arguments
local bit32_bor = bit32.bor -- 2 arguments
local bit32_bxor = bit32.bxor -- 2..5 arguments
local bit32_lshift = bit32.lshift -- second argument is integer 0..31
local bit32_rshift = bit32.rshift -- second argument is integer 0..31
local bit32_lrotate = bit32.lrotate -- second argument is integer 0..31
local bit32_rrotate = bit32.rrotate -- second argument is integer 0..31

--------------------------------------------------------------------------------
-- CREATING OPTIMIZED INNER LOOP
--------------------------------------------------------------------------------
-- Arrays of SHA2 "magic numbers" (in "INT64" and "FFI" branches "*_lo" arrays contain 64-bit values)
local sha2_K_lo, sha2_K_hi, sha2_H_lo, sha2_H_hi, sha3_RC_lo, sha3_RC_hi = {}, {}, {}, {}, {}, {}
local sha2_H_ext256 = {
	[224] = {};
	[256] = sha2_H_hi;
}

local sha2_H_ext512_lo, sha2_H_ext512_hi = {
	[384] = {};
	[512] = sha2_H_lo;
}, {
	[384] = {};
	[512] = sha2_H_hi;
}

local md5_K, md5_sha1_H = {}, {0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0}
local md5_next_shift = {0, 0, 0, 0, 0, 0, 0, 0, 28, 25, 26, 27, 0, 0, 10, 9, 11, 12, 0, 15, 16, 17, 18, 0, 20, 22, 23, 21}
local HEX64, XOR64A5, lanes_index_base -- defined only for branches that internally use 64-bit integers: "INT64" and "FFI"
local common_W = {} -- temporary table shared between all calculations (to avoid creating new temporary table every time)
local K_lo_modulo, hi_factor, hi_factor_keccak = 4294967296, 0, 0

local TWO_POW_NEG_56 = 2 ^ -56
local TWO_POW_NEG_17 = 2 ^ -17

local TWO_POW_2 = 2 ^ 2
local TWO_POW_3 = 2 ^ 3
local TWO_POW_4 = 2 ^ 4
local TWO_POW_5 = 2 ^ 5
local TWO_POW_6 = 2 ^ 6
local TWO_POW_7 = 2 ^ 7
local TWO_POW_8 = 2 ^ 8
local TWO_POW_9 = 2 ^ 9
local TWO_POW_10 = 2 ^ 10
local TWO_POW_11 = 2 ^ 11
local TWO_POW_12 = 2 ^ 12
local TWO_POW_13 = 2 ^ 13
local TWO_POW_14 = 2 ^ 14
local TWO_POW_15 = 2 ^ 15
local TWO_POW_16 = 2 ^ 16
local TWO_POW_17 = 2 ^ 17
local TWO_POW_18 = 2 ^ 18
local TWO_POW_19 = 2 ^ 19
local TWO_POW_20 = 2 ^ 20
local TWO_POW_21 = 2 ^ 21
local TWO_POW_22 = 2 ^ 22
local TWO_POW_23 = 2 ^ 23
local TWO_POW_24 = 2 ^ 24
local TWO_POW_25 = 2 ^ 25
local TWO_POW_26 = 2 ^ 26
local TWO_POW_27 = 2 ^ 27
local TWO_POW_28 = 2 ^ 28
local TWO_POW_29 = 2 ^ 29
local TWO_POW_30 = 2 ^ 30
local TWO_POW_31 = 2 ^ 31
local TWO_POW_32 = 2 ^ 32
local TWO_POW_40 = 2 ^ 40

local TWO56_POW_7 = 256 ^ 7

-- Implementation for Lua 5.1/5.2 (with or without bitwise library available)
local function sha256_feed_64(H, str, offs, size)
	-- offs >= 0, size >= 0, size is multiple of 64
	local W, K = common_W, sha2_K_hi
	local h1, h2, h3, h4, h5, h6, h7, h8 = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
	for pos = offs, offs + size - 1, 64 do
		for j = 1, 16 do
			pos = pos + 4
			local a, b, c, d = string.byte(str, pos - 3, pos)
			W[j] = ((a * 256 + b) * 256 + c) * 256 + d
		end

		for j = 17, 64 do
			local a, b = W[j - 15], W[j - 2]
			W[j] = bit32_bxor(bit32_rrotate(a, 7), bit32_lrotate(a, 14), bit32_rshift(a, 3)) + bit32_bxor(bit32_lrotate(b, 15), bit32_lrotate(b, 13), bit32_rshift(b, 10)) + W[j - 7] + W[j - 16]
		end

		local a, b, c, d, e, f, g, h = h1, h2, h3, h4, h5, h6, h7, h8
		for j = 1, 64 do
			local z = bit32_bxor(bit32_rrotate(e, 6), bit32_rrotate(e, 11), bit32_lrotate(e, 7)) + bit32_band(e, f) + bit32_band(-1 - e, g) + h + K[j] + W[j]
			h = g
			g = f
			f = e
			e = z + d
			d = c
			c = b
			b = a
			a = z + bit32_band(d, c) + bit32_band(a, bit32_bxor(d, c)) + bit32_bxor(bit32_rrotate(a, 2), bit32_rrotate(a, 13), bit32_lrotate(a, 10))
		end

		h1, h2, h3, h4 = (a + h1) % 4294967296, (b + h2) % 4294967296, (c + h3) % 4294967296, (d + h4) % 4294967296
		h5, h6, h7, h8 = (e + h5) % 4294967296, (f + h6) % 4294967296, (g + h7) % 4294967296, (h + h8) % 4294967296
	end

	H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8] = h1, h2, h3, h4, h5, h6, h7, h8
end

local function sha512_feed_128(H_lo, H_hi, str, offs, size)
	-- offs >= 0, size >= 0, size is multiple of 128
	-- W1_hi, W1_lo, W2_hi, W2_lo, ...   Wk_hi = W[2*k-1], Wk_lo = W[2*k]
	local W, K_lo, K_hi = common_W, sha2_K_lo, sha2_K_hi
	local h1_lo, h2_lo, h3_lo, h4_lo, h5_lo, h6_lo, h7_lo, h8_lo = H_lo[1], H_lo[2], H_lo[3], H_lo[4], H_lo[5], H_lo[6], H_lo[7], H_lo[8]
	local h1_hi, h2_hi, h3_hi, h4_hi, h5_hi, h6_hi, h7_hi, h8_hi = H_hi[1], H_hi[2], H_hi[3], H_hi[4], H_hi[5], H_hi[6], H_hi[7], H_hi[8]
	for pos = offs, offs + size - 1, 128 do
		for j = 1, 16 * 2 do
			pos = pos + 4
			local a, b, c, d = string.byte(str, pos - 3, pos)
			W[j] = ((a * 256 + b) * 256 + c) * 256 + d
		end

		for jj = 34, 160, 2 do
			local a_lo, a_hi, b_lo, b_hi = W[jj - 30], W[jj - 31], W[jj - 4], W[jj - 5]
			local tmp1 = bit32_bxor(bit32_rshift(a_lo, 1) + bit32_lshift(a_hi, 31), bit32_rshift(a_lo, 8) + bit32_lshift(a_hi, 24), bit32_rshift(a_lo, 7) + bit32_lshift(a_hi, 25)) % 4294967296 +
				bit32_bxor(bit32_rshift(b_lo, 19) + bit32_lshift(b_hi, 13), bit32_lshift(b_lo, 3) + bit32_rshift(b_hi, 29), bit32_rshift(b_lo, 6) + bit32_lshift(b_hi, 26)) % 4294967296 +
				W[jj - 14] + W[jj - 32]

			local tmp2 = tmp1 % 4294967296
			W[jj - 1] = bit32_bxor(bit32_rshift(a_hi, 1) + bit32_lshift(a_lo, 31), bit32_rshift(a_hi, 8) + bit32_lshift(a_lo, 24), bit32_rshift(a_hi, 7)) +
				bit32_bxor(bit32_rshift(b_hi, 19) + bit32_lshift(b_lo, 13), bit32_lshift(b_hi, 3) + bit32_rshift(b_lo, 29), bit32_rshift(b_hi, 6)) +
				W[jj - 15] + W[jj - 33] + (tmp1 - tmp2) / 4294967296

			W[jj] = tmp2
		end

		local a_lo, b_lo, c_lo, d_lo, e_lo, f_lo, g_lo, h_lo = h1_lo, h2_lo, h3_lo, h4_lo, h5_lo, h6_lo, h7_lo, h8_lo
		local a_hi, b_hi, c_hi, d_hi, e_hi, f_hi, g_hi, h_hi = h1_hi, h2_hi, h3_hi, h4_hi, h5_hi, h6_hi, h7_hi, h8_hi
		for j = 1, 80 do
			local jj = 2 * j
			local tmp1 = bit32_bxor(bit32_rshift(e_lo, 14) + bit32_lshift(e_hi, 18), bit32_rshift(e_lo, 18) + bit32_lshift(e_hi, 14), bit32_lshift(e_lo, 23) + bit32_rshift(e_hi, 9)) % 4294967296 +
				(bit32_band(e_lo, f_lo) + bit32_band(-1 - e_lo, g_lo)) % 4294967296 +
				h_lo + K_lo[j] + W[jj]

			local z_lo = tmp1 % 4294967296
			local z_hi = bit32_bxor(bit32_rshift(e_hi, 14) + bit32_lshift(e_lo, 18), bit32_rshift(e_hi, 18) + bit32_lshift(e_lo, 14), bit32_lshift(e_hi, 23) + bit32_rshift(e_lo, 9)) +
				bit32_band(e_hi, f_hi) + bit32_band(-1 - e_hi, g_hi) +
				h_hi + K_hi[j] + W[jj - 1] +
				(tmp1 - z_lo) / 4294967296

			h_lo = g_lo
			h_hi = g_hi
			g_lo = f_lo
			g_hi = f_hi
			f_lo = e_lo
			f_hi = e_hi
			tmp1 = z_lo + d_lo
			e_lo = tmp1 % 4294967296
			e_hi = z_hi + d_hi + (tmp1 - e_lo) / 4294967296
			d_lo = c_lo
			d_hi = c_hi
			c_lo = b_lo
			c_hi = b_hi
			b_lo = a_lo
			b_hi = a_hi
			tmp1 = z_lo + (bit32_band(d_lo, c_lo) + bit32_band(b_lo, bit32_bxor(d_lo, c_lo))) % 4294967296 + bit32_bxor(bit32_rshift(b_lo, 28) + bit32_lshift(b_hi, 4), bit32_lshift(b_lo, 30) + bit32_rshift(b_hi, 2), bit32_lshift(b_lo, 25) + bit32_rshift(b_hi, 7)) % 4294967296
			a_lo = tmp1 % 4294967296
			a_hi = z_hi + (bit32_band(d_hi, c_hi) + bit32_band(b_hi, bit32_bxor(d_hi, c_hi))) + bit32_bxor(bit32_rshift(b_hi, 28) + bit32_lshift(b_lo, 4), bit32_lshift(b_hi, 30) + bit32_rshift(b_lo, 2), bit32_lshift(b_hi, 25) + bit32_rshift(b_lo, 7)) + (tmp1 - a_lo) / 4294967296
		end

		a_lo = h1_lo + a_lo
		h1_lo = a_lo % 4294967296
		h1_hi = (h1_hi + a_hi + (a_lo - h1_lo) / 4294967296) % 4294967296
		a_lo = h2_lo + b_lo
		h2_lo = a_lo % 4294967296
		h2_hi = (h2_hi + b_hi + (a_lo - h2_lo) / 4294967296) % 4294967296
		a_lo = h3_lo + c_lo
		h3_lo = a_lo % 4294967296
		h3_hi = (h3_hi + c_hi + (a_lo - h3_lo) / 4294967296) % 4294967296
		a_lo = h4_lo + d_lo
		h4_lo = a_lo % 4294967296
		h4_hi = (h4_hi + d_hi + (a_lo - h4_lo) / 4294967296) % 4294967296
		a_lo = h5_lo + e_lo
		h5_lo = a_lo % 4294967296
		h5_hi = (h5_hi + e_hi + (a_lo - h5_lo) / 4294967296) % 4294967296
		a_lo = h6_lo + f_lo
		h6_lo = a_lo % 4294967296
		h6_hi = (h6_hi + f_hi + (a_lo - h6_lo) / 4294967296) % 4294967296
		a_lo = h7_lo + g_lo
		h7_lo = a_lo % 4294967296
		h7_hi = (h7_hi + g_hi + (a_lo - h7_lo) / 4294967296) % 4294967296
		a_lo = h8_lo + h_lo
		h8_lo = a_lo % 4294967296
		h8_hi = (h8_hi + h_hi + (a_lo - h8_lo) / 4294967296) % 4294967296
	end

	H_lo[1], H_lo[2], H_lo[3], H_lo[4], H_lo[5], H_lo[6], H_lo[7], H_lo[8] = h1_lo, h2_lo, h3_lo, h4_lo, h5_lo, h6_lo, h7_lo, h8_lo
	H_hi[1], H_hi[2], H_hi[3], H_hi[4], H_hi[5], H_hi[6], H_hi[7], H_hi[8] = h1_hi, h2_hi, h3_hi, h4_hi, h5_hi, h6_hi, h7_hi, h8_hi
end

local function md5_feed_64(H, str, offs, size)
	-- offs >= 0, size >= 0, size is multiple of 64
	local W, K, md5_next_shift = common_W, md5_K, md5_next_shift
	local h1, h2, h3, h4 = H[1], H[2], H[3], H[4]
	for pos = offs, offs + size - 1, 64 do
		for j = 1, 16 do
			pos = pos + 4
			local a, b, c, d = string.byte(str, pos - 3, pos)
			W[j] = ((d * 256 + c) * 256 + b) * 256 + a
		end

		local a, b, c, d = h1, h2, h3, h4
		local s = 25
		for j = 1, 16 do
			local F = bit32_rrotate(bit32_band(b, c) + bit32_band(-1 - b, d) + a + K[j] + W[j], s) + b
			s = md5_next_shift[s]
			a = d
			d = c
			c = b
			b = F
		end

		s = 27
		for j = 17, 32 do
			local F = bit32_rrotate(bit32_band(d, b) + bit32_band(-1 - d, c) + a + K[j] + W[(5 * j - 4) % 16 + 1], s) + b
			s = md5_next_shift[s]
			a = d
			d = c
			c = b
			b = F
		end

		s = 28
		for j = 33, 48 do
			local F = bit32_rrotate(bit32_bxor(bit32_bxor(b, c), d) + a + K[j] + W[(3 * j + 2) % 16 + 1], s) + b
			s = md5_next_shift[s]
			a = d
			d = c
			c = b
			b = F
		end

		s = 26
		for j = 49, 64 do
			local F = bit32_rrotate(bit32_bxor(c, bit32_bor(b, -1 - d)) + a + K[j] + W[(j * 7 - 7) % 16 + 1], s) + b
			s = md5_next_shift[s]
			a = d
			d = c
			c = b
			b = F
		end

		h1 = (a + h1) % 4294967296
		h2 = (b + h2) % 4294967296
		h3 = (c + h3) % 4294967296
		h4 = (d + h4) % 4294967296
	end

	H[1], H[2], H[3], H[4] = h1, h2, h3, h4
end

local function sha1_feed_64(H, str, offs, size)
	-- offs >= 0, size >= 0, size is multiple of 64
	local W = common_W
	local h1, h2, h3, h4, h5 = H[1], H[2], H[3], H[4], H[5]
	for pos = offs, offs + size - 1, 64 do
		for j = 1, 16 do
			pos = pos + 4
			local a, b, c, d = string.byte(str, pos - 3, pos)
			W[j] = ((a * 256 + b) * 256 + c) * 256 + d
		end

		for j = 17, 80 do
			W[j] = bit32_lrotate(bit32_bxor(W[j - 3], W[j - 8], W[j - 14], W[j - 16]), 1)
		end

		local a, b, c, d, e = h1, h2, h3, h4, h5
		for j = 1, 20 do
			local z = bit32_lrotate(a, 5) + bit32_band(b, c) + bit32_band(-1 - b, d) + 0x5A827999 + W[j] + e -- constant = math.floor(TWO_POW_30 * sqrt(2))
			e = d
			d = c
			c = bit32_rrotate(b, 2)
			b = a
			a = z
		end

		for j = 21, 40 do
			local z = bit32_lrotate(a, 5) + bit32_bxor(b, c, d) + 0x6ED9EBA1 + W[j] + e -- TWO_POW_30 * sqrt(3)
			e = d
			d = c
			c = bit32_rrotate(b, 2)
			b = a
			a = z
		end

		for j = 41, 60 do
			local z = bit32_lrotate(a, 5) + bit32_band(d, c) + bit32_band(b, bit32_bxor(d, c)) + 0x8F1BBCDC + W[j] + e -- TWO_POW_30 * sqrt(5)
			e = d
			d = c
			c = bit32_rrotate(b, 2)
			b = a
			a = z
		end

		for j = 61, 80 do
			local z = bit32_lrotate(a, 5) + bit32_bxor(b, c, d) + 0xCA62C1D6 + W[j] + e -- TWO_POW_30 * sqrt(10)
			e = d
			d = c
			c = bit32_rrotate(b, 2)
			b = a
			a = z
		end

		h1 = (a + h1) % 4294967296
		h2 = (b + h2) % 4294967296
		h3 = (c + h3) % 4294967296
		h4 = (d + h4) % 4294967296
		h5 = (e + h5) % 4294967296
	end

	H[1], H[2], H[3], H[4], H[5] = h1, h2, h3, h4, h5
end

local function keccak_feed(lanes_lo, lanes_hi, str, offs, size, block_size_in_bytes)
	-- This is an example of a Lua function having 79 local variables :-)
	-- offs >= 0, size >= 0, size is multiple of block_size_in_bytes, block_size_in_bytes is positive multiple of 8
	local RC_lo, RC_hi = sha3_RC_lo, sha3_RC_hi
	local qwords_qty = block_size_in_bytes / 8
	for pos = offs, offs + size - 1, block_size_in_bytes do
		for j = 1, qwords_qty do
			local a, b, c, d = string.byte(str, pos + 1, pos + 4)
			lanes_lo[j] = bit32_bxor(lanes_lo[j], ((d * 256 + c) * 256 + b) * 256 + a)
			pos = pos + 8
			a, b, c, d = string.byte(str, pos - 3, pos)
			lanes_hi[j] = bit32_bxor(lanes_hi[j], ((d * 256 + c) * 256 + b) * 256 + a)
		end

		local L01_lo, L01_hi, L02_lo, L02_hi, L03_lo, L03_hi, L04_lo, L04_hi, L05_lo, L05_hi, L06_lo, L06_hi, L07_lo, L07_hi, L08_lo, L08_hi, L09_lo, L09_hi, L10_lo, L10_hi, L11_lo, L11_hi, L12_lo, L12_hi, L13_lo, L13_hi, L14_lo, L14_hi, L15_lo, L15_hi, L16_lo, L16_hi, L17_lo, L17_hi, L18_lo, L18_hi, L19_lo, L19_hi, L20_lo, L20_hi, L21_lo, L21_hi, L22_lo, L22_hi, L23_lo, L23_hi, L24_lo, L24_hi, L25_lo, L25_hi = lanes_lo[1], lanes_hi[1], lanes_lo[2], lanes_hi[2], lanes_lo[3], lanes_hi[3], lanes_lo[4], lanes_hi[4], lanes_lo[5], lanes_hi[5], lanes_lo[6], lanes_hi[6], lanes_lo[7], lanes_hi[7], lanes_lo[8], lanes_hi[8], lanes_lo[9], lanes_hi[9], lanes_lo[10], lanes_hi[10], lanes_lo[11], lanes_hi[11], lanes_lo[12], lanes_hi[12], lanes_lo[13], lanes_hi[13], lanes_lo[14], lanes_hi[14], lanes_lo[15], lanes_hi[15], lanes_lo[16], lanes_hi[16], lanes_lo[17], lanes_hi[17], lanes_lo[18], lanes_hi[18], lanes_lo[19], lanes_hi[19], lanes_lo[20], lanes_hi[20], lanes_lo[21], lanes_hi[21], lanes_lo[22], lanes_hi[22], lanes_lo[23], lanes_hi[23], lanes_lo[24], lanes_hi[24], lanes_lo[25], lanes_hi[25]

		for round_idx = 1, 24 do
			local C1_lo = bit32_bxor(L01_lo, L06_lo, L11_lo, L16_lo, L21_lo)
			local C1_hi = bit32_bxor(L01_hi, L06_hi, L11_hi, L16_hi, L21_hi)
			local C2_lo = bit32_bxor(L02_lo, L07_lo, L12_lo, L17_lo, L22_lo)
			local C2_hi = bit32_bxor(L02_hi, L07_hi, L12_hi, L17_hi, L22_hi)
			local C3_lo = bit32_bxor(L03_lo, L08_lo, L13_lo, L18_lo, L23_lo)
			local C3_hi = bit32_bxor(L03_hi, L08_hi, L13_hi, L18_hi, L23_hi)
			local C4_lo = bit32_bxor(L04_lo, L09_lo, L14_lo, L19_lo, L24_lo)
			local C4_hi = bit32_bxor(L04_hi, L09_hi, L14_hi, L19_hi, L24_hi)
			local C5_lo = bit32_bxor(L05_lo, L10_lo, L15_lo, L20_lo, L25_lo)
			local C5_hi = bit32_bxor(L05_hi, L10_hi, L15_hi, L20_hi, L25_hi)

			local D_lo = bit32_bxor(C1_lo, C3_lo * 2 + (C3_hi % TWO_POW_32 - C3_hi % TWO_POW_31) / TWO_POW_31)
			local D_hi = bit32_bxor(C1_hi, C3_hi * 2 + (C3_lo % TWO_POW_32 - C3_lo % TWO_POW_31) / TWO_POW_31)

			local T0_lo = bit32_bxor(D_lo, L02_lo)
			local T0_hi = bit32_bxor(D_hi, L02_hi)
			local T1_lo = bit32_bxor(D_lo, L07_lo)
			local T1_hi = bit32_bxor(D_hi, L07_hi)
			local T2_lo = bit32_bxor(D_lo, L12_lo)
			local T2_hi = bit32_bxor(D_hi, L12_hi)
			local T3_lo = bit32_bxor(D_lo, L17_lo)
			local T3_hi = bit32_bxor(D_hi, L17_hi)
			local T4_lo = bit32_bxor(D_lo, L22_lo)
			local T4_hi = bit32_bxor(D_hi, L22_hi)

			L02_lo = (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_20) / TWO_POW_20 + T1_hi * TWO_POW_12
			L02_hi = (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_20) / TWO_POW_20 + T1_lo * TWO_POW_12
			L07_lo = (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_19) / TWO_POW_19 + T3_hi * TWO_POW_13
			L07_hi = (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_19) / TWO_POW_19 + T3_lo * TWO_POW_13
			L12_lo = T0_lo * 2 + (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_31) / TWO_POW_31
			L12_hi = T0_hi * 2 + (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_31) / TWO_POW_31
			L17_lo = T2_lo * TWO_POW_10 + (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_22) / TWO_POW_22
			L17_hi = T2_hi * TWO_POW_10 + (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_22) / TWO_POW_22
			L22_lo = T4_lo * TWO_POW_2 + (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_30) / TWO_POW_30
			L22_hi = T4_hi * TWO_POW_2 + (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_30) / TWO_POW_30

			D_lo = bit32_bxor(C2_lo, C4_lo * 2 + (C4_hi % TWO_POW_32 - C4_hi % TWO_POW_31) / TWO_POW_31)
			D_hi = bit32_bxor(C2_hi, C4_hi * 2 + (C4_lo % TWO_POW_32 - C4_lo % TWO_POW_31) / TWO_POW_31)

			T0_lo = bit32_bxor(D_lo, L03_lo)
			T0_hi = bit32_bxor(D_hi, L03_hi)
			T1_lo = bit32_bxor(D_lo, L08_lo)
			T1_hi = bit32_bxor(D_hi, L08_hi)
			T2_lo = bit32_bxor(D_lo, L13_lo)
			T2_hi = bit32_bxor(D_hi, L13_hi)
			T3_lo = bit32_bxor(D_lo, L18_lo)
			T3_hi = bit32_bxor(D_hi, L18_hi)
			T4_lo = bit32_bxor(D_lo, L23_lo)
			T4_hi = bit32_bxor(D_hi, L23_hi)

			L03_lo = (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_21) / TWO_POW_21 + T2_hi * TWO_POW_11
			L03_hi = (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_21) / TWO_POW_21 + T2_lo * TWO_POW_11
			L08_lo = (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_3) / TWO_POW_3 + T4_hi * TWO_POW_29 % TWO_POW_32
			L08_hi = (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_3) / TWO_POW_3 + T4_lo * TWO_POW_29 % TWO_POW_32
			L13_lo = T1_lo * TWO_POW_6 + (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_26) / TWO_POW_26
			L13_hi = T1_hi * TWO_POW_6 + (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_26) / TWO_POW_26
			L18_lo = T3_lo * TWO_POW_15 + (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_17) / TWO_POW_17
			L18_hi = T3_hi * TWO_POW_15 + (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_17) / TWO_POW_17
			L23_lo = (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_2) / TWO_POW_2 + T0_hi * TWO_POW_30 % TWO_POW_32
			L23_hi = (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_2) / TWO_POW_2 + T0_lo * TWO_POW_30 % TWO_POW_32

			D_lo = bit32_bxor(C3_lo, C5_lo * 2 + (C5_hi % TWO_POW_32 - C5_hi % TWO_POW_31) / TWO_POW_31)
			D_hi = bit32_bxor(C3_hi, C5_hi * 2 + (C5_lo % TWO_POW_32 - C5_lo % TWO_POW_31) / TWO_POW_31)

			T0_lo = bit32_bxor(D_lo, L04_lo)
			T0_hi = bit32_bxor(D_hi, L04_hi)
			T1_lo = bit32_bxor(D_lo, L09_lo)
			T1_hi = bit32_bxor(D_hi, L09_hi)
			T2_lo = bit32_bxor(D_lo, L14_lo)
			T2_hi = bit32_bxor(D_hi, L14_hi)
			T3_lo = bit32_bxor(D_lo, L19_lo)
			T3_hi = bit32_bxor(D_hi, L19_hi)
			T4_lo = bit32_bxor(D_lo, L24_lo)
			T4_hi = bit32_bxor(D_hi, L24_hi)

			L04_lo = T3_lo * TWO_POW_21 % TWO_POW_32 + (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_11) / TWO_POW_11
			L04_hi = T3_hi * TWO_POW_21 % TWO_POW_32 + (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_11) / TWO_POW_11
			L09_lo = T0_lo * TWO_POW_28 % TWO_POW_32 + (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_4) / TWO_POW_4
			L09_hi = T0_hi * TWO_POW_28 % TWO_POW_32 + (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_4) / TWO_POW_4
			L14_lo = T2_lo * TWO_POW_25 % TWO_POW_32 + (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_7) / TWO_POW_7
			L14_hi = T2_hi * TWO_POW_25 % TWO_POW_32 + (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_7) / TWO_POW_7
			L19_lo = (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_8) / TWO_POW_8 + T4_hi * TWO_POW_24 % TWO_POW_32
			L19_hi = (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_8) / TWO_POW_8 + T4_lo * TWO_POW_24 % TWO_POW_32
			L24_lo = (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_9) / TWO_POW_9 + T1_hi * TWO_POW_23 % TWO_POW_32
			L24_hi = (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_9) / TWO_POW_9 + T1_lo * TWO_POW_23 % TWO_POW_32

			D_lo = bit32_bxor(C4_lo, C1_lo * 2 + (C1_hi % TWO_POW_32 - C1_hi % TWO_POW_31) / TWO_POW_31)
			D_hi = bit32_bxor(C4_hi, C1_hi * 2 + (C1_lo % TWO_POW_32 - C1_lo % TWO_POW_31) / TWO_POW_31)

			T0_lo = bit32_bxor(D_lo, L05_lo)
			T0_hi = bit32_bxor(D_hi, L05_hi)
			T1_lo = bit32_bxor(D_lo, L10_lo)
			T1_hi = bit32_bxor(D_hi, L10_hi)
			T2_lo = bit32_bxor(D_lo, L15_lo)
			T2_hi = bit32_bxor(D_hi, L15_hi)
			T3_lo = bit32_bxor(D_lo, L20_lo)
			T3_hi = bit32_bxor(D_hi, L20_hi)
			T4_lo = bit32_bxor(D_lo, L25_lo)
			T4_hi = bit32_bxor(D_hi, L25_hi)

			L05_lo = T4_lo * TWO_POW_14 + (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_18) / TWO_POW_18
			L05_hi = T4_hi * TWO_POW_14 + (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_18) / TWO_POW_18
			L10_lo = T1_lo * TWO_POW_20 % TWO_POW_32 + (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_12) / TWO_POW_12
			L10_hi = T1_hi * TWO_POW_20 % TWO_POW_32 + (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_12) / TWO_POW_12
			L15_lo = T3_lo * TWO_POW_8 + (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_24) / TWO_POW_24
			L15_hi = T3_hi * TWO_POW_8 + (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_24) / TWO_POW_24
			L20_lo = T0_lo * TWO_POW_27 % TWO_POW_32 + (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_5) / TWO_POW_5
			L20_hi = T0_hi * TWO_POW_27 % TWO_POW_32 + (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_5) / TWO_POW_5
			L25_lo = (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_25) / TWO_POW_25 + T2_hi * TWO_POW_7
			L25_hi = (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_25) / TWO_POW_25 + T2_lo * TWO_POW_7

			D_lo = bit32_bxor(C5_lo, C2_lo * 2 + (C2_hi % TWO_POW_32 - C2_hi % TWO_POW_31) / TWO_POW_31)
			D_hi = bit32_bxor(C5_hi, C2_hi * 2 + (C2_lo % TWO_POW_32 - C2_lo % TWO_POW_31) / TWO_POW_31)

			T1_lo = bit32_bxor(D_lo, L06_lo)
			T1_hi = bit32_bxor(D_hi, L06_hi)
			T2_lo = bit32_bxor(D_lo, L11_lo)
			T2_hi = bit32_bxor(D_hi, L11_hi)
			T3_lo = bit32_bxor(D_lo, L16_lo)
			T3_hi = bit32_bxor(D_hi, L16_hi)
			T4_lo = bit32_bxor(D_lo, L21_lo)
			T4_hi = bit32_bxor(D_hi, L21_hi)

			L06_lo = T2_lo * TWO_POW_3 + (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_29) / TWO_POW_29
			L06_hi = T2_hi * TWO_POW_3 + (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_29) / TWO_POW_29
			L11_lo = T4_lo * TWO_POW_18 + (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_14) / TWO_POW_14
			L11_hi = T4_hi * TWO_POW_18 + (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_14) / TWO_POW_14
			L16_lo = (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_28) / TWO_POW_28 + T1_hi * TWO_POW_4
			L16_hi = (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_28) / TWO_POW_28 + T1_lo * TWO_POW_4
			L21_lo = (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_23) / TWO_POW_23 + T3_hi * TWO_POW_9
			L21_hi = (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_23) / TWO_POW_23 + T3_lo * TWO_POW_9

			L01_lo = bit32_bxor(D_lo, L01_lo)
			L01_hi = bit32_bxor(D_hi, L01_hi)
			L01_lo, L02_lo, L03_lo, L04_lo, L05_lo = bit32_bxor(L01_lo, bit32_band(-1 - L02_lo, L03_lo)), bit32_bxor(L02_lo, bit32_band(-1 - L03_lo, L04_lo)), bit32_bxor(L03_lo, bit32_band(-1 - L04_lo, L05_lo)), bit32_bxor(L04_lo, bit32_band(-1 - L05_lo, L01_lo)), bit32_bxor(L05_lo, bit32_band(-1 - L01_lo, L02_lo))
			L01_hi, L02_hi, L03_hi, L04_hi, L05_hi = bit32_bxor(L01_hi, bit32_band(-1 - L02_hi, L03_hi)), bit32_bxor(L02_hi, bit32_band(-1 - L03_hi, L04_hi)), bit32_bxor(L03_hi, bit32_band(-1 - L04_hi, L05_hi)), bit32_bxor(L04_hi, bit32_band(-1 - L05_hi, L01_hi)), bit32_bxor(L05_hi, bit32_band(-1 - L01_hi, L02_hi))
			L06_lo, L07_lo, L08_lo, L09_lo, L10_lo = bit32_bxor(L09_lo, bit32_band(-1 - L10_lo, L06_lo)), bit32_bxor(L10_lo, bit32_band(-1 - L06_lo, L07_lo)), bit32_bxor(L06_lo, bit32_band(-1 - L07_lo, L08_lo)), bit32_bxor(L07_lo, bit32_band(-1 - L08_lo, L09_lo)), bit32_bxor(L08_lo, bit32_band(-1 - L09_lo, L10_lo))
			L06_hi, L07_hi, L08_hi, L09_hi, L10_hi = bit32_bxor(L09_hi, bit32_band(-1 - L10_hi, L06_hi)), bit32_bxor(L10_hi, bit32_band(-1 - L06_hi, L07_hi)), bit32_bxor(L06_hi, bit32_band(-1 - L07_hi, L08_hi)), bit32_bxor(L07_hi, bit32_band(-1 - L08_hi, L09_hi)), bit32_bxor(L08_hi, bit32_band(-1 - L09_hi, L10_hi))
			L11_lo, L12_lo, L13_lo, L14_lo, L15_lo = bit32_bxor(L12_lo, bit32_band(-1 - L13_lo, L14_lo)), bit32_bxor(L13_lo, bit32_band(-1 - L14_lo, L15_lo)), bit32_bxor(L14_lo, bit32_band(-1 - L15_lo, L11_lo)), bit32_bxor(L15_lo, bit32_band(-1 - L11_lo, L12_lo)), bit32_bxor(L11_lo, bit32_band(-1 - L12_lo, L13_lo))
			L11_hi, L12_hi, L13_hi, L14_hi, L15_hi = bit32_bxor(L12_hi, bit32_band(-1 - L13_hi, L14_hi)), bit32_bxor(L13_hi, bit32_band(-1 - L14_hi, L15_hi)), bit32_bxor(L14_hi, bit32_band(-1 - L15_hi, L11_hi)), bit32_bxor(L15_hi, bit32_band(-1 - L11_hi, L12_hi)), bit32_bxor(L11_hi, bit32_band(-1 - L12_hi, L13_hi))
			L16_lo, L17_lo, L18_lo, L19_lo, L20_lo = bit32_bxor(L20_lo, bit32_band(-1 - L16_lo, L17_lo)), bit32_bxor(L16_lo, bit32_band(-1 - L17_lo, L18_lo)), bit32_bxor(L17_lo, bit32_band(-1 - L18_lo, L19_lo)), bit32_bxor(L18_lo, bit32_band(-1 - L19_lo, L20_lo)), bit32_bxor(L19_lo, bit32_band(-1 - L20_lo, L16_lo))
			L16_hi, L17_hi, L18_hi, L19_hi, L20_hi = bit32_bxor(L20_hi, bit32_band(-1 - L16_hi, L17_hi)), bit32_bxor(L16_hi, bit32_band(-1 - L17_hi, L18_hi)), bit32_bxor(L17_hi, bit32_band(-1 - L18_hi, L19_hi)), bit32_bxor(L18_hi, bit32_band(-1 - L19_hi, L20_hi)), bit32_bxor(L19_hi, bit32_band(-1 - L20_hi, L16_hi))
			L21_lo, L22_lo, L23_lo, L24_lo, L25_lo = bit32_bxor(L23_lo, bit32_band(-1 - L24_lo, L25_lo)), bit32_bxor(L24_lo, bit32_band(-1 - L25_lo, L21_lo)), bit32_bxor(L25_lo, bit32_band(-1 - L21_lo, L22_lo)), bit32_bxor(L21_lo, bit32_band(-1 - L22_lo, L23_lo)), bit32_bxor(L22_lo, bit32_band(-1 - L23_lo, L24_lo))
			L21_hi, L22_hi, L23_hi, L24_hi, L25_hi = bit32_bxor(L23_hi, bit32_band(-1 - L24_hi, L25_hi)), bit32_bxor(L24_hi, bit32_band(-1 - L25_hi, L21_hi)), bit32_bxor(L25_hi, bit32_band(-1 - L21_hi, L22_hi)), bit32_bxor(L21_hi, bit32_band(-1 - L22_hi, L23_hi)), bit32_bxor(L22_hi, bit32_band(-1 - L23_hi, L24_hi))
			L01_lo = bit32_bxor(L01_lo, RC_lo[round_idx])
			L01_hi = L01_hi + RC_hi[round_idx] -- RC_hi[] is either 0 or 0x80000000, so we could use fast addition instead of slow XOR
		end

		lanes_lo[1] = L01_lo
		lanes_hi[1] = L01_hi
		lanes_lo[2] = L02_lo
		lanes_hi[2] = L02_hi
		lanes_lo[3] = L03_lo
		lanes_hi[3] = L03_hi
		lanes_lo[4] = L04_lo
		lanes_hi[4] = L04_hi
		lanes_lo[5] = L05_lo
		lanes_hi[5] = L05_hi
		lanes_lo[6] = L06_lo
		lanes_hi[6] = L06_hi
		lanes_lo[7] = L07_lo
		lanes_hi[7] = L07_hi
		lanes_lo[8] = L08_lo
		lanes_hi[8] = L08_hi
		lanes_lo[9] = L09_lo
		lanes_hi[9] = L09_hi
		lanes_lo[10] = L10_lo
		lanes_hi[10] = L10_hi
		lanes_lo[11] = L11_lo
		lanes_hi[11] = L11_hi
		lanes_lo[12] = L12_lo
		lanes_hi[12] = L12_hi
		lanes_lo[13] = L13_lo
		lanes_hi[13] = L13_hi
		lanes_lo[14] = L14_lo
		lanes_hi[14] = L14_hi
		lanes_lo[15] = L15_lo
		lanes_hi[15] = L15_hi
		lanes_lo[16] = L16_lo
		lanes_hi[16] = L16_hi
		lanes_lo[17] = L17_lo
		lanes_hi[17] = L17_hi
		lanes_lo[18] = L18_lo
		lanes_hi[18] = L18_hi
		lanes_lo[19] = L19_lo
		lanes_hi[19] = L19_hi
		lanes_lo[20] = L20_lo
		lanes_hi[20] = L20_hi
		lanes_lo[21] = L21_lo
		lanes_hi[21] = L21_hi
		lanes_lo[22] = L22_lo
		lanes_hi[22] = L22_hi
		lanes_lo[23] = L23_lo
		lanes_hi[23] = L23_hi
		lanes_lo[24] = L24_lo
		lanes_hi[24] = L24_hi
		lanes_lo[25] = L25_lo
		lanes_hi[25] = L25_hi
	end
end

--------------------------------------------------------------------------------
-- MAGIC NUMBERS CALCULATOR
--------------------------------------------------------------------------------
-- Q:
--    Is 53-bit "double" math enough to calculate square roots and cube roots of primes with 64 correct bits after decimal point?
-- A:
--    Yes, 53-bit "double" arithmetic is enough.
--    We could obtain first 40 bits by direct calculation of p^(1/3) and next 40 bits by one step of Newton's method.
do
	local function mul(src1, src2, factor, result_length)
		-- src1, src2 - long integers (arrays of digits in base TWO_POW_24)
		-- factor - small integer
		-- returns long integer result (src1 * src2 * factor) and its floating point approximation
		local result, carry, value, weight = table.create(result_length), 0, 0, 1
		for j = 1, result_length do
			for k = math.max(1, j + 1 - #src2), math.min(j, #src1) do
				carry = carry + factor * src1[k] * src2[j + 1 - k] -- "int32" is not enough for multiplication result, that's why "factor" must be of type "double"
			end

			local digit = carry % TWO_POW_24
			result[j] = math.floor(digit)
			carry = (carry - digit) / TWO_POW_24
			value = value + digit * weight
			weight = weight * TWO_POW_24
		end

		return result, value
	end

	local idx, step, p, one, sqrt_hi, sqrt_lo = 0, {4, 1, 2, -2, 2}, 4, {1}, sha2_H_hi, sha2_H_lo
	repeat
		p = p + step[p % 6]
		local d = 1
		repeat
			d = d + step[d % 6]
			if d * d > p then
				-- next prime number is found
				local root = p ^ (1 / 3)
				local R = root * TWO_POW_40
				R = mul(table.create(1, math.floor(R)), one, 1, 2)
				local _, delta = mul(R, mul(R, R, 1, 4), -1, 4)
				local hi = R[2] % 65536 * 65536 + math.floor(R[1] / 256)
				local lo = R[1] % 256 * 16777216 + math.floor(delta * (TWO_POW_NEG_56 / 3) * root / p)

				if idx < 16 then
					root = math.sqrt(p)
					R = root * TWO_POW_40
					R = mul(table.create(1, math.floor(R)), one, 1, 2)
					_, delta = mul(R, R, -1, 2)
					local hi = R[2] % 65536 * 65536 + math.floor(R[1] / 256)
					local lo = R[1] % 256 * 16777216 + math.floor(delta * TWO_POW_NEG_17 / root)
					local idx = idx % 8 + 1
					sha2_H_ext256[224][idx] = lo
					sqrt_hi[idx], sqrt_lo[idx] = hi, lo + hi * hi_factor
					if idx > 7 then
						sqrt_hi, sqrt_lo = sha2_H_ext512_hi[384], sha2_H_ext512_lo[384]
					end
				end

				idx = idx + 1
				sha2_K_hi[idx], sha2_K_lo[idx] = hi, lo % K_lo_modulo + hi * hi_factor
				break
			end
		until p % d == 0
	until idx > 79
end

-- Calculating IVs for SHA512/224 and SHA512/256
for width = 224, 256, 32 do
	local H_lo, H_hi = {}, nil
	if XOR64A5 then
		for j = 1, 8 do
			H_lo[j] = XOR64A5(sha2_H_lo[j])
		end
	else
		H_hi = {}
		for j = 1, 8 do
			H_lo[j] = bit32_bxor(sha2_H_lo[j], 0xA5A5A5A5) % 4294967296
			H_hi[j] = bit32_bxor(sha2_H_hi[j], 0xA5A5A5A5) % 4294967296
		end
	end

	sha512_feed_128(H_lo, H_hi, "SHA-512/" .. tostring(width) .. "\128" .. string.rep("\0", 115) .. "\88", 0, 128)
	sha2_H_ext512_lo[width] = H_lo
	sha2_H_ext512_hi[width] = H_hi
end

-- Constants for MD5
do
	for idx = 1, 64 do
		-- we can't use formula math.floor(abs(sin(idx))*TWO_POW_32) because its result may be beyond integer range on Lua built with 32-bit integers
		local hi, lo = math.modf(math.abs(math.sin(idx)) * TWO_POW_16)
		md5_K[idx] = hi * 65536 + math.floor(lo * TWO_POW_16)
	end
end

-- Constants for SHA3
do
	local sh_reg = 29
	local function next_bit()
		local r = sh_reg % 2
		sh_reg = bit32_bxor((sh_reg - r) / 2, 142 * r)
		return r
	end

	for idx = 1, 24 do
		local lo, m = 0, nil
		for _ = 1, 6 do
			m = m and m * m * 2 or 1
			lo = lo + next_bit() * m
		end

		local hi = next_bit() * m
		sha3_RC_hi[idx], sha3_RC_lo[idx] = hi, lo + hi * hi_factor_keccak
	end
end

--------------------------------------------------------------------------------
-- MAIN FUNCTIONS
--------------------------------------------------------------------------------
local function sha256ext(width, message)
	-- Create an instance (private objects for current calculation)
	local Array256 = sha2_H_ext256[width] -- # == 8
	local length, tail = 0, ""
	local H = table.create(8)
	H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8] = Array256[1], Array256[2], Array256[3], Array256[4], Array256[5], Array256[6], Array256[7], Array256[8]

	local function partial(message_part)
		if message_part then
			local partLength = #message_part
			if tail then
				length = length + partLength
				local offs = 0
				local tailLength = #tail
				if tail ~= "" and tailLength + partLength >= 64 then
					offs = 64 - tailLength
					sha256_feed_64(H, tail .. string.sub(message_part, 1, offs), 0, 64)
					tail = ""
				end

				local size = partLength - offs
				local size_tail = size % 64
				sha256_feed_64(H, message_part, offs, size - size_tail)
				tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
				return partial
			else
				error("Adding more chunks is not allowed after receiving the result", 2)
			end
		else
			if tail then
				local final_blocks = table.create(10) --{tail, "\128", string.rep("\0", (-9 - length) % 64 + 1)}
				final_blocks[1] = tail
				final_blocks[2] = "\128"
				final_blocks[3] = string.rep("\0", (-9 - length) % 64 + 1)

				tail = nil
				-- Assuming user data length is shorter than (TWO_POW_53)-9 bytes
				-- Anyway, it looks very unrealistic that someone would spend more than a year of calculations to process TWO_POW_53 bytes of data by using this Lua script :-)
				-- TWO_POW_53 bytes = TWO_POW_56 bits, so "bit-counter" fits in 7 bytes
				length = length * (8 / TWO56_POW_7) -- convert "byte-counter" to "bit-counter" and move decimal point to the left
				for j = 4, 10 do
					length = length % 1 * 256
					final_blocks[j] = string.char(math.floor(length))
				end

				final_blocks = table.concat(final_blocks)
				sha256_feed_64(H, final_blocks, 0, #final_blocks)
				local max_reg = width / 32
				for j = 1, max_reg do
					H[j] = string.format("%08x", H[j] % 4294967296)
				end

				H = table.concat(H, "", 1, max_reg)
			end

			return H
		end
	end

	if message then
		-- Actually perform calculations and return the SHA256 digest of a message
		return partial(message)()
	else
		-- Return function for chunk-by-chunk loading
		-- User should feed every chunk of input data as single argument to this function and finally get SHA256 digest by invoking this function without an argument
		return partial
	end
end

local function sha512ext(width, message)

	-- Create an instance (private objects for current calculation)
	local length, tail, H_lo, H_hi = 0, "", table.pack(table.unpack(sha2_H_ext512_lo[width])), not HEX64 and table.pack(table.unpack(sha2_H_ext512_hi[width]))

	local function partial(message_part)
		if message_part then
			local partLength = #message_part
			if tail then
				length = length + partLength
				local offs = 0
				if tail ~= "" and #tail + partLength >= 128 then
					offs = 128 - #tail
					sha512_feed_128(H_lo, H_hi, tail .. string.sub(message_part, 1, offs), 0, 128)
					tail = ""
				end

				local size = partLength - offs
				local size_tail = size % 128
				sha512_feed_128(H_lo, H_hi, message_part, offs, size - size_tail)
				tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
				return partial
			else
				error("Adding more chunks is not allowed after receiving the result", 2)
			end
		else
			if tail then
				local final_blocks = table.create(3) --{tail, "\128", string.rep("\0", (-17-length) % 128 + 9)}
				final_blocks[1] = tail
				final_blocks[2] = "\128"
				final_blocks[3] = string.rep("\0", (-17 - length) % 128 + 9)

				tail = nil
				-- Assuming user data length is shorter than (TWO_POW_53)-17 bytes
				-- TWO_POW_53 bytes = TWO_POW_56 bits, so "bit-counter" fits in 7 bytes
				length = length * (8 / TWO56_POW_7) -- convert "byte-counter" to "bit-counter" and move floating point to the left
				for j = 4, 10 do
					length = length % 1 * 256
					final_blocks[j] = string.char(math.floor(length))
				end

				final_blocks = table.concat(final_blocks)
				sha512_feed_128(H_lo, H_hi, final_blocks, 0, #final_blocks)
				local max_reg = math.ceil(width / 64)

				if HEX64 then
					for j = 1, max_reg do
						H_lo[j] = HEX64(H_lo[j])
					end
				else
					for j = 1, max_reg do
						H_lo[j] = string.format("%08x", H_hi[j] % 4294967296) .. string.format("%08x", H_lo[j] % 4294967296)
					end

					H_hi = nil
				end

				H_lo = string.sub(table.concat(H_lo, "", 1, max_reg), 1, width / 4)
			end

			return H_lo
		end
	end

	if message then
		-- Actually perform calculations and return the SHA512 digest of a message
		return partial(message)()
	else
		-- Return function for chunk-by-chunk loading
		-- User should feed every chunk of input data as single argument to this function and finally get SHA512 digest by invoking this function without an argument
		return partial
	end
end

local function md5(message)

	-- Create an instance (private objects for current calculation)
	local H, length, tail = table.create(4), 0, ""
	H[1], H[2], H[3], H[4] = md5_sha1_H[1], md5_sha1_H[2], md5_sha1_H[3], md5_sha1_H[4]

	local function partial(message_part)
		if message_part then
			local partLength = #message_part
			if tail then
				length = length + partLength
				local offs = 0
				if tail ~= "" and #tail + partLength >= 64 then
					offs = 64 - #tail
					md5_feed_64(H, tail .. string.sub(message_part, 1, offs), 0, 64)
					tail = ""
				end

				local size = partLength - offs
				local size_tail = size % 64
				md5_feed_64(H, message_part, offs, size - size_tail)
				tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
				return partial
			else
				error("Adding more chunks is not allowed after receiving the result", 2)
			end
		else
			if tail then
				local final_blocks = table.create(3) --{tail, "\128", string.rep("\0", (-9 - length) % 64)}
				final_blocks[1] = tail
				final_blocks[2] = "\128"
				final_blocks[3] = string.rep("\0", (-9 - length) % 64)
				tail = nil
				length = length * 8 -- convert "byte-counter" to "bit-counter"
				for j = 4, 11 do
					local low_byte = length % 256
					final_blocks[j] = string.char(low_byte)
					length = (length - low_byte) / 256
				end

				final_blocks = table.concat(final_blocks)
				md5_feed_64(H, final_blocks, 0, #final_blocks)
				for j = 1, 4 do
					H[j] = string.format("%08x", H[j] % 4294967296)
				end

				H = string.gsub(table.concat(H), "(..)(..)(..)(..)", "%4%3%2%1")
			end

			return H
		end
	end

	if message then
		-- Actually perform calculations and return the MD5 digest of a message
		return partial(message)()
	else
		-- Return function for chunk-by-chunk loading
		-- User should feed every chunk of input data as single argument to this function and finally get MD5 digest by invoking this function without an argument
		return partial
	end
end

local function sha1(message)
	-- Create an instance (private objects for current calculation)
	local H, length, tail = table.pack(table.unpack(md5_sha1_H)), 0, ""

	local function partial(message_part)
		if message_part then
			local partLength = #message_part
			if tail then
				length = length + partLength
				local offs = 0
				if tail ~= "" and #tail + partLength >= 64 then
					offs = 64 - #tail
					sha1_feed_64(H, tail .. string.sub(message_part, 1, offs), 0, 64)
					tail = ""
				end

				local size = partLength - offs
				local size_tail = size % 64
				sha1_feed_64(H, message_part, offs, size - size_tail)
				tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
				return partial
			else
				error("Adding more chunks is not allowed after receiving the result", 2)
			end
		else
			if tail then
				local final_blocks = table.create(10) --{tail, "\128", string.rep("\0", (-9 - length) % 64 + 1)}
				final_blocks[1] = tail
				final_blocks[2] = "\128"
				final_blocks[3] = string.rep("\0", (-9 - length) % 64 + 1)
				tail = nil

				-- Assuming user data length is shorter than (TWO_POW_53)-9 bytes
				-- TWO_POW_53 bytes = TWO_POW_56 bits, so "bit-counter" fits in 7 bytes
				length = length * (8 / TWO56_POW_7) -- convert "byte-counter" to "bit-counter" and move decimal point to the left
				for j = 4, 10 do
					length = length % 1 * 256
					final_blocks[j] = string.char(math.floor(length))
				end

				final_blocks = table.concat(final_blocks)
				sha1_feed_64(H, final_blocks, 0, #final_blocks)
				for j = 1, 5 do
					H[j] = string.format("%08x", H[j] % 4294967296)
				end

				H = table.concat(H)
			end

			return H
		end
	end

	if message then
		-- Actually perform calculations and return the SHA-1 digest of a message
		return partial(message)()
	else
		-- Return function for chunk-by-chunk loading
		-- User should feed every chunk of input data as single argument to this function and finally get SHA-1 digest by invoking this function without an argument
		return partial
	end
end

local function keccak(block_size_in_bytes, digest_size_in_bytes, is_SHAKE, message)
	-- "block_size_in_bytes" is multiple of 8
	if type(digest_size_in_bytes) ~= "number" then
		-- arguments in SHAKE are swapped:
		--    NIST FIPS 202 defines SHAKE(message,num_bits)
		--    this module   defines SHAKE(num_bytes,message)
		-- it's easy to forget about this swap, hence the check
		error("Argument 'digest_size_in_bytes' must be a number", 2)
	end

	-- Create an instance (private objects for current calculation)
	local tail, lanes_lo, lanes_hi = "", table.create(25, 0), hi_factor_keccak == 0 and table.create(25, 0)
	local result

	--~     pad the input N using the pad function, yielding a padded bit string P with a length divisible by r (such that n = len(P)/r is integer),
	--~     break P into n consecutive r-bit pieces P0, ..., Pn-1 (last is zero-padded)
	--~     initialize the state S to a string of b 0 bits.
	--~     absorb the input into the state: For each block Pi,
	--~         extend Pi at the end by a string of c 0 bits, yielding one of length b,
	--~         XOR that with S and
	--~         apply the block permutation f to the result, yielding a new state S
	--~     initialize Z to be the empty string
	--~     while the length of Z is less than d:
	--~         append the first r bits of S to Z
	--~         if Z is still less than d bits long, apply f to S, yielding a new state S.
	--~     truncate Z to d bits
	local function partial(message_part)
		if message_part then
			local partLength = #message_part
			if tail then
				local offs = 0
				if tail ~= "" and #tail + partLength >= block_size_in_bytes then
					offs = block_size_in_bytes - #tail
					keccak_feed(lanes_lo, lanes_hi, tail .. string.sub(message_part, 1, offs), 0, block_size_in_bytes, block_size_in_bytes)
					tail = ""
				end

				local size = partLength - offs
				local size_tail = size % block_size_in_bytes
				keccak_feed(lanes_lo, lanes_hi, message_part, offs, size - size_tail, block_size_in_bytes)
				tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
				return partial
			else
				error("Adding more chunks is not allowed after receiving the result", 2)
			end
		else
			if tail then
				-- append the following bits to the message: for usual SHA3: 011(0*)1, for SHAKE: 11111(0*)1
				local gap_start = is_SHAKE and 31 or 6
				tail = tail .. (#tail + 1 == block_size_in_bytes and string.char(gap_start + 128) or string.char(gap_start) .. string.rep("\0", (-2 - #tail) % block_size_in_bytes) .. "\128")
				keccak_feed(lanes_lo, lanes_hi, tail, 0, #tail, block_size_in_bytes)
				tail = nil

				local lanes_used = 0
				local total_lanes = math.floor(block_size_in_bytes / 8)
				local qwords = {}

				local function get_next_qwords_of_digest(qwords_qty)
					-- returns not more than 'qwords_qty' qwords ('qwords_qty' might be non-integer)
					-- doesn't go across keccak-buffer boundary
					-- block_size_in_bytes is a multiple of 8, so, keccak-buffer contains integer number of qwords
					if lanes_used >= total_lanes then
						keccak_feed(lanes_lo, lanes_hi, "\0\0\0\0\0\0\0\0", 0, 8, 8)
						lanes_used = 0
					end

					qwords_qty = math.floor(math.min(qwords_qty, total_lanes - lanes_used))
					if hi_factor_keccak ~= 0 then
						for j = 1, qwords_qty do
							qwords[j] = HEX64(lanes_lo[lanes_used + j - 1 + lanes_index_base])
						end
					else
						for j = 1, qwords_qty do
							qwords[j] = string.format("%08x", lanes_hi[lanes_used + j] % 4294967296) .. string.format("%08x", lanes_lo[lanes_used + j] % 4294967296)
						end
					end

					lanes_used = lanes_used + qwords_qty
					return string.gsub(table.concat(qwords, "", 1, qwords_qty), "(..)(..)(..)(..)(..)(..)(..)(..)", "%8%7%6%5%4%3%2%1"), qwords_qty * 8
				end

				local parts = {} -- digest parts
				local last_part, last_part_size = "", 0

				local function get_next_part_of_digest(bytes_needed)
					-- returns 'bytes_needed' bytes, for arbitrary integer 'bytes_needed'
					bytes_needed = bytes_needed or 1
					if bytes_needed <= last_part_size then
						last_part_size = last_part_size - bytes_needed
						local part_size_in_nibbles = bytes_needed * 2
						local result = string.sub(last_part, 1, part_size_in_nibbles)
						last_part = string.sub(last_part, part_size_in_nibbles + 1)
						return result
					end

					local parts_qty = 0
					if last_part_size > 0 then
						parts_qty = 1
						parts[parts_qty] = last_part
						bytes_needed = bytes_needed - last_part_size
					end

					-- repeats until the length is enough
					while bytes_needed >= 8 do
						local next_part, next_part_size = get_next_qwords_of_digest(bytes_needed / 8)
						parts_qty = parts_qty + 1
						parts[parts_qty] = next_part
						bytes_needed = bytes_needed - next_part_size
					end

					if bytes_needed > 0 then
						last_part, last_part_size = get_next_qwords_of_digest(1)
						parts_qty = parts_qty + 1
						parts[parts_qty] = get_next_part_of_digest(bytes_needed)
					else
						last_part, last_part_size = "", 0
					end

					return table.concat(parts, "", 1, parts_qty)
				end

				if digest_size_in_bytes < 0 then
					result = get_next_part_of_digest
				else
					result = get_next_part_of_digest(digest_size_in_bytes)
				end

			end

			return result
		end
	end

	if message then
		-- Actually perform calculations and return the SHA3 digest of a message
		return partial(message)()
	else
		-- Return function for chunk-by-chunk loading
		-- User should feed every chunk of input data as single argument to this function and finally get SHA3 digest by invoking this function without an argument
		return partial
	end
end

local function HexToBinFunction(hh)
	return string.char(tonumber(hh, 16))
end

local function hex2bin(hex_string)
	return (string.gsub(hex_string, "%x%x", HexToBinFunction))
end

local base64_symbols = {
	["+"] = 62, ["-"] = 62, [62] = "+";
	["/"] = 63, ["_"] = 63, [63] = "/";
	["="] = -1, ["."] = -1, [-1] = "=";
}

local symbol_index = 0
for j, pair in ipairs{"AZ", "az", "09"} do
	for ascii = string.byte(pair), string.byte(pair, 2) do
		local ch = string.char(ascii)
		base64_symbols[ch] = symbol_index
		base64_symbols[symbol_index] = ch
		symbol_index = symbol_index + 1
	end
end

local function bin2base64(binary_string)
	local stringLength = #binary_string
	local result = table.create(math.ceil(stringLength / 3))
	local length = 0

	for pos = 1, #binary_string, 3 do
		local c1, c2, c3, c4 = string.byte(string.sub(binary_string, pos, pos + 2) .. '\0', 1, -1)
		length = length + 1
		result[length] =
			base64_symbols[math.floor(c1 / 4)] ..
			base64_symbols[c1 % 4 * 16 + math.floor(c2 / 16)] ..
			base64_symbols[c3 and c2 % 16 * 4 + math.floor(c3 / 64) or -1] ..
			base64_symbols[c4 and c3 % 64 or -1]
	end

	return table.concat(result)
end

local function base642bin(base64_string)
	local result, chars_qty = {}, 3
	for pos, ch in string.gmatch(string.gsub(base64_string, "%s+", ""), "()(.)") do
		local code = base64_symbols[ch]
		if code < 0 then
			chars_qty = chars_qty - 1
			code = 0
		end

		local idx = pos % 4
		if idx > 0 then
			result[-idx] = code
		else
			local c1 = result[-1] * 4 + math.floor(result[-2] / 16)
			local c2 = (result[-2] % 16) * 16 + math.floor(result[-3] / 4)
			local c3 = (result[-3] % 4) * 64 + code
			result[#result + 1] = string.sub(string.char(c1, c2, c3), 1, chars_qty)
		end
	end

	return table.concat(result)
end

local block_size_for_HMAC -- this table will be initialized at the end of the module
--local function pad_and_xor(str, result_length, byte_for_xor)
--	return string.gsub(str, ".", function(c)
--		return string.char(bit32_bxor(string.byte(c), byte_for_xor))
--	end) .. string.rep(string.char(byte_for_xor), result_length - #str)
--end

-- For the sake of speed of converting hexes to strings, there's a map of the conversions here
local BinaryStringMap = {}
for Index = 0, 255 do
	BinaryStringMap[string.format("%02x", Index)] = string.char(Index)
end

-- Update 02.14.20 - added AsBinary for easy GameAnalytics replacement.
local function hmac(hash_func, key, message, AsBinary)
	-- Create an instance (private objects for current calculation)
	local block_size = block_size_for_HMAC[hash_func]
	if not block_size then
		error("Unknown hash function", 2)
	end

	local KeyLength = #key
	if KeyLength > block_size then
		key = string.gsub(hash_func(key), "%x%x", HexToBinFunction)
		KeyLength = #key
	end

	local append = hash_func()(string.gsub(key, ".", function(c)
		return string.char(bit32_bxor(string.byte(c), 0x36))
	end) .. string.rep("6", block_size - KeyLength)) -- 6 = string.char(0x36)

	local result

	local function partial(message_part)
		if not message_part then
			result = result or hash_func(
				string.gsub(key, ".", function(c)
					return string.char(bit32_bxor(string.byte(c), 0x5c))
				end) .. string.rep("\\", block_size - KeyLength) -- \ = string.char(0x5c)
				.. (string.gsub(append(), "%x%x", HexToBinFunction))
			)

			return result
		elseif result then
			error("Adding more chunks is not allowed after receiving the result", 2)
		else
			append(message_part)
			return partial
		end
	end

	if message then
		-- Actually perform calculations and return the HMAC of a message
		local FinalMessage = partial(message)()
		return AsBinary and (string.gsub(FinalMessage, "%x%x", BinaryStringMap)) or FinalMessage
	else
		-- Return function for chunk-by-chunk loading of a message
		-- User should feed every chunk of the message as single argument to this function and finally get HMAC by invoking this function without an argument
		return partial
	end
end

local sha = {
	md5 = md5,
	sha1 = sha1,
	-- SHA2 hash functions:
	sha224 = function(message)
		return sha256ext(224, message)
	end;

	sha256 = function(message)
		return sha256ext(256, message)
	end;

	sha512_224 = function(message)
		return sha512ext(224, message)
	end;

	sha512_256 = function(message)
		return sha512ext(256, message)
	end;

	sha384 = function(message)
		return sha512ext(384, message)
	end;

	sha512 = function(message)
		return sha512ext(512, message)
	end;

	-- SHA3 hash functions:
	sha3_224 = function(message)
		return keccak((1600 - 2 * 224) / 8, 224 / 8, false, message)
	end;

	sha3_256 = function(message)
		return keccak((1600 - 2 * 256) / 8, 256 / 8, false, message)
	end;

	sha3_384 = function(message)
		return keccak((1600 - 2 * 384) / 8, 384 / 8, false, message)
	end;

	sha3_512 = function(message)
		return keccak((1600 - 2 * 512) / 8, 512 / 8, false, message)
	end;

	shake128 = function(message, digest_size_in_bytes)
		return keccak((1600 - 2 * 128) / 8, digest_size_in_bytes, true, message)
	end;

	shake256 = function(message, digest_size_in_bytes)
		return keccak((1600 - 2 * 256) / 8, digest_size_in_bytes, true, message)
	end;

	-- misc utilities:
	hmac = hmac; -- HMAC(hash_func, key, message) is applicable to any hash function from this module except SHAKE*
	hex_to_bin = hex2bin; -- converts hexadecimal representation to binary string
	base64_to_bin = base642bin; -- converts base64 representation to binary string
	bin_to_base64 = bin2base64; -- converts binary string to base64 representation
}

block_size_for_HMAC = {
	[sha.md5] = 64;
	[sha.sha1] = 64;
	[sha.sha224] = 64;
	[sha.sha256] = 64;
	[sha.sha512_224] = 128;
	[sha.sha512_256] = 128;
	[sha.sha384] = 128;
	[sha.sha512] = 128;
	[sha.sha3_224] = (1600 - 2 * 224) / 8;
	[sha.sha3_256] = (1600 - 2 * 256) / 8;
	[sha.sha3_384] = (1600 - 2 * 384) / 8;
	[sha.sha3_512] = (1600 - 2 * 512) / 8;
}


getgenv().crypt.hash = function(inputString)
    if typeof(inputString) ~= "string" then
        error("Input must be a string")
    end
    local hash = sha.sha256(inputString)
    return hash
end

getgenv().getscripthash = function(script)
    if not script:IsA("LocalScript") and not script:IsA("ModuleScript") then
        return nil
    end
    
    local source = script.Source or script:GetAttribute("Source")
    if source then
        local hash = sha.sha1(source)
        return hash
    else
        return nil
    end
end
getscripthash = getgenv().getscripthash


local lz4 = {}

type Streamer = {
	Offset: number,
	Source: string,
	Length: number,
	IsFinished: boolean,
	LastUnreadBytes: number,

	read: (Streamer, len: number?, shiftOffset: boolean?) -> string,
	seek: (Streamer, len: number) -> (),
	append: (Streamer, newData: string) -> (),
	toEnd: (Streamer) -> ()
}

type BlockData = {
	[number]: {
		Literal: string,
		LiteralLength: number,
		MatchOffset: number?,
		MatchLength: number?
	}
}

local function plainFind(str, pat)
	return string.find(str, pat, 0, true)
end

local function streamer(str): Streamer
	local Stream = {}
	Stream.Offset = 0
	Stream.Source = str
	Stream.Length = string.len(str)
	Stream.IsFinished = false	
	Stream.LastUnreadBytes = 0

	function Stream.read(self: Streamer, len: number?, shift: boolean?): string
		local len = len or 1
		local shift = if shift ~= nil then shift else true
		local dat = string.sub(self.Source, self.Offset + 1, self.Offset + len)

		local dataLength = string.len(dat)
		local unreadBytes = len - dataLength

		if shift then
			self:seek(len)
		end

		self.LastUnreadBytes = unreadBytes
		return dat
	end

	function Stream.seek(self: Streamer, len: number)
		local len = len or 1

		self.Offset = math.clamp(self.Offset + len, 0, self.Length)
		self.IsFinished = self.Offset >= self.Length
	end

	function Stream.append(self: Streamer, newData: string)
		-- adds new data to the end of a stream
		self.Source ..= newData
		self.Length = string.len(self.Source)
		self:seek(0) --hacky but forces a recalculation of the isFinished flag
	end

	function Stream.toEnd(self: Streamer)
		self:seek(self.Length)
	end

	return Stream
end

function lz4.compress(str: string): string
	local blocks: BlockData = {}
	local iostream = streamer(str)

	if iostream.Length > 12 then
		local firstFour = iostream:read(4)

		local processed = firstFour
		local lit = firstFour
		local match = ""
		local LiteralPushValue = ""
		local pushToLiteral = true

		repeat
			pushToLiteral = true
			local nextByte = iostream:read()

			if plainFind(processed, nextByte) then
				local next3 = iostream:read(3, false)

				if string.len(next3) < 3 then
					--push bytes to literal block then break
					LiteralPushValue = nextByte .. next3
					iostream:seek(3)
				else
					match = nextByte .. next3

					local matchPos = plainFind(processed, match)
					if matchPos then
						iostream:seek(3)
						repeat
							local nextMatchByte = iostream:read(1, false)
							local newResult = match .. nextMatchByte

							local repos = plainFind(processed, newResult) 
							if repos then
								match = newResult
								matchPos = repos
								iostream:seek(1)
							end
						until not plainFind(processed, newResult) or iostream.IsFinished

						local matchLen = string.len(match)
						local pushMatch = true

						if iostream.Length - iostream.Offset <= 5 then
							LiteralPushValue = match
							pushMatch = false
							--better safe here, dont bother pushing to match ever
						end

						if pushMatch then
							pushToLiteral = false

							-- gets the position from the end of processed, then slaps it onto processed
							local realPosition = string.len(processed) - matchPos
							processed = processed .. match

							table.insert(blocks, {
								Literal = lit,
								LiteralLength = string.len(lit),
								MatchOffset = realPosition + 1,
								MatchLength = matchLen,
							})
							lit = ""
						end
					else
						LiteralPushValue = nextByte
					end
				end
			else
				LiteralPushValue = nextByte
			end

			if pushToLiteral then
				lit = lit .. LiteralPushValue
				processed = processed .. nextByte
			end
		until iostream.IsFinished
		table.insert(blocks, {
			Literal = lit,
			LiteralLength = string.len(lit)
		})
	else
		local str = iostream.Source
		blocks[1] = {
			Literal = str,
			LiteralLength = string.len(str)
		}
	end

	-- generate the output chunk
	-- %s is for adding header
	local output = string.rep("\x00", 4)
	local function write(char)
		output = output .. char
	end
	-- begin working through chunks
	for chunkNum, chunk in blocks do
		local litLen = chunk.LiteralLength
		local matLen = (chunk.MatchLength or 4) - 4

		-- create token
		local tokenLit = math.clamp(litLen, 0, 15)
		local tokenMat = math.clamp(matLen, 0, 15)

		local token = bit32.lshift(tokenLit, 4) + tokenMat
		write(string.pack("<I1", token))

		if litLen >= 15 then
			litLen = litLen - 15
			--begin packing extra bytes
			repeat
				local nextToken = math.clamp(litLen, 0, 0xFF)
				write(string.pack("<I1", nextToken))
				if nextToken == 0xFF then
					litLen = litLen - 255
				end
			until nextToken < 0xFF
		end

		-- push raw lit data
		write(chunk.Literal)

		if chunkNum ~= #blocks then
			-- push offset as u16
			write(string.pack("<I2", chunk.MatchOffset))

			-- pack extra match bytes
			if matLen >= 15 then
				matLen = matLen - 15

				repeat
					local nextToken = math.clamp(matLen, 0, 0xFF)
					write(string.pack("<I1", nextToken))
					if nextToken == 0xFF then
						matLen = matLen - 255
					end
				until nextToken < 0xFF
			end
		end
	end
	--append chunks
	local compLen = string.len(output) - 4
	local decompLen = iostream.Length

	return string.pack("<I4", compLen) .. string.pack("<I4", decompLen) .. output
end

function lz4.decompress(lz4data: string): string
	local inputStream = streamer(lz4data)

	local compressedLen = string.unpack("<I4", inputStream:read(4))
	local decompressedLen = string.unpack("<I4", inputStream:read(4))
	local reserved = string.unpack("<I4", inputStream:read(4))

	if compressedLen == 0 then
		return inputStream:read(decompressedLen)
	end

	local outputStream = streamer("")

	repeat
		local token = string.byte(inputStream:read())
		local litLen = bit32.rshift(token, 4)
		local matLen = bit32.band(token, 15) + 4

		if litLen >= 15 then
			repeat
				local nextByte = string.byte(inputStream:read())
				litLen += nextByte
			until nextByte ~= 0xFF
		end

		local literal = inputStream:read(litLen)
		outputStream:append(literal)
		outputStream:toEnd()
		if outputStream.Length < decompressedLen then
			--match
			local offset = string.unpack("<I2", inputStream:read(2))
			if matLen >= 19 then
				repeat
					local nextByte = string.byte(inputStream:read())
					matLen += nextByte
				until nextByte ~= 0xFF
			end

			outputStream:seek(-offset)
			local pos = outputStream.Offset
			local match = outputStream:read(matLen)
			local unreadBytes = outputStream.LastUnreadBytes
			local extra
			if unreadBytes then
				repeat
					outputStream.Offset = pos
					extra = outputStream:read(unreadBytes)
					unreadBytes = outputStream.LastUnreadBytes
					match ..= extra
				until unreadBytes <= 0
			end

			outputStream:append(match)
			outputStream:toEnd()
		end

	until outputStream.Length >= decompressedLen

	return outputStream.Source
end

getgenv().lz4compress = function(data)
	return lz4.compress(data)
end
local lz4compress = getgenv().lz4compress

getgenv().isreadonly = function(obj)
	if type(obj) ~= 'table' then
		return false
	end
	return table.isfrozen(obj)
end
local isreadonly = getgenv().isreadonly

local oldsm = setmetatable
local savedmts = {}
getgenv().setmetatable = function(taaable, metatable)
	local success, result = pcall(function() local result = oldsm(taaable, metatable) end)
	savedmts[taaable] = metatable
	if not success then error(result) end
	return taaable
end
local setmetatable = getgenv().setmetatable
getgenv().getrawmetatable = function(taaable)
	return savedmts[taaable]
end
local getrawmetatable = getgenv().getrawmetatable
getgenv().setrawmetatable = function(taaable, newmt)
	local currentmt = getgenv().getrawmetatable(taaable)
	table.foreach(newmt, function(key, value)
		currentmt[key] = value
	end)
	return taaable
end
local setrawmetatable = getgenv().setrawmetatable
getgenv().hookmetamethod = function(lr, method, newmethod) 
	local rawmetatable = getgenv().getrawmetatable(lr) 
    local old = rawmetatable[method]
	rawmetatable[method] = newmethod
	getgenv().setrawmetatable(lr, rawmetatable)
	return old
end
local hookmetamethod = getgenv().hookmetamethod

local renv = {
	print = print, warn = warn, error = error, shared = shared, assert = assert, collectgarbage = collectgarbage, require = require,
	select = select, tonumber = tonumber, tostring = tostring, type = type, xpcall = xpcall,
	pairs = pairs, next = next, ipairs = ipairs, newproxy = newproxy, rawequal = rawequal, rawget = rawget,
	rawset = rawset, rawlen = rawlen, gcinfo = gcinfo,

	coroutine = {
		create = coroutine.create, resume = coroutine.resume, running = coroutine.running,
		status = coroutine.status, wrap = coroutine.wrap, yield = coroutine.yield,
	},

	bit32 = {
		arshift = bit32.arshift, band = bit32.band, bnot = bit32.bnot, bor = bit32.bor, btest = bit32.btest,
		extract = bit32.extract, lshift = bit32.lshift, replace = bit32.replace, rshift = bit32.rshift, xor = bit32.xor,
	},

	math = {
		abs = math.abs, acos = math.acos, asin = math.asin, atan = math.atan, atan2 = math.atan2, ceil = math.ceil,
		cos = math.cos, cosh = math.cosh, deg = math.deg, exp = math.exp, floor = math.floor, fmod = math.fmod,
		frexp = math.frexp, ldexp = math.ldexp, log = math.log, log10 = math.log10, max = math.max, min = math.min,
		modf = math.modf, pow = math.pow, rad = math.rad, random = math.random, randomseed = math.randomseed,
		sin = math.sin, sinh = math.sinh, sqrt = math.sqrt, tan = math.tan, tanh = math.tanh
	},

	string = {
		byte = string.byte, char = string.char, find = string.find, format = string.format, gmatch = string.gmatch,
		gsub = string.gsub, len = string.len, lower = string.lower, match = string.match, pack = string.pack,
		packsize = string.packsize, rep = string.rep, reverse = string.reverse, sub = string.sub,
		unpack = string.unpack, upper = string.upper,
	},

	table = {
		concat = table.concat, insert = table.insert, pack = table.pack, remove = table.remove, sort = table.sort,
		unpack = table.unpack,
	},

	utf8 = {
		char = utf8.char, charpattern = utf8.charpattern, codepoint = utf8.codepoint, codes = utf8.codes,
		len = utf8.len, nfdnormalize = utf8.nfdnormalize, nfcnormalize = utf8.nfcnormalize,
	},

	os = {
		clock = os.clock, date = os.date, difftime = os.difftime, time = os.time,
	},

	delay = delay, elapsedTime = elapsedTime, spawn = spawn, tick = tick, time = time, typeof = typeof,
	UserSettings = UserSettings, version = version, wait = wait, _VERSION = _VERSION,

	task = {
		defer = task.defer, delay = task.delay, spawn = task.spawn, wait = task.wait,
	},

	debug = {
		traceback = debug.traceback, profilebegin = debug.profilebegin, profileend = debug.profileend, info = debug.info 
	},

	game = game, workspace = workspace, Game = game, Workspace = workspace,

	getmetatable = getmetatable, setmetatable = setmetatable
}

getgenv().getrenv = function()
	return renv 
end 
local getrenv = getgenv().getrenv

getgenv().request = function(args)
	local Body = nil
	local Timeout = 0
	local function callback(success, body)
	    Body = body
	    Body['Success'] = success
	end
	httpserv:RequestInternal(args):Start(callback)
	while not Body and Timeout < 10 do
	    task.wait(.1)
	    Timeout = Timeout + .1
	end
	return Body
end
local request = getgenv().request

local Queue = {}
Queue.__index = Queue
function Queue.new()
	local self = setmetatable({}, Queue)
	self.elements = {}
	return self
end

local ClipboardQueue = Queue.new()
function Queue:IsEmpty()
    return #self.elements == 0
end
function Queue:Queue(element)
    table.insert(self.elements, element)
end
function Queue:Current()
    return self.elements
end
local vim = Instance.new("VirtualInputManager")
getgenv().mouse1click = function(x, y)
	x = x or 0
	y = y or 0
	vim:SendMouseButtonEvent(x, y, 0, true, game, false)
	task.wait()
	vim:SendMouseButtonEvent(x, y, 0, false, game, false)
end
local mouse1click = getgenv().mouse1click
getgenv().mouse2click = function(x, y)
	x = x or 0
	y = y or 0
	vim:SendMouseButtonEvent(x, y, 1, true, game, false)
	task.wait()
	vim:SendMouseButtonEvent(x, y, 1, false, game, false)
end
local mouse2click = getgenv().mouse2click
getgenv().mouse1press = function(x, y)
	x = x or 0
	y = y or 0
	vim:SendMouseButtonEvent(x, y, 0, true, game, false)
end
local mouse1press = getgenv().mouse1press
getgenv().mouse1release = function(x, y)
	x = x or 0
	y = y or 0
	vim:SendMouseButtonEvent(x, y, 0, false, game, false)
end
local mouse1release = getgenv().mouse1release
getgenv().mouse2press = function(x, y)
	x = x or 0
	y = y or 0
	vim:SendMouseButtonEvent(x, y, 1, true, game, false)
end
local mouse2press = getgenv().mouse2press
getgenv().mouse2release = function(x, y)
	x = x or 0
	y = y or 0
	vim:SendMouseButtonEvent(x, y, 1, false, game, false)
end
local mouse2release = getgenv().mouse2release
getgenv().mousescroll = function(x, y, a)
	x = x or 0
	y = y or 0
	a = a and true or false
	vim:SendMouseWheelEvent(x, y, a, game)
end
local mousescroll = getgenv().mousescroll
getgenv().keyclick = function(key)
	if typeof(key) == 'number' then
		if not keys[key] then return error("Key "..tostring(key) .. ' not found!') end
		vim:SendKeyEvent(true, keys[key], false, game)
		task.wait()
		vim:SendKeyEvent(false, keys[key], false, game)
	elseif typeof(Key) == 'EnumItem' then
		vim:SendKeyEvent(true, key, false, game)
		task.wait()
		vim:SendKeyEvent(false, key, false, game)
	end
end
local keyclick = getgenv().keyclick
getgenv().keypress = function(key)
	if typeof(key) == 'number' then
		if not keys[key] then return error("Key "..tostring(key) .. ' not found!') end
		vim:SendKeyEvent(true, keys[key], false, game)
	elseif typeof(Key) == 'EnumItem' then
		vim:SendKeyEvent(true, key, false, game)
	end
end
local keypress = getgenv().keypress
getgenv().keyrelease = function(key)
	if typeof(key) == 'number' then
		if not keys[key] then return error("Key "..tostring(key) .. ' not found!') end
		vim:SendKeyEvent(false, keys[key], false, game)
	elseif typeof(Key) == 'EnumItem' then
		vim:SendKeyEvent(false, key, false, game)
	end
end
local keyrelease = getgenv().keyrelease
getgenv().mousemoverel = function(relx, rely)
	local Pos = workspace.CurrentCamera.ViewportSize
	relx = relx or 0
	rely = rely or 0
	local x = Pos.X * relx
	local y = Pos.Y * rely
	vim:SendMouseMoveEvent(x, y, game)
end
local mousemoverel = getgenv().mousemoverel
getgenv().mousemoveabs = function(x, y)
	x = x or 0 y = y or 0
	vim:SendMouseMoveEvent(x, y, game)
end
local mousemoveabs = getgenv().mousemoveabs

getgenv().getcallingscript = function()
	local Source = debug.info(1, 's')
	for i, v in next, game:GetDescendants() do if v:GetFullName() == Source then return v end end
end 
local getcallingscript = getgenv().getcallingscript
local ClipboardUI = Instance.new("ScreenGui")
local ClipboardBox = Instance.new('TextBox', ClipboardUI) 
ClipboardBox.Position = UDim2.new(100, 0, 100, 0) 
getgenv().setclipboard = function(data)
	repeat task.wait() until ClipboardQueue:Current()[1] == data or ClipboardQueue:IsEmpty()
	ClipboardQueue:Queue(data)
	local old = game:GetService("UserInputService"):GetFocusedTextBox()
	local copy = ClipboardQueue:Current()[1]
	ClipboardBox:CaptureFocus()
	ClipboardBox.Text = copy

	local KeyCode = Enum.KeyCode
	local Keys = {KeyCode.RightControl, KeyCode.A}
	local Keys2 = {KeyCode.RightControl, KeyCode.C, KeyCode.V}

	for _, v in ipairs(Keys) do
		vim:SendKeyEvent(true, v, false, game)
		task.wait()
	end
	for _, v in ipairs(Keys) do
		vim:SendKeyEvent(false, v, false, game)
		task.wait()
	end
	for _, v in ipairs(Keys2) do
		vim:SendKeyEvent(true, v, false, game)
		task.wait()
	end
	for _, v in ipairs(Keys2) do
		vim:SendKeyEvent(false, v, false, game)
		task.wait()
	end
	ClipboardBox.Text = ''
	if old then old:CaptureFocus() end
	task.wait(.18)
	ClipboardQueue:Update()
end
local setclipboard = getgenv().setclipboard
getgenv().toclipboard = getgenv().setclipboard
local toclipboard = getgenv().toclipboard
getgenv().writeclipboard = getgenv().setclipboard
local writeclipboard = getgenv().writeclipboard
getgenv().setrbxclipboard = getgenv().setclipboard
local setrbxclipboard = getgenv().setrbxclipboard

getgenv().lz4decompress = function(compressed_data)
	return lz4.decompress(compressed_data)
end
local lz4decompress = getgenv().lz4decompress

local hiddenprs = {} 
getgenv().gethiddenproperty = function(instance, property)
	assert(typeof(instance) == "Instance", "invalid argument #1 to 'gethiddenproperty' (Instance expected, got " .. typeof(instance) .. ")", 2)
	local instanceprops = hiddenprs[instance]
	if instanceprops and instanceprops[property] then
		return instanceprops[property], true
	end
	local success, result = pcall(function()
		return instance[property]
	end)
	if success then return result, false end
	success, result = pcall(function()
		return game:GetService("UGCValidationService"):GetPropertyValue(instance, property)
	end)
	if success then return result, true end
end
local gethiddenproperty = getgenv().gethiddenproperty
getgenv().sethiddenproperty = function(instance, property, value)
	hiddenprs[instance] = hiddenprs[instance] or {}
	hiddenprs[instance][property] = value
	return true
end
local sethiddenproperty = getgenv().sethiddenproperty

getgenv().cloneref = function(ref)
	if game:FindFirstChild(ref.Name) or ref.Parent == game then 
		return ref
	else
		local class = ref.ClassName
		pcall(function()
			local cloned = Instance.new(class)
		end)
		local mt = {
			__index = ref,
			__newindex = function(t, k, v)

				if k == "Name" then
					ref.Name = v
				end
				rawset(t, k, v)
			end
		}
		local proxy = setmetatable({}, mt)
		return proxy
	end
end
local cloneref = getgenv().cloneref
getgenv().compareinstances = function(x, y)
	return type(getmetatable(y)) == "table" and x.ClassName == y.ClassName
end
local compareinstances = getgenv().compareinstances

--qui drawing lib
local coreGui = game:GetService("CoreGui")
-- objects
local camera = workspace.CurrentCamera
local drawingUI = Instance.new("ScreenGui")
drawingUI.Name = "Drawing"
drawingUI.IgnoreGuiInset = true
drawingUI.DisplayOrder = 0x7fffffff
drawingUI.Parent = coreGui
-- variables
local drawingIndex = 0
local uiStrokes = table.create(0)
local baseDrawingObj = setmetatable({
	Visible = true,
	ZIndex = 0,
	Transparency = 1,
	Color = Color3.new(),
	Remove = function(self)
		setmetatable(self, nil)
	end,
	Destroy = function(self)
		setmetatable(self, nil)
	end
}, {
	__add = function(t1, t2)
		local result = table.clone(t1)
		for index, value in t2 do
			result[index] = value
		end
		return result
	end
})
local drawingFontsEnum = {
	[0] = Font.fromEnum(Enum.Font.Roboto),
	[1] = Font.fromEnum(Enum.Font.Legacy),
	[2] = Font.fromEnum(Enum.Font.SourceSans),
	[3] = Font.fromEnum(Enum.Font.RobotoMono),
}
-- function
local function getFontFromIndex(fontIndex: number): Font
	return drawingFontsEnum[fontIndex]
end
local function convertTransparency(transparency: number): number
	return math.clamp(1 - transparency, 0, 1)
end
-- main
local DrawingLib = {}
DrawingLib.Fonts = {
	["UI"] = 0,
	["System"] = 1,
	["Plex"] = 2,
	["Monospace"] = 3
}
function DrawingLib.new(drawingType)
	drawingIndex += 1
	if drawingType == "Line" then
		local lineObj = ({
			From = Vector2.zero,
			To = Vector2.zero,
			Thickness = 1
		} + baseDrawingObj)
		local lineFrame = Instance.new("Frame")
		lineFrame.Name = drawingIndex
		lineFrame.AnchorPoint = (Vector2.one * .5)
		lineFrame.BorderSizePixel = 0
		lineFrame.BackgroundColor3 = lineObj.Color
		lineFrame.Visible = lineObj.Visible
		lineFrame.ZIndex = lineObj.ZIndex
		lineFrame.BackgroundTransparency = convertTransparency(lineObj.Transparency)
		lineFrame.Size = UDim2.new()
		lineFrame.Parent = drawingUI
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(lineObj[index]) == "nil" then return end
				if index == "From" then
					local direction = (lineObj.To - value)
					local center = (lineObj.To + value) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))
					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "To" then
					local direction = (value - lineObj.From)
					local center = (value + lineObj.From) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))
					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "Thickness" then
					local distance = (lineObj.To - lineObj.From).Magnitude
					lineFrame.Size = UDim2.fromOffset(distance, value)
				elseif index == "Visible" then
					lineFrame.Visible = value
				elseif index == "ZIndex" then
					lineFrame.ZIndex = value
				elseif index == "Transparency" then
					lineFrame.BackgroundTransparency = convertTransparency(value)
				elseif index == "Color" then
					lineFrame.BackgroundColor3 = value
				end
				lineObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						lineFrame:Destroy()
						lineObj.Remove(self)
						return lineObj:Remove()
					end
				end
				return lineObj[index]
			end,
			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Text" then
		local textObj = ({
			Text = "",
			Font = DrawingLib.Fonts.UI,
			Size = 0,
			Position = Vector2.zero,
			Center = false,
			Outline = false,
			OutlineColor = Color3.new()
		} + baseDrawingObj)
		local textLabel, uiStroke = Instance.new("TextLabel"), Instance.new("UIStroke")
		textLabel.Name = drawingIndex
		textLabel.AnchorPoint = (Vector2.one * .5)
		textLabel.BorderSizePixel = 0
		textLabel.BackgroundTransparency = 1
		textLabel.Visible = textObj.Visible
		textLabel.TextColor3 = textObj.Color
		textLabel.TextTransparency = convertTransparency(textObj.Transparency)
		textLabel.ZIndex = textObj.ZIndex
		textLabel.FontFace = getFontFromIndex(textObj.Font)
		textLabel.TextSize = textObj.Size
		textLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
			local textBounds = textLabel.TextBounds
			local offset = textBounds / 2
			textLabel.Size = UDim2.fromOffset(textBounds.X, textBounds.Y)
			textLabel.Position = UDim2.fromOffset(textObj.Position.X + (if not textObj.Center then offset.X else 0), textObj.Position.Y + offset.Y)
		end)
		uiStroke.Thickness = 1
		uiStroke.Enabled = textObj.Outline
		uiStroke.Color = textObj.Color
		textLabel.Parent, uiStroke.Parent = drawingUI, textLabel
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(textObj[index]) == "nil" then return end
				if index == "Text" then
					textLabel.Text = value
				elseif index == "Font" then
					value = math.clamp(value, 0, 3)
					textLabel.FontFace = getFontFromIndex(value)
				elseif index == "Size" then
					textLabel.TextSize = value
				elseif index == "Position" then
					local offset = textLabel.TextBounds / 2
					textLabel.Position = UDim2.fromOffset(value.X + (if not textObj.Center then offset.X else 0), value.Y + offset.Y)
				elseif index == "Center" then
					local position = (
						if value then
							camera.ViewportSize / 2
							else
							textObj.Position
					)
					textLabel.Position = UDim2.fromOffset(position.X, position.Y)
				elseif index == "Outline" then
					uiStroke.Enabled = value
				elseif index == "OutlineColor" then
					uiStroke.Color = value
				elseif index == "Visible" then
					textLabel.Visible = value
				elseif index == "ZIndex" then
					textLabel.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)
					textLabel.TextTransparency = transparency
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					textLabel.TextColor3 = value
				end
				textObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						textLabel:Destroy()
						textObj.Remove(self)
						return textObj:Remove()
					end
				elseif index == "TextBounds" then
					return textLabel.TextBounds
				end
				return textObj[index]
			end,
			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Circle" then
		local circleObj = ({
			Radius = 150,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)
		local circleFrame, uiCorner, uiStroke = Instance.new("Frame"), Instance.new("UICorner"), Instance.new("UIStroke")
		circleFrame.Name = drawingIndex
		circleFrame.AnchorPoint = (Vector2.one * .5)
		circleFrame.BorderSizePixel = 0
		circleFrame.BackgroundTransparency = (if circleObj.Filled then convertTransparency(circleObj.Transparency) else 1)
		circleFrame.BackgroundColor3 = circleObj.Color
		circleFrame.Visible = circleObj.Visible
		circleFrame.ZIndex = circleObj.ZIndex
		uiCorner.CornerRadius = UDim.new(1, 0)
		circleFrame.Size = UDim2.fromOffset(circleObj.Radius, circleObj.Radius)
		uiStroke.Thickness = circleObj.Thickness
		uiStroke.Enabled = not circleObj.Filled
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		circleFrame.Parent, uiCorner.Parent, uiStroke.Parent = drawingUI, circleFrame, circleFrame
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(circleObj[index]) == "nil" then return end
				if index == "Radius" then
					local radius = value * 2
					circleFrame.Size = UDim2.fromOffset(radius, radius)
				elseif index == "Position" then
					circleFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, .6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					circleFrame.BackgroundTransparency = (if value then convertTransparency(circleObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					circleFrame.Visible = value
				elseif index == "ZIndex" then
					circleFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)
					circleFrame.BackgroundTransparency = (if circleObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					circleFrame.BackgroundColor3 = value
					uiStroke.Color = value
				end
				circleObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						circleFrame:Destroy()
						circleObj.Remove(self)
						return circleObj:Remove()
					end
				end
				return circleObj[index]
			end,
			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Square" then
		local squareObj = ({
			Size = Vector2.zero,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)
		local squareFrame, uiStroke = Instance.new("Frame"), Instance.new("UIStroke")
		squareFrame.Name = drawingIndex
		squareFrame.BorderSizePixel = 0
		squareFrame.BackgroundTransparency = (if squareObj.Filled then convertTransparency(squareObj.Transparency) else 1)
		squareFrame.ZIndex = squareObj.ZIndex
		squareFrame.BackgroundColor3 = squareObj.Color
		squareFrame.Visible = squareObj.Visible
		uiStroke.Thickness = squareObj.Thickness
		uiStroke.Enabled = not squareObj.Filled
		uiStroke.LineJoinMode = Enum.LineJoinMode.Miter
		squareFrame.Parent, uiStroke.Parent = drawingUI, squareFrame
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(squareObj[index]) == "nil" then return end
				if index == "Size" then
					squareFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					squareFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, 0.6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					squareFrame.BackgroundTransparency = (if value then convertTransparency(squareObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					squareFrame.Visible = value
				elseif index == "ZIndex" then
					squareFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)
					squareFrame.BackgroundTransparency = (if squareObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					uiStroke.Color = value
					squareFrame.BackgroundColor3 = value
				end
				squareObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						squareFrame:Destroy()
						squareObj.Remove(self)
						return squareObj:Remove()
					end
				end
				return squareObj[index]
			end,
			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Image" then
		local imageObj = ({
			Data = "",
			DataURL = "rbxassetid://0",
			Size = Vector2.zero,
			Position = Vector2.zero
		} + baseDrawingObj)
		local imageFrame = Instance.new("ImageLabel")
		imageFrame.Name = drawingIndex
		imageFrame.BorderSizePixel = 0
		imageFrame.ScaleType = Enum.ScaleType.Stretch
		imageFrame.BackgroundTransparency = 1
		imageFrame.Visible = imageObj.Visible
		imageFrame.ZIndex = imageObj.ZIndex
		imageFrame.ImageTransparency = convertTransparency(imageObj.Transparency)
		imageFrame.ImageColor3 = imageObj.Color
		imageFrame.Parent = drawingUI
		return setmetatable(table.create(0), {
			__newindex = function(_, index, value)
				if typeof(imageObj[index]) == "nil" then return end
				if index == "Data" then
					-- later
				elseif index == "DataURL" then -- temporary property
					imageFrame.Image = value
				elseif index == "Size" then
					imageFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					imageFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Visible" then
					imageFrame.Visible = value
				elseif index == "ZIndex" then
					imageFrame.ZIndex = value
				elseif index == "Transparency" then
					imageFrame.ImageTransparency = convertTransparency(value)
				elseif index == "Color" then
					imageFrame.ImageColor3 = value
				end
				imageObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						imageFrame:Destroy()
						imageObj.Remove(self)
						return imageObj:Remove()
					end
				elseif index == "Data" then
					return nil -- TODO: add error here
				end
				return imageObj[index]
			end,
			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Quad" then
		local QuadProperties = ({
			Thickness = 1,
			PointA = Vector2.new();
			PointB = Vector2.new();
			PointC = Vector2.new();
			PointD = Vector2.new();
			Filled = false;
		}  + baseDrawingObj);
		PointA = DrawingLib.new("Line")
		PointB = DrawingLib.new("Line")
		PointC = DrawingLib.new("Line")
		PointD = DrawingLib.new("Line")
		return setmetatable({}, {
			__newindex = (function(self, Property, Value)
				if Property == "Thickness" then
					PointA.Thickness = Value
					PointB.Thickness = Value
					PointC.Thickness = Value
					PointD.Thickness = Value
				end
				if Property == "PointA" then
					PointA.From = Value
					PointB.To = Value
				end
				if Property == "PointB" then
					PointB.From = Value
					PointC.To = Value
				end
				if Property == "PointC" then
					PointC.From = Value
					PointD.To = Value
				end
				if Property == "PointD" then
					PointD.From = Value
					PointA.To = Value
				end
				if Property == "Visible" then 
					PointA.Visible = true
					PointB.Visible = true
					PointC.Visible = true
					PointD.Visible = true    
				end
				if Property == "Filled" then
					-- i'll do this later
				end
				if Property == "Color" then
					PointA.Color = Value
					PointB.Color = Value
					PointC.Color = Value
					PointD.Color = Value
				end
				if (Property == "ZIndex") then
					PointA.ZIndex = Value
					PointB.ZIndex = Value
					PointC.ZIndex = Value
					PointD.ZIndex = Value
				end
			end),
			__index = (function(self, Property)
				if (string.lower(tostring(Property)) == "remove") then
					return (function()
						PointA:Remove();
						PointB:Remove();
						PointC:Remove();
						PointD:Remove();
					end)
				end
				return QuadProperties[Property]
			end)
		});
	elseif drawingType == "Triangle" then
		local triangleObj = ({
			PointA = Vector2.zero,
			PointB = Vector2.zero,
			PointC = Vector2.zero,
			Thickness = 1,
			Filled = false
		} + baseDrawingObj)
		local _linePoints = table.create(0)
		_linePoints.A = DrawingLib.new("Line")
		_linePoints.B = DrawingLib.new("Line")
		_linePoints.C = DrawingLib.new("Line")
		return setmetatable(table.create(0), {
			__tostring = function() return "Drawing" end,
			__newindex = function(_, index, value)
				if typeof(triangleObj[index]) == "nil" then return end
				if index == "PointA" then
					_linePoints.A.From = value
					_linePoints.B.To = value
				elseif index == "PointB" then
					_linePoints.B.From = value
					_linePoints.C.To = value
				elseif index == "PointC" then
					_linePoints.C.From = value
					_linePoints.A.To = value
				elseif (index == "Thickness" or index == "Visible" or index == "Color" or index == "ZIndex") then
					for _, linePoint in _linePoints do
						linePoint[index] = value
					end
				elseif index == "Filled" then
					-- later
				end
				triangleObj[index] = value
			end,
			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						for _, linePoint in _linePoints do
							linePoint:Remove()
						end
						triangleObj.Remove(self)
						return triangleObj:Remove()
					end
				end
				return triangleObj[index]
			end,
		})
	end
end
getgenv().isrenderobj = function(obj)
    local metatable = getmetatable(obj)
    if not metatable then return false end
    if type(metatable.__tostring) ~= "function" then return false end
    if metatable.__tostring() ~= "Drawing" then return false end
    if type(obj.Visible) ~= "boolean" then return false end
    if type(obj.Remove) ~= "function" then return false end
    return true
end
local isrenderobj = getgenv().isrenderobj

getgenv().getrenderproperty = function(obj, property)
    if isrenderobj(obj) then
        return obj[property]
    end
    return nil
end
local getrenderproperty = getgenv().getrenderproperty

getgenv().cleardrawcache = function()
    for _, child in pairs(drawingUI:GetChildren()) do
        child:Destroy()
    end
end
local cleardrawcache = getgenv().cleardrawcache

getgenv().setrenderproperty = function(obj, property, value)
    if isrenderobj(obj) then
        obj[property] = value
    end
end
local setrenderproperty = getgenv().setrenderproperty
getgenv().Drawing = DrawingLib
local Drawing = getgenv().Drawing

getgenv().messagebox = function(text, caption, flags) --sorta
	print(flags) -- no i am NOT doing every flag im too lazy so uhhh yes. 
	local Converted = {
		["_MessageBox"] = Instance.new("ScreenGui");
		["_Background"] = Instance.new("Frame");
		["_UICorner"] = Instance.new("UICorner");
		["_DropShadowHolder"] = Instance.new("Frame");
		["_DropShadow"] = Instance.new("ImageLabel");
		["_PanelUP"] = Instance.new("Frame");
		["_UICorner1"] = Instance.new("UICorner");
		["_Caption"] = Instance.new("TextLabel");
		["_Close"] = Instance.new("ImageButton");
		["_LocalScript"] = Instance.new("LocalScript");
		["_PanelDOWN"] = Instance.new("Frame");
		["_UICorner2"] = Instance.new("UICorner");
		["_OK"] = Instance.new("TextButton");
		["_UICorner3"] = Instance.new("UICorner");
		["_LocalScript1"] = Instance.new("LocalScript");
		["_Cancel"] = Instance.new("TextButton");
		["_UICorner4"] = Instance.new("UICorner");
		["_LocalScript2"] = Instance.new("LocalScript");
		["_Text"] = Instance.new("TextLabel");
	}

	Converted["_MessageBox"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Converted["_MessageBox"].Name = "MessageBox"
	Converted["_MessageBox"].Parent = game:GetService("CoreGui")

	Converted["_Background"].BackgroundColor3 = Color3.fromRGB(53.000004440546036, 53.000004440546036, 53.000004440546036)
	Converted["_Background"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_Background"].BorderSizePixel = 0
	Converted["_Background"].Position = UDim2.new(0.435079724, 0, 0.375545859, 0)
	Converted["_Background"].Size = UDim2.new(0.220956713, 0, 0.20960699, 0)
	Converted["_Background"].Name = "Background"
	Converted["_Background"].Parent = Converted["_MessageBox"]
	Converted["_Background"].Active = true 
	Converted["_Background"].Draggable = true 

	Converted["_UICorner"].Parent = Converted["_Background"]

	Converted["_DropShadowHolder"].BackgroundTransparency = 1
	Converted["_DropShadowHolder"].BorderSizePixel = 0
	Converted["_DropShadowHolder"].Size = UDim2.new(1, 0, 1, 0)
	Converted["_DropShadowHolder"].ZIndex = 0
	Converted["_DropShadowHolder"].Name = "DropShadowHolder"
	Converted["_DropShadowHolder"].Parent = Converted["_Background"]

	Converted["_DropShadow"].Image = "rbxassetid://6014261993"
	Converted["_DropShadow"].ImageColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_DropShadow"].ImageTransparency = 0.5
	Converted["_DropShadow"].ScaleType = Enum.ScaleType.Slice
	Converted["_DropShadow"].SliceCenter = Rect.new(49, 49, 450, 450)
	Converted["_DropShadow"].AnchorPoint = Vector2.new(0.5, 0.5)
	Converted["_DropShadow"].BackgroundTransparency = 1
	Converted["_DropShadow"].BorderSizePixel = 0
	Converted["_DropShadow"].Position = UDim2.new(0.5, 0, 0.5, 0)
	Converted["_DropShadow"].Size = UDim2.new(1.16151202, 0, 1.32638884, 0)
	Converted["_DropShadow"].ZIndex = 0
	Converted["_DropShadow"].Name = "DropShadow"
	Converted["_DropShadow"].Parent = Converted["_DropShadowHolder"]

	Converted["_PanelUP"].BackgroundColor3 = Color3.fromRGB(40.00000141561031, 40.00000141561031, 40.00000141561031)
	Converted["_PanelUP"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_PanelUP"].BorderSizePixel = 0
	Converted["_PanelUP"].Size = UDim2.new(1, 0, 0.180555552, 0)
	Converted["_PanelUP"].Name = "PanelUP"
	Converted["_PanelUP"].Parent = Converted["_Background"]

	Converted["_UICorner1"].Parent = Converted["_PanelUP"]

	Converted["_Caption"].Font = Enum.Font.SourceSans
	Converted["_Caption"].Text = caption
	Converted["_Caption"].TextColor3 = Color3.fromRGB(102.00000911951065, 102.00000911951065, 102.00000911951065)
	Converted["_Caption"].TextSize = 14
	Converted["_Caption"].TextXAlignment = Enum.TextXAlignment.Left
	Converted["_Caption"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Converted["_Caption"].BackgroundTransparency = 1
	Converted["_Caption"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_Caption"].BorderSizePixel = 0
	Converted["_Caption"].Position = UDim2.new(0.0274914093, 0, 0, 0)
	Converted["_Caption"].Size = UDim2.new(0.859106541, 0, 1, 0)
	Converted["_Caption"].Name = "Caption"
	Converted["_Caption"].Parent = Converted["_PanelUP"]

	Converted["_Close"].Image = "rbxassetid://6031094677"
	Converted["_Close"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Converted["_Close"].BackgroundTransparency = 1
	Converted["_Close"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_Close"].BorderSizePixel = 0
	Converted["_Close"].Position = UDim2.new(0.910652936, 0, 0.115384616, 0)
	Converted["_Close"].Size = UDim2.new(0.0687285215, 0, 0.769230783, 0)
	Converted["_Close"].Name = "Close"
	Converted["_Close"].Parent = Converted["_PanelUP"]

	Converted["_PanelDOWN"].BackgroundColor3 = Color3.fromRGB(40.00000141561031, 40.00000141561031, 40.00000141561031)
	Converted["_PanelDOWN"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_PanelDOWN"].BorderSizePixel = 0
	Converted["_PanelDOWN"].Position = UDim2.new(0, 0, 0.652777791, 0)
	Converted["_PanelDOWN"].Size = UDim2.new(1, 0, 0.347222209, 0)
	Converted["_PanelDOWN"].Name = "PanelDOWN"
	Converted["_PanelDOWN"].Parent = Converted["_Background"]

	Converted["_UICorner2"].Parent = Converted["_PanelDOWN"]

	Converted["_OK"].Font = Enum.Font.SourceSans
	Converted["_OK"].Text = "Ok"
	Converted["_OK"].TextColor3 = Color3.fromRGB(61.00000396370888, 61.00000396370888, 61.00000396370888)
	Converted["_OK"].TextSize = 14
	Converted["_OK"].BackgroundColor3 = Color3.fromRGB(25.000002309679985, 25.000002309679985, 25.000002309679985)
	Converted["_OK"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_OK"].BorderSizePixel = 0
	Converted["_OK"].Position = UDim2.new(0.0721649453, 0, 0.100000001, 0)
	Converted["_OK"].Size = UDim2.new(0.371134013, 0, 0.779999971, 0)
	Converted["_OK"].Name = "OK"
	Converted["_OK"].Parent = Converted["_PanelDOWN"]

	Converted["_UICorner3"].Parent = Converted["_OK"]

	Converted["_Cancel"].Font = Enum.Font.SourceSans
	Converted["_Cancel"].Text = "Cancel"
	Converted["_Cancel"].TextColor3 = Color3.fromRGB(61.00000396370888, 61.00000396370888, 61.00000396370888)
	Converted["_Cancel"].TextSize = 14
	Converted["_Cancel"].BackgroundColor3 = Color3.fromRGB(25.000002309679985, 25.000002309679985, 25.000002309679985)
	Converted["_Cancel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_Cancel"].BorderSizePixel = 0
	Converted["_Cancel"].Position = UDim2.new(0.560137451, 0, 0.100000001, 0)
	Converted["_Cancel"].Size = UDim2.new(0.371134013, 0, 0.779999971, 0)
	Converted["_Cancel"].Name = "Cancel"
	Converted["_Cancel"].Parent = Converted["_PanelDOWN"]

	Converted["_UICorner4"].Parent = Converted["_Cancel"]

	Converted["_Text"].Font = Enum.Font.SourceSans
	Converted["_Text"].Text = text
	Converted["_Text"].TextColor3 = Color3.fromRGB(255, 255, 255)
	Converted["_Text"].TextSize = 14
	Converted["_Text"].TextXAlignment = Enum.TextXAlignment.Left
	Converted["_Text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Converted["_Text"].BackgroundTransparency = 1
	Converted["_Text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Converted["_Text"].BorderSizePixel = 0
	Converted["_Text"].Position = UDim2.new(0.0274914093, 0, 0.180555552, 0)
	Converted["_Text"].Size = UDim2.new(0.951890051, 0, 0.472222209, 0)
	Converted["_Text"].Name = "Text"
	Converted["_Text"].Parent = Converted["_Background"]

	local fake_module_scripts = {}

	local function CUAUOSG_fake_script() 
		local script = Instance.new("LocalScript")
		script.Name = "LocalScript"
		script.Parent = Converted["_Close"]
		local req = require
		local require = function(obj)
			local fake = fake_module_scripts[obj]
			if fake then
				return fake()
			end
			return req(obj)
		end

		local messagebox = script.Parent.Parent.Parent.Parent 
		local close = script.Parent
		local proceed = false 
		close.MouseButton1Click:Connect(function()
			print(proceed)
			messagebox:Destroy()
		end)
	end
	local function GZGQI_fake_script() 
		local script = Instance.new("LocalScript")
		script.Name = "LocalScript"
		script.Parent = Converted["_OK"]
		local req = require
		local require = function(obj)
			local fake = fake_module_scripts[obj]
			if fake then
				return fake()
			end
			return req(obj)
		end

		local ok = script.Parent 
		local messagebox = script.Parent.Parent.Parent.Parent 
		local proceed = false
		ok.MouseButton1Click:Connect(function()
			proceed = true 
			print(proceed)
			messagebox:Destroy()
		end)
	end
	local function QGPMPA_fake_script() 
		local script = Instance.new("LocalScript")
		script.Name = "LocalScript"
		script.Parent = Converted["_Cancel"]
		local req = require
		local require = function(obj)
			local fake = fake_module_scripts[obj]
			if fake then
				return fake()
			end
			return req(obj)
		end

		local cancel = script.Parent 
		local messagebox = script.Parent.Parent.Parent.Parent 
		local proceed = false
		cancel.MouseButton1Click:Connect(function()
			print(proceed)
			messagebox:Destroy()
		end)
	end

	coroutine.wrap(CUAUOSG_fake_script)()
	coroutine.wrap(GZGQI_fake_script)()
	coroutine.wrap(QGPMPA_fake_script)()
end
local messagebox = getgenv().messagebox


function check(funcName: string, func, testfunc)
    local success, err = pcall(function()
        getgenv()[funcName] = func
    end)
end

check("getping", function(suffix: boolean)
    local rawping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local pingstr = rawping:sub(1, #rawping - 7)
    local pingnum = tonumber(pingstr)
    local ping = tostring(math.round(pingnum))
    return not suffix and ping or ping .. " ms"
end, function()
    local ping = getgenv().getping()
    assert(tonumber(ping) ~= nil, "getping function test failed")
end)
getgenv().clonefunction = function(func)
    local newfunc = function(...)
        return func(...)
    end
    setfenv(newfunc, getfenv(func))
    return newfunc
end
check("getfps", function(): number
    local RunService = game:GetService("RunService")
    local FPS: number
    local TimeFunction = RunService:IsRunning() and time or os.clock

    local LastIteration: number, Start: number
    local FrameUpdateTable = {}

    local function HeartbeatUpdate()
        LastIteration = TimeFunction()
        for Index = #FrameUpdateTable, 1, -1 do
            FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
        end

        FrameUpdateTable[1] = LastIteration
        FPS = TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start)
    end

    Start = TimeFunction()
    RunService.Heartbeat:Connect(HeartbeatUpdate)
    task.wait(1.1)
    return FPS
end, function()
    local fps = getgenv().getfps()
    assert(fps ~= nil and fps >= 0, "getfps function test failed")
end)

check("getaffiliateid", function()
    return "moREnc"
end, function()
    assert(getgenv().getaffiliateid() == "moREnc", "getaffiliateid function test failed")
end)

check("getplayer", function(name: string)
    return not name and getgenv().getplayers()["LocalPlayer"] or getgenv().getplayers()[name]
end)

check("getplayers", function()
    local players = {}
    for _, x in pairs(game:GetService("Players"):GetPlayers()) do
        players[x.Name] = x
    end
    players["LocalPlayer"] = game:GetService("Players").LocalPlayer
    return players
end, function()
    assert(getgenv().getplayers()["LocalPlayer"] == game:GetService("Players").LocalPlayer, "getplayers function test failed")
end)

check("getlocalplayer", function(): Player
    return getgenv().getplayer()
end, function()
    assert(getgenv().getlocalplayer() == game:GetService("Players").LocalPlayer, "getlocalplayer function test failed")
end)

check("customprint", function(text: string, properties: table, imageId: rbxasset)
    print(text)
    task.wait(0.025)
    local clientLog = game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog
    local childrenCount = #clientLog:GetChildren()
    local msgIndex = childrenCount > 0 and childrenCount - 1 or 0
    local msg = clientLog:FindFirstChild(tostring(msgIndex))

    if msg then
        for i, x in pairs(properties) do
            msg[i] = x
        end
        if imageId then
            msg.Parent.image.Image = imageId
        end
    end
end)

check("join", function(placeID: number, jobID: string)
    game:GetService("TeleportService"):TeleportToPlaceInstance(placeID, jobID, getplayer())
end)

check("firesignal", function(instance: Instance, signalName: string, args: any)
    if instance and signalName then
        local signal = instance[signalName]
        if signal then
            for _, connection in ipairs(getconnections(signal)) do
                if args then
                    connection:Fire(args)
                else
                    connection:Fire()
                end
            end
        end
    end
end, function()
    local button = Instance.new("TextButton")
    local new = true
    button.MouseButton1Click:Connect(function() new = false end) 
    firesignal(button.MouseButton1Click)
    assert(new, "Uses old standard")
    firesignal(button, "MouseButton1Click")
end)

check("firetouchinterest", function(part: Instance, touched: boolean)
    firesignal(part, touched and "Touched" or touched == false and "TouchEnded" or "Touched")
end)

check("fireproximityprompt", function(prompt: Instance, triggered: boolean, hold: boolean)
    firesignal(prompt, hold and (triggered and "PromptButtonHoldBegan" or "PromptButtonHoldEnded") or (triggered and "Triggered" or triggered == false and "TriggerEnded" or "Triggered"))
end)

check("runanimation", function(animationId: any, player: Player)
    local plr: Player = player or getgenv().getplayer()
    local humanoid: Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. tostring(animationId)
        humanoid:LoadAnimation(animation):Play()
    end
end)

check("round", function()
    getgenv().round = math.round
end)

check("joingame", function()
    getgenv().joingame = join
end)

check("joinserver", function()
    getgenv().joinserver = join
end)

check("firetouchtransmitter", function()
    getgenv().firetouchtransmitter = firetouchinterest
end)

getgenv().getdevice = function()
    local inputsrv = game:GetService("UserInputService")
    if inputsrv:GetPlatform() == Enum.Platform.Windows then
        return 'Windows'
    elseif inputsrv:GetPlatform() == Enum.Platform.OSX then
        return 'macOS'
    elseif inputsrv:GetPlatform() == Enum.Platform.IOS then
        return 'iOS'
    elseif inputsrv:GetPlatform() == Enum.Platform.UWP then
        return 'Windows (Microsoft Store)'
    elseif inputsrv:GetPlatform() == Enum.Platform.Android then
        return 'Android'
    else 
        return 'Unknown'
    end
end
local getdevice = getgenv().getdevice

check("getplatform", function()
    getgenv().getplatform = getdevice
end)

check("getos", function()
    getgenv().getos = getdevice
end)

check("playanimation", function()
    getgenv().playanimation = runanimation
end)

check("setrbxclipboard", function()
    getgenv().setrbxclipboard = setclipboard
end)
local colors = {
	BLACK = Color3.fromRGB(50, 50, 50),
	BLUE = Color3.fromRGB(0, 0, 204),
	GREEN = Color3.fromRGB(0, 255, 0),
	CYAN = Color3.fromRGB(0, 255, 255),
	RED = Color3.fromHex('#5A0101'),
	MAGENTA = Color3.fromRGB(255, 0, 255),
	BROWN = Color3.fromRGB(165, 42, 42),
	LIGHT_GRAY = Color3.fromRGB(211, 211, 211),
	DARK_GRAY = Color3.fromRGB(169, 169, 169),
	LIGHT_BLUE = Color3.fromRGB(173, 216, 230),
	LIGHT_GREEN = Color3.fromRGB(144, 238, 144),
	LIGHT_CYAN = Color3.fromRGB(224, 255, 255),
	LIGHT_RED = Color3.fromRGB(255, 204, 203),
	LIGHT_MAGENTA = Color3.fromRGB(255, 182, 193),
	YELLOW = Color3.fromRGB(255, 255, 0),
	WHITE = Color3.fromRGB(255, 255, 255),
	ORANGE = Color3.fromRGB(255, 186, 12)
}
local isDragging = false -- rconsole
local dragStartPos = nil -- rconsole
local frameStartPos = nil -- rconsole
-- All the following are for rconsole
local Console = Instance.new("ScreenGui")
local ConsoleFrame = Instance.new("Frame")
local Topbar = Instance.new("Frame")
local _CORNER = Instance.new("UICorner")
local ConsoleCorner = Instance.new("UICorner")
local CornerHide = Instance.new("Frame")
local DontModify = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local CornerHide2 = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local ConsoleIcon = Instance.new("ImageLabel")
local Holder = Instance.new("ScrollingFrame")
local MessageTemplate = Instance.new("TextLabel")
local InputTemplate = Instance.new("TextBox")
local UIListLayout = Instance.new("UIListLayout")
local HolderPadding = Instance.new("UIPadding")

Console.Name = "Console"
Console.Parent = nil
Console.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ConsoleFrame.Name = "ConsoleFrame"
ConsoleFrame.Parent = Console
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ConsoleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ConsoleFrame.BorderSizePixel = 0
ConsoleFrame.Position = UDim2.new(0.0963890627, 0, 0.220791712, 0)
ConsoleFrame.Size = UDim2.new(0, 888, 0, 577)

Topbar.Name = "Topbar"
Topbar.Parent = ConsoleFrame
Topbar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Topbar.BorderSizePixel = 0
Topbar.Position = UDim2.new(0, 0, -0.000463640812, 0)
Topbar.Size = UDim2.new(1, 0, 0, 32)

_CORNER.Name = "_CORNER"
_CORNER.Parent = Topbar

ConsoleCorner.Name = "ConsoleCorner"
ConsoleCorner.Parent = ConsoleFrame

CornerHide.Name = "CornerHide"
CornerHide.Parent = ConsoleFrame
CornerHide.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CornerHide.BorderColor3 = Color3.fromRGB(0, 0, 0)
CornerHide.BorderSizePixel = 0
CornerHide.Position = UDim2.new(0, 0, 0.0280000009, 0)
CornerHide.Size = UDim2.new(1, 0, 0, 12)

DontModify.Name = "DontModify"
DontModify.Parent = ConsoleFrame
DontModify.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
DontModify.BorderColor3 = Color3.fromRGB(0, 0, 0)
DontModify.BorderSizePixel = 0
DontModify.Position = UDim2.new(0.98169291, 0, 0.0278581586, 0)
DontModify.Size = UDim2.new(-0.00675675692, 21, 0.972141862, 0)

UICorner.Parent = DontModify

CornerHide2.Name = "CornerHide2"
CornerHide2.Parent = ConsoleFrame
CornerHide2.AnchorPoint = Vector2.new(1, 0)
CornerHide2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CornerHide2.BorderColor3 = Color3.fromRGB(0, 0, 0)
CornerHide2.BorderSizePixel = 0
CornerHide2.Position = UDim2.new(1, 0, 0.0450000018, 0)
CornerHide2.Size = UDim2.new(0, 9, 0.955023408, 0)

Title.Name = "Title"
Title.Parent = ConsoleFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.0440017432, 0, 0, 0)
Title.Size = UDim2.new(0, 164, 0, 30)
Title.Font = Enum.Font.GothamMedium
Title.Text = "rconsole title"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17.000
Title.TextXAlignment = Enum.TextXAlignment.Left

UIPadding.Parent = Title
UIPadding.PaddingTop = UDim.new(0, 5)

ConsoleIcon.Name = "ConsoleIcon"
ConsoleIcon.Parent = ConsoleFrame
ConsoleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ConsoleIcon.BackgroundTransparency = 1.000
ConsoleIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
ConsoleIcon.BorderSizePixel = 0
ConsoleIcon.Position = UDim2.new(0.00979213417, 0, 0.000874322082, 0)
ConsoleIcon.Size = UDim2.new(0, 31, 0, 31)
ConsoleIcon.Image = "http://www.roblox.com/asset/?id=11843683545"

Holder.Name = "Holder"
Holder.Parent = ConsoleFrame
Holder.Active = true
Holder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Holder.BackgroundTransparency = 1.000
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.BorderSizePixel = 0
Holder.Position = UDim2.new(0, 0, 0.054600548, 0)
Holder.Size = UDim2.new(1, 0, 0.945399463, 0)
Holder.ScrollBarThickness = 8
Holder.CanvasSize = UDim2.new(0,0,0,0)
Holder.AutomaticCanvasSize = Enum.AutomaticSize.XY

MessageTemplate.Name = "MessageTemplate"
MessageTemplate.Parent = Holder
MessageTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MessageTemplate.BackgroundTransparency = 1.000
MessageTemplate.BorderColor3 = Color3.fromRGB(0, 0, 0)
MessageTemplate.BorderSizePixel = 0
MessageTemplate.Size = UDim2.new(0.9745, 0, 0.030000001, 0)
MessageTemplate.Visible = false
MessageTemplate.Font = Enum.Font.RobotoMono
MessageTemplate.Text = "TEMPLATE"
MessageTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
MessageTemplate.TextSize = 20.000
MessageTemplate.TextXAlignment = Enum.TextXAlignment.Left
MessageTemplate.TextYAlignment = Enum.TextYAlignment.Top
MessageTemplate.RichText = true

UIListLayout.Parent = Holder
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

HolderPadding.Name = "HolderPadding"
HolderPadding.Parent = Holder
HolderPadding.PaddingLeft = UDim.new(0, 15)
HolderPadding.PaddingTop = UDim.new(0, 15)

InputTemplate.Name = "InputTemplate"
InputTemplate.Parent = nil
InputTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InputTemplate.BackgroundTransparency = 1.000
InputTemplate.BorderColor3 = Color3.fromRGB(0, 0, 0)
InputTemplate.BorderSizePixel = 0
InputTemplate.Size = UDim2.new(0.9745, 0, 0.030000001, 0)
InputTemplate.Visible = false
InputTemplate.RichText = true
InputTemplate.Font = Enum.Font.RobotoMono
InputTemplate.Text = ""
InputTemplate.PlaceholderText = ''
InputTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
InputTemplate.TextSize = 20.000
InputTemplate.TextXAlignment = Enum.TextXAlignment.Left
InputTemplate.TextYAlignment = Enum.TextYAlignment.Top
local MessageColor = colors['WHITE']
local ConsoleClone = nil
local function handleInput(input, Object)
    if isDragging then
        local delta = input.Position - dragStartPos
        Object.Position = UDim2.new(
            frameStartPos.X.Scale, 
            frameStartPos.X.Offset + delta.X, 
            frameStartPos.Y.Scale, 
            frameStartPos.Y.Offset + delta.Y
        )
    end
end
local function startDrag(input, Object)
    isDragging = true
    dragStartPos = input.Position
    frameStartPos = Object.Position
    input.UserInputState = Enum.UserInputState.Begin
end

local function stopDrag(input)
    isDragging = false
    input.UserInputState = Enum.UserInputState.End
end
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if not input then return end
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement and ConsoleClone then
        handleInput(input, ConsoleClone.ConsoleFrame)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if not input then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        stopDrag(input)
    end
end)
local ConsoleQueue = Queue.new()
getgenv().rconsolecreate = function()
    local Clone = Console:Clone()
    Clone.Parent = gethui()
    ConsoleClone = Clone
    ConsoleClone.ConsoleFrame.Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            startDrag(input, ConsoleClone.ConsoleFrame)
        end
    end)
end
local rconsolecreate = getgenv().rconsolecreate
getgenv().rconsoledestroy = function()
    if ConsoleClone then ConsoleClone:Destroy() end
    ConsoleClone = nil
end
local rconsoledestroy = getgenv().rconsoledestroy
getgenv().rconsoleprint = function(msg, cc)
    local CONSOLE = ConsoleClone or Console
	repeat task.wait() until ConsoleQueue:IsEmpty()
	msg = tostring(msg)
	local last_color = nil

	msg = msg:gsub('@@(%a+)@@', function(color)
		local colorName = color:upper()
		local rgbColor = colors[colorName]
		if rgbColor then
			local fontTag = string.format('<font color="rgb(%d,%d,%d)">', rgbColor.R * 255, rgbColor.G * 255, rgbColor.B * 255)
			local result = last_color and '</font>' .. fontTag or fontTag
			last_color = colorName
			return result
		else
			return '@@' .. color .. '@@'
		end
	end)

	if last_color then
		msg = msg .. '</font>'
	end
	
	if msg:match('<font color=".+">.+</font>') then
	 if msg:match('<font color=".+"></font>') == msg then MessageColor = colors[last_color] return end
	end
	
	local tmp = MessageTemplate:Clone()
	tmp.Parent = CONSOLE.ConsoleFrame.Holder
	tmp.Text = msg
	tmp.Visible = true
	tmp.TextColor3 = cc and cc or MessageColor
end
local rconsoleprint = getgenv().rconsoleprint
getgenv().rconsoleinput = function()
    local CONSOLE = ConsoleClone or Console
    repeat task.wait() until ConsoleQueue:IsEmpty()
    ConsoleQueue:Queue('input')
    local box = InputTemplate:Clone()
    local val
    box.Parent = CONSOLE.ConsoleFrame.Holder
    box.Visible = true
    box.TextEditable = true
    box.TextColor3 = MessageColor

    box.FocusLost:Connect(function(a)
     if not a then return end
     val = box.Text
     ConsoleQueue:Update()
    end)

    local FOCUSED = false
    while true do
     if box.Text:sub(#box.Text, #box.Text) == '_' or box.Text == '' or not box:IsFocused() then
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Text = box.Text .. '_'
        
        for _ = 1, 100 do
            task.wait(1/2)
            if box:IsFocused() then
                FOCUSED = true
                box.TextColor3 = MessageColor
                break
            end
            box.Text = box.Text:sub(#box.Text, #box.Text) == '_' and box.Text:sub(#box.Text-1, #box.Text-1) or box.Text .. '_'
        end
        if FOCUSED then break end
     else
        task.wait(0.1)
     end
    end
    repeat task.wait() until val
    return val
end
local rconsoleinput = getgenv().rconsoleinput
getgenv().rconsolename = function(a)
 if ConsoleClone then
  ConsoleClone.ConsoleFrame.Title.Text = a
 else
  Console.ConsoleFrame.Title.Text = a
 end
end
local rconsolename = getgenv().rconsolename
getgenv().printconsole = function(msg, r, g, b)
 r = r or 0
 g = g or 0
 b = b or 0
 rconsoleprint(msg, Color3.fromRGB(r, g, b))
end
local printconsole = getgenv().printconsole
getgenv().rconsoleclear = function()
 if ConsoleClone then
 for i, v in pairs(ConsoleClone.ConsoleFrame.Holder:GetChildren()) do
  if v.ClassName == 'TextLabel' or v.ClassName == 'TextBox' then v:Destroy() end
 end
 else
  for i, v in pairs(Console.ConsoleFrame.Holder:GetChildren()) do
   if v.ClassName == 'TextLabel' or v.ClassName == 'TextBox' then v:Destroy() end
  end
 end
end
local rconsoleclear = getgenv().rconsoleclear
getgenv().rconsoleinfo = function(a)
 rconsoleprint('[INFO]: ' .. tostring(a))
end
local rconsoleinfo = getgenv().rconsoleinfo
getgenv().rconsolewarn = function(a)
 rconsoleprint('[*]: ' .. tostring(a))
end
local rconsolewarn = getgenv().rconsolewarn
getgenv().rconsoleerr = function(a)
 local clr = MessageColor
 local oldColor
 for i, v in pairs(colors) do
  if clr == v then oldColor = i break end
 end
 rconsoleprint(string.format('[@@RED@@*@@%s@@]: %s', oldColor, tostring(a)))
end
local rconsoleerr = getgenv().rconsoleerr
getgenv().rconsoleinputasync = getgenv().rconsoleinput
local rconsoleinputasync = getgenv().rconsoleinputasync
getgenv().consolecreate = getgenv().rconsolecreate
local consolecreate = getgenv().consolecreate
getgenv().consoleclear = getgenv().rconsoleclear
local consoleclear = getgenv().consoleclear
getgenv().consoledestroy = getgenv().rconsoledestroy
local consoledestroy = getgenv().consoledestroy
getgenv().consoleinput = getgenv().rconsoleinput
local consoleinput = getgenv().consoleinput
getgenv().rconsolesettitle = getgenv().rconsolename
local rconsolesettitle = getgenv().rconsolesettitle
getgenv().consolesettitle = getgenv().rconsolename
local consolesettitle = getgenv().consolesettitle
getgenv().consoleprint = getgenv().rconsoleprint 
local consoleprint = getgenv().consoleprint
getgenv().base64_encode = getgenv().base64.encode 
local base64_encode = getgenv().base64_encode
getgenv().base64_decode = getgenv().base64.decode
local base64_decode = getgenv().base64_decode
getgenv().http = {}
local http = getgenv().http
getgenv().http.request = request 
getgenv().http_request = request
getgenv().firetouchtransmitter = firetouchinterest
local firetouchtransmitter = getgenv().firetouchtransmitter
getgenv().getplatform = getdevice
local getplatform = getgenv().getplatform
getgenv().getos = getdevice
local getos = getgenv().getos
getgenv().playanimation = runanimation
local playanimation = getgenv().playanimation





-- skibidi toilet
local load = coroutine.wrap(function()
	local compile = coroutine.wrap(function()
		local luaZ = {}
		local luaY = {}
		local luaX = {}
		local luaP = {}
		local luaU = {}
		local luaK = {}
		local size_size_t = 8

		local function lua_assert(test)
			if not test then error("assertion failed!") end
		end

		function luaZ:make_getS(buff)
			local b = buff
			return function()
				if not b then return nil end
				local data = b
				b = nil
				return data
			end
		end

		function luaZ:make_getF(source)
			local LUAL_BUFFERSIZE = 512
			local pos = 1

			return function() 
				local buff = source:sub(pos, pos + LUAL_BUFFERSIZE - 1)
				pos = math.min(#source + 1, pos + LUAL_BUFFERSIZE)
				return buff
			end
		end

		function luaZ:init(reader, data)
			if not reader then return end
			local z = {}
			z.reader = reader
			z.data = data or ""
			z.name = name
			if not data or data == "" then z.n = 0 else z.n = #data end
			z.p = 0
			return z
		end

		function luaZ:fill(z)
			local buff = z.reader()
			z.data = buff
			if not buff or buff == "" then return "EOZ" end
			z.n, z.p = #buff - 1, 1
			return string.sub(buff, 1, 1)
		end

		function luaZ:zgetc(z)
			local n, p = z.n, z.p + 1
			if n > 0 then
				z.n, z.p = n - 1, p
				return string.sub(z.data, p, p)
			else
				return self:fill(z)
			end
		end

		luaX.RESERVED = [[
TK_AND and
TK_BREAK break
TK_DO do
TK_ELSE else
TK_ELSEIF elseif
TK_END end
TK_FALSE false
TK_FOR for
TK_FUNCTION function
TK_IF if
TK_IN in
TK_LOCAL local
TK_NIL nil
TK_NOT not
TK_OR or
TK_REPEAT repeat
TK_RETURN return
TK_THEN then
TK_TRUE true
TK_UNTIL until
TK_WHILE while
TK_CONCAT ..
TK_DOTS ...
TK_EQ ==
TK_GE >=
TK_LE <=
TK_NE ~=
TK_NAME <name>
TK_NUMBER <number>
TK_STRING <string>
TK_EOS <eof>]]

		luaX.MAXSRC = 80
		luaX.MAX_INT = 2147483645
		luaX.LUA_QS = "'%s'"
		luaX.LUA_COMPAT_LSTR = 1

		function luaX:init()
			local tokens, enums = {}, {}
			for v in string.gmatch(self.RESERVED, "[^\n]+") do
				local _, _, tok, str = string.find(v, "(%S+)%s+(%S+)")
				tokens[tok] = str
				enums[str] = tok
			end
			self.tokens = tokens
			self.enums = enums
		end

		function luaX:chunkid(source, bufflen)
			local out
			local first = string.sub(source, 1, 1)
			if first == "=" then
				out = string.sub(source, 2, bufflen)
			else
				if first == "@" then
					source = string.sub(source, 2)
					bufflen = bufflen - #" '...' "
					local l = #source
					out = ""
					if l > bufflen then
						source = string.sub(source, 1 + l - bufflen) 
						out = out.."..."
					end
					out = out..source
				else 
					local len = string.find(source, "[\n\r]") 
					len = len and (len - 1) or #source
					bufflen = bufflen - #(" [string \"...\"] ")
					if len > bufflen then len = bufflen end
					out = "[string \""
					if len < #source then
						out = out..string.sub(source, 1, len).."..."
					else
						out = out..source
					end
					out = out.."\"]"
				end
			end
			return out
		end

		function luaX:token2str(ls, token)
			if string.sub(token, 1, 3) ~= "TK_" then
				if string.find(token, "%c") then
					return string.format("char(%d)", string.byte(token))
				end
				return token
			else
				return self.tokens[token]
			end
		end

		function luaX:lexerror(ls, msg, token)
			local function txtToken(ls, token)
				if token == "TK_NAME" or
					token == "TK_STRING" or
					token == "TK_NUMBER" then
					return ls.buff
				else
					return self:token2str(ls, token)
				end
			end
			local buff = self:chunkid(ls.source, self.MAXSRC)
			local msg = string.format("%s:%d: %s", buff, ls.linenumber, msg)
			if token then
				msg = string.format("%s near "..self.LUA_QS, msg, txtToken(ls, token))
			end
			error(msg)
		end

		function luaX:syntaxerror(ls, msg)
			self:lexerror(ls, msg, ls.t.token)
		end

		function luaX:currIsNewline(ls)
			return ls.current == "\n" or ls.current == "\r"
		end

		function luaX:inclinenumber(ls)
			local old = ls.current
			self:nextc(ls)
			if self:currIsNewline(ls) and ls.current ~= old then
				self:nextc(ls)
			end
			ls.linenumber = ls.linenumber + 1
			if ls.linenumber >= self.MAX_INT then
				self:syntaxerror(ls, "chunk has too many lines")
			end
		end

		function luaX:setinput(L, ls, z, source)
			if not ls then ls = {} end
			if not ls.lookahead then ls.lookahead = {} end
			if not ls.t then ls.t = {} end
			ls.decpoint = "."
			ls.L = L
			ls.lookahead.token = "TK_EOS" 
			ls.z = z
			ls.fs = nil
			ls.linenumber = 1
			ls.lastline = 1
			ls.source = source
			self:nextc(ls)
		end

		function luaX:check_next(ls, set)
			if not string.find(set, ls.current, 1, 1) then
				return false
			end
			self:save_and_next(ls)
			return true
		end

		function luaX:next(ls)
			ls.lastline = ls.linenumber
			if ls.lookahead.token ~= "TK_EOS" then

				ls.t.seminfo = ls.lookahead.seminfo 
				ls.t.token = ls.lookahead.token
				ls.lookahead.token = "TK_EOS" 
			else
				ls.t.token = self:llex(ls, ls.t) 
			end
		end

		function luaX:lookahead(ls)

			ls.lookahead.token = self:llex(ls, ls.lookahead)
		end

		function luaX:nextc(ls)
			local c = luaZ:zgetc(ls.z)
			ls.current = c
			return c
		end

		function luaX:save(ls, c)
			local buff = ls.buff
			ls.buff = buff..c
		end

		function luaX:save_and_next(ls)
			self:save(ls, ls.current)
			return self:nextc(ls)
		end

		function luaX:str2d(s)
			local result = tonumber(s)
			if result then return result end
			if string.lower(string.sub(s, 1, 2)) == "0x" then
				result = tonumber(s, 16)
				if result then return result end
			end
			return nil
		end

		function luaX:buffreplace(ls, from, to)
			local result, buff = "", ls.buff
			for p = 1, #buff do
				local c = string.sub(buff, p, p)
				if c == from then c = to end
				result = result..c
			end
			ls.buff = result
		end

		function luaX:trydecpoint(ls, Token)
			local old = ls.decpoint
			self:buffreplace(ls, old, ls.decpoint)
			local seminfo = self:str2d(ls.buff)
			Token.seminfo = seminfo
			if not seminfo then
				self:buffreplace(ls, ls.decpoint, ".")
				self:lexerror(ls, "malformed number", "TK_NUMBER")
			end
		end

		function luaX:read_numeral(ls, Token)
			repeat
				self:save_and_next(ls)
			until string.find(ls.current, "%D") and ls.current ~= "."
			if self:check_next(ls, "Ee") then
				self:check_next(ls, "+-")
			end
			while string.find(ls.current, "^%w$") or ls.current == "_" do
				self:save_and_next(ls)
			end
			self:buffreplace(ls, ".", ls.decpoint)
			local seminfo = self:str2d(ls.buff)
			Token.seminfo = seminfo
			if not seminfo then
				self:trydecpoint(ls, Token) 
			end
		end

		function luaX:skip_sep(ls)
			local count = 0
			local s = ls.current
			self:save_and_next(ls)
			while ls.current == "=" do
				self:save_and_next(ls)
				count = count + 1
			end
			return (ls.current == s) and count or (-count) - 1
		end

		function luaX:read_long_string(ls, Token, sep)
			local cont = 0
			self:save_and_next(ls)
			if self:currIsNewline(ls) then
				self:inclinenumber(ls)
			end
			while true do
				local c = ls.current
				if c == "EOZ" then
					self:lexerror(ls, Token and "unfinished long string" or
						"unfinished long comment", "TK_EOS")
				elseif c == "[" then
					if self.LUA_COMPAT_LSTR then
						if self:skip_sep(ls) == sep then
							self:save_and_next(ls)
							cont = cont + 1
							if self.LUA_COMPAT_LSTR == 1 then
								if sep == 0 then
									self:lexerror(ls, "nesting of [[...]] is deprecated", "[")
								end
							end
						end
					end
				elseif c == "]" then
					if self:skip_sep(ls) == sep then
						self:save_and_next(ls)
						if self.LUA_COMPAT_LSTR and self.LUA_COMPAT_LSTR == 2 then
							cont = cont - 1
							if sep == 0 and cont >= 0 then break end
						end
						break
					end
				elseif self:currIsNewline(ls) then
					self:save(ls, "\n")
					self:inclinenumber(ls)
					if not Token then ls.buff = "" end
				else
					if Token then
						self:save_and_next(ls)
					else
						self:nextc(ls)
					end
				end
			end
			if Token then
				local p = 3 + sep
				Token.seminfo = string.sub(ls.buff, p, -p)
			end
		end

		function luaX:read_string(ls, del, Token)
			self:save_and_next(ls)
			while ls.current ~= del do
				local c = ls.current
				if c == "EOZ" then
					self:lexerror(ls, "unfinished string", "TK_EOS")
				elseif self:currIsNewline(ls) then
					self:lexerror(ls, "unfinished string", "TK_STRING")
				elseif c == "\\" then
					c = self:nextc(ls)
					if self:currIsNewline(ls) then 
						self:save(ls, "\n")
						self:inclinenumber(ls)
					elseif c ~= "EOZ" then
						local i = string.find("abfnrtv", c, 1, 1)
						if i then
							self:save(ls, string.sub("\a\b\f\n\r\t\v", i, i))
							self:nextc(ls)
						elseif not string.find(c, "%d") then
							self:save_and_next(ls)
						else
							c, i = 0, 0
							repeat
								c = 10 * c + ls.current
								self:nextc(ls)
								i = i + 1
							until i >= 3 or not string.find(ls.current, "%d")
							if c > 255 then
								self:lexerror(ls, "escape sequence too large", "TK_STRING")
							end
							self:save(ls, string.char(c))
						end
					end
				else
					self:save_and_next(ls)
				end
			end
			self:save_and_next(ls)
			Token.seminfo = string.sub(ls.buff, 2, -2)
		end

		function luaX:llex(ls, Token)
			ls.buff = ""
			while true do
				local c = ls.current
				if self:currIsNewline(ls) then
					self:inclinenumber(ls)
				elseif c == "-" then
					c = self:nextc(ls)
					if c ~= "-" then return "-" end
					local sep = -1
					if self:nextc(ls) == '[' then
						sep = self:skip_sep(ls)
						ls.buff = ""
					end
					if sep >= 0 then
						self:read_long_string(ls, nil, sep)
						ls.buff = ""
					else
						while not self:currIsNewline(ls) and ls.current ~= "EOZ" do
							self:nextc(ls)
						end
					end
				elseif c == "[" then
					local sep = self:skip_sep(ls)
					if sep >= 0 then
						self:read_long_string(ls, Token, sep)
						return "TK_STRING"
					elseif sep == -1 then
						return "["
					else
						self:lexerror(ls, "invalid long string delimiter", "TK_STRING")
					end
				elseif c == "=" then
					c = self:nextc(ls)
					if c ~= "=" then return "="
					else self:nextc(ls); return "TK_EQ" end
				elseif c == "<" then
					c = self:nextc(ls)
					if c ~= "=" then return "<"
					else self:nextc(ls); return "TK_LE" end
				elseif c == ">" then
					c = self:nextc(ls)
					if c ~= "=" then return ">"
					else self:nextc(ls); return "TK_GE" end
				elseif c == "~" then
					c = self:nextc(ls)
					if c ~= "=" then return "~"
					else self:nextc(ls); return "TK_NE" end
				elseif c == "\"" or c == "'" then
					self:read_string(ls, c, Token)
					return "TK_STRING"
				elseif c == "." then
					c = self:save_and_next(ls)
					if self:check_next(ls, ".") then
						if self:check_next(ls, ".") then
							return "TK_DOTS"
						else return "TK_CONCAT"
						end
					elseif not string.find(c, "%d") then
						return "."
					else
						self:read_numeral(ls, Token)
						return "TK_NUMBER"
					end
				elseif c == "EOZ" then
					return "TK_EOS"
				else
					if string.find(c, "%s") then
						self:nextc(ls)
					elseif string.find(c, "%d") then
						self:read_numeral(ls, Token)
						return "TK_NUMBER"
					elseif string.find(c, "[_%a]") then
						repeat
							c = self:save_and_next(ls)
						until c == "EOZ" or not string.find(c, "[_%w]")
						local ts = ls.buff
						local tok = self.enums[ts]
						if tok then return tok end
						Token.seminfo = ts
						return "TK_NAME"
					else
						self:nextc(ls)
						return c
					end
				end
			end
		end

		luaP.OpMode = { iABC = 0, iABx = 1, iAsBx = 2 }

		luaP.SIZE_C  = 9
		luaP.SIZE_B  = 9
		luaP.SIZE_Bx = luaP.SIZE_C + luaP.SIZE_B
		luaP.SIZE_A  = 8

		luaP.SIZE_OP = 6

		luaP.POS_OP = 0
		luaP.POS_A  = luaP.POS_OP + luaP.SIZE_OP
		luaP.POS_C  = luaP.POS_A + luaP.SIZE_A
		luaP.POS_B  = luaP.POS_C + luaP.SIZE_C
		luaP.POS_Bx = luaP.POS_C

		luaP.MAXARG_Bx  = math.ldexp(1, luaP.SIZE_Bx) - 1
		luaP.MAXARG_sBx = math.floor(luaP.MAXARG_Bx / 2)

		luaP.MAXARG_A = math.ldexp(1, luaP.SIZE_A) - 1
		luaP.MAXARG_B = math.ldexp(1, luaP.SIZE_B) - 1
		luaP.MAXARG_C = math.ldexp(1, luaP.SIZE_C) - 1

		function luaP:GET_OPCODE(i) return self.ROpCode[i.OP] end
		function luaP:SET_OPCODE(i, o) i.OP = self.OpCode[o] end

		function luaP:GETARG_A(i) return i.A end
		function luaP:SETARG_A(i, u) i.A = u end

		function luaP:GETARG_B(i) return i.B end
		function luaP:SETARG_B(i, b) i.B = b end

		function luaP:GETARG_C(i) return i.C end
		function luaP:SETARG_C(i, b) i.C = b end

		function luaP:GETARG_Bx(i) return i.Bx end
		function luaP:SETARG_Bx(i, b) i.Bx = b end

		function luaP:GETARG_sBx(i) return i.Bx - self.MAXARG_sBx end
		function luaP:SETARG_sBx(i, b) i.Bx = b + self.MAXARG_sBx end

		function luaP:CREATE_ABC(o,a,b,c)
			return {OP = self.OpCode[o], A = a, B = b, C = c}
		end

		function luaP:CREATE_ABx(o,a,bc)
			return {OP = self.OpCode[o], A = a, Bx = bc}
		end

		function luaP:CREATE_Inst(c)
			local o = c % 64
			c = (c - o) / 64
			local a = c % 256
			c = (c - a) / 256
			return self:CREATE_ABx(o, a, c)
		end

		function luaP:Instruction(i)
			if i.Bx then
				i.C = i.Bx % 512
				i.B = (i.Bx - i.C) / 512
			end
			local I = i.A * 64 + i.OP
			local c0 = I % 256
			I = i.C * 64 + (I - c0) / 256
			local c1 = I % 256
			I = i.B * 128 + (I - c1) / 256
			local c2 = I % 256
			local c3 = (I - c2) / 256
			return string.char(c0, c1, c2, c3)
		end

		function luaP:DecodeInst(x)
			local byte = string.byte
			local i = {}
			local I = byte(x, 1)
			local op = I % 64
			i.OP = op
			I = byte(x, 2) * 4 + (I - op) / 64
			local a = I % 256
			i.A = a
			I = byte(x, 3) * 4 + (I - a) / 256
			local c = I % 512
			i.C = c
			i.B = byte(x, 4) * 2 + (I - c) / 512
			local opmode = self.OpMode[tonumber(string.sub(self.opmodes[op + 1], 7, 7))]
			if opmode ~= "iABC" then
				i.Bx = i.B * 512 + i.C
			end
			return i
		end

		luaP.BITRK = math.ldexp(1, luaP.SIZE_B - 1)

		function luaP:ISK(x) return x >= self.BITRK end

		function luaP:INDEXK(r) return x - self.BITRK end

		luaP.MAXINDEXRK = luaP.BITRK - 1

		function luaP:RKASK(x) return x + self.BITRK end

		luaP.NO_REG = luaP.MAXARG_A

		luaP.opnames = {} 
		luaP.OpCode = {} 
		luaP.ROpCode = {} 

		local i = 0
		for v in string.gmatch([[
MOVE LOADK LOADBOOL LOADNIL GETUPVAL
GETGLOBAL GETTABLE SETGLOBAL SETUPVAL SETTABLE
NEWTABLE SELF ADD SUB MUL
DIV MOD POW UNM NOT
LEN CONCAT JMP EQ LT
LE TEST TESTSET CALL TAILCALL
RETURN FORLOOP FORPREP TFORLOOP SETLIST
CLOSE CLOSURE VARARG
]], "%S+") do
			local n = "OP_"..v
			luaP.opnames[i] = v
			luaP.OpCode[n] = i
			luaP.ROpCode[i] = n
			i = i + 1
		end
		luaP.NUM_OPCODES = i
		luaP.OpArgMask = { OpArgN = 0, OpArgU = 1, OpArgR = 2, OpArgK = 3 }

		function luaP:getOpMode(m)
			return self.opmodes[self.OpCode[m]] % 4
		end

		function luaP:getBMode(m)
			return math.floor(self.opmodes[self.OpCode[m]] / 16) % 4
		end

		function luaP:getCMode(m)
			return math.floor(self.opmodes[self.OpCode[m]] / 4) % 4
		end

		function luaP:testAMode(m)
			return math.floor(self.opmodes[self.OpCode[m]] / 64) % 2
		end

		function luaP:testTMode(m)
			return math.floor(self.opmodes[self.OpCode[m]] / 128)
		end

		luaP.LFIELDS_PER_FLUSH = 50

		local function opmode(t, a, b, c, m)
			local luaP = luaP
			return t * 128 + a * 64 +
				luaP.OpArgMask[b] * 16 + luaP.OpArgMask[c] * 4 + luaP.OpMode[m]
		end

		luaP.opmodes = {
			opmode(0, 1, "OpArgK", "OpArgN", "iABx"), 
			opmode(0, 1, "OpArgU", "OpArgU", "iABC"),  
			opmode(0, 1, "OpArgR", "OpArgN", "iABC"),    
			opmode(0, 1, "OpArgU", "OpArgN", "iABC"),     
			opmode(0, 1, "OpArgK", "OpArgN", "iABx"),   
			opmode(0, 1, "OpArgR", "OpArgK", "iABC"),     
			opmode(0, 0, "OpArgK", "OpArgN", "iABx"),    
			opmode(0, 0, "OpArgU", "OpArgN", "iABC"),    
			opmode(0, 0, "OpArgK", "OpArgK", "iABC"),     
			opmode(0, 1, "OpArgU", "OpArgU", "iABC"),  
			opmode(0, 1, "OpArgR", "OpArgK", "iABC"),  
			opmode(0, 1, "OpArgK", "OpArgK", "iABC"),   
			opmode(0, 1, "OpArgK", "OpArgK", "iABC"),    
			opmode(0, 1, "OpArgK", "OpArgK", "iABC"),    
			opmode(0, 1, "OpArgK", "OpArgK", "iABC"),   
			opmode(0, 1, "OpArgK", "OpArgK", "iABC"),    
			opmode(0, 1, "OpArgK", "OpArgK", "iABC"),     
			opmode(0, 1, "OpArgR", "OpArgN", "iABC"),    
			opmode(0, 1, "OpArgR", "OpArgN", "iABC"),     
			opmode(0, 1, "OpArgR", "OpArgN", "iABC"),   
			opmode(0, 1, "OpArgR", "OpArgR", "iABC"),
			opmode(0, 0, "OpArgR", "OpArgN", "iAsBx"), 
			opmode(1, 0, "OpArgK", "OpArgK", "iABC"), 
			opmode(1, 0, "OpArgK", "OpArgK", "iABC"), 
			opmode(1, 0, "OpArgK", "OpArgK", "iABC"), 
			opmode(1, 1, "OpArgR", "OpArgU", "iABC"),   
			opmode(1, 1, "OpArgR", "OpArgU", "iABC"),   
			opmode(0, 1, "OpArgU", "OpArgU", "iABC"),  
			opmode(0, 1, "OpArgU", "OpArgU", "iABC"),  
			opmode(0, 0, "OpArgU", "OpArgN", "iABC"),   
			opmode(0, 1, "OpArgR", "OpArgN", "iAsBx"),  
			opmode(0, 1, "OpArgR", "OpArgN", "iAsBx"),   
			opmode(1, 0, "OpArgN", "OpArgU", "iABC"),    
			opmode(0, 0, "OpArgU", "OpArgU", "iABC"),   
			opmode(0, 0, "OpArgN", "OpArgN", "iABC"),     
			opmode(0, 1, "OpArgU", "OpArgN", "iABx"),  
			opmode(0, 1, "OpArgU", "OpArgN", "iABC"),     
		}

		luaP.opmodes[0] =
			opmode(0, 1, "OpArgR", "OpArgN", "iABC")

		luaU.LUA_SIGNATURE = "\27Lua"

		luaU.LUA_TNUMBER  = 3
		luaU.LUA_TSTRING  = 4
		luaU.LUA_TNIL     = 0
		luaU.LUA_TBOOLEAN = 1
		luaU.LUA_TNONE    = -1

		luaU.LUAC_VERSION    = 0x51    
		luaU.LUAC_FORMAT     = 0     
		luaU.LUAC_HEADERSIZE = 12   

		function luaU:make_setS()
			local buff = {}
			buff.data = ""
			local writer =
				function(s, buff)
					if not s then return 0 end
					buff.data = buff.data..s
					return 0
				end
			return writer, buff
		end

		function luaU:make_setF(filename)
			local buff = {}
			buff.h = io.open(filename, "wb")
			if not buff.h then return nil end
			local writer =
				function(s, buff)  
					if not buff.h then return 0 end
					if not s then
					if buff.h:close() then return 0 end
				else
					if buff.h:write(s) then return 0 end
				end
					return 1
				end
			return writer, buff
		end

		function luaU:ttype(o)
			local tt = type(o.value)
			if tt == "number" then return self.LUA_TNUMBER
			elseif tt == "string" then return self.LUA_TSTRING
			elseif tt == "nil" then return self.LUA_TNIL
			elseif tt == "boolean" then return self.LUA_TBOOLEAN
			else
				return self.LUA_TNONE
			end
		end

		function luaU:from_double(x)
			local function grab_byte(v)
				local c = v % 256
				return (v - c) / 256, string.char(c)
			end
			local sign = 0
			if x < 0 then sign = 1; x = -x end
			local mantissa, exponent = math.frexp(x)
			if x == 0 then 
				mantissa, exponent = 0, 0
			elseif x == 1/0 then
				mantissa, exponent = 0, 2047
			else
				mantissa = (mantissa * 2 - 1) * math.ldexp(0.5, 53)
				exponent = exponent + 1022
			end
			local v, byte = ""
			x = math.floor(mantissa)
			for i = 1,6 do
				x, byte = grab_byte(x); v = v..byte 
			end
			x, byte = grab_byte(exponent * 16 + x); v = v..byte
			x, byte = grab_byte(sign * 128 + x); v = v..byte 
			return v
		end

		function luaU:from_int(x)
			local v = ""
			x = math.floor(x)
			if x < 0 then x = 4294967296 + x end  
			for i = 1, 4 do
				local c = x % 256
				v = v..string.char(c); x = math.floor(x / 256)
			end
			return v
		end

		function luaU:DumpBlock(b, D)
			if D.status == 0 then
				D.status = D.write(b, D.data)
			end
		end

		function luaU:DumpChar(y, D)
			self:DumpBlock(string.char(y), D)
		end

		function luaU:DumpInt(x, D)
			self:DumpBlock(self:from_int(x), D)
		end

		function luaU:DumpSizeT(x, D)
			self:DumpBlock(self:from_int(x), D)
			if size_size_t == 8 then
				self:DumpBlock(self:from_int(0), D)
			end
		end

		function luaU:DumpNumber(x, D)
			self:DumpBlock(self:from_double(x), D)
		end

		function luaU:DumpString(s, D)
			if s == nil then
				self:DumpSizeT(0, D)
			else
				s = s.."\0"
				self:DumpSizeT(#s, D)
				self:DumpBlock(s, D)
			end
		end

        getgenv().dumpstring = luaU.DumpString
		dumpstring = getgenv().dumpstring

		function luaU:DumpCode(f, D)
			local n = f.sizecode
			self:DumpInt(n, D)
			for i = 0, n - 1 do
				self:DumpBlock(luaP:Instruction(f.code[i]), D)
			end
		end

		function luaU:DumpConstants(f, D)
			local n = f.sizek
			self:DumpInt(n, D)
			for i = 0, n - 1 do
				local o = f.k[i] 
				local tt = self:ttype(o)
				self:DumpChar(tt, D)
				if tt == self.LUA_TNIL then
				elseif tt == self.LUA_TBOOLEAN then
					self:DumpChar(o.value and 1 or 0, D)
				elseif tt == self.LUA_TNUMBER then
					self:DumpNumber(o.value, D)
				elseif tt == self.LUA_TSTRING then
					self:DumpString(o.value, D)
				else

				end
			end
			n = f.sizep
			self:DumpInt(n, D)
			for i = 0, n - 1 do
				self:DumpFunction(f.p[i], f.source, D)
			end
		end

		function luaU:DumpDebug(f, D)
			local n
			n = D.strip and 0 or f.sizelineinfo        

			self:DumpInt(n, D)
			for i = 0, n - 1 do
				self:DumpInt(f.lineinfo[i], D)
			end
			n = D.strip and 0 or f.sizelocvars      
			self:DumpInt(n, D)
			for i = 0, n - 1 do
				self:DumpString(f.locvars[i].varname, D)
				self:DumpInt(f.locvars[i].startpc, D)
				self:DumpInt(f.locvars[i].endpc, D)
			end
			n = D.strip and 0 or f.sizeupvalues     
			self:DumpInt(n, D)
			for i = 0, n - 1 do
				self:DumpString(f.upvalues[i], D)
			end
		end

		function luaU:DumpFunction(f, p, D)
			local source = f.source
			if source == p or D.strip then source = nil end
			self:DumpString(source, D)
			self:DumpInt(f.lineDefined, D)
			self:DumpInt(f.lastlinedefined, D)
			self:DumpChar(f.nups, D)
			self:DumpChar(f.numparams, D)
			self:DumpChar(f.is_vararg, D)
			self:DumpChar(f.maxstacksize, D)
			self:DumpCode(f, D)
			self:DumpConstants(f, D)
			self:DumpDebug(f, D)
		end

		function luaU:DumpHeader(D)
			local h = self:header()
			assert(#h == self.LUAC_HEADERSIZE)
			self:DumpBlock(h, D)
		end

		function luaU:header()
			local x = 1
			return self.LUA_SIGNATURE..
				string.char(
					self.LUAC_VERSION,
					self.LUAC_FORMAT,
					x,                  
					4,                    
					size_size_t,                
					4,                  
					8,                  
					0)                  
		end

		function luaU:dump(L, f, w, data, strip)
			local D = {} 
			D.L = L
			D.write = w
			D.data = data
			D.strip = strip
			D.status = 0
			self:DumpHeader(D)
			self:DumpFunction(f, nil, D)
			D.write(nil, D.data)
			return D.status
		end
		luaK.MAXSTACK = 250

		function luaK:ttisnumber(o)
			if o then return type(o.value) == "number" else return false end
		end
		function luaK:nvalue(o) return o.value end
		function luaK:setnilvalue(o) o.value = nil end
		function luaK:setsvalue(o, x) o.value = x end
		luaK.setnvalue = luaK.setsvalue
		luaK.sethvalue = luaK.setsvalue
		luaK.setbvalue = luaK.setsvalue

		function luaK:numadd(a, b) return a + b end
		function luaK:numsub(a, b) return a - b end
		function luaK:nummul(a, b) return a * b end
		function luaK:numdiv(a, b) return a / b end
		function luaK:nummod(a, b) return a % b end
		function luaK:numpow(a, b) return a ^ b end
		function luaK:numunm(a) return -a end
		function luaK:numisnan(a) return not a == a end

		luaK.NO_JUMP = -1

		luaK.BinOpr = {
			OPR_ADD = 0, OPR_SUB = 1, OPR_MUL = 2, OPR_DIV = 3, OPR_MOD = 4, OPR_POW = 5,
			OPR_CONCAT = 6,
			OPR_NE = 7, OPR_EQ = 8,
			OPR_LT = 9, OPR_LE = 10, OPR_GT = 11, OPR_GE = 12,
			OPR_AND = 13, OPR_OR = 14,
			OPR_NOBINOPR = 15,
		}

		luaK.UnOpr = {
			OPR_MINUS = 0, OPR_NOT = 1, OPR_LEN = 2, OPR_NOUNOPR = 3
		}

		function luaK:getcode(fs, e)
			return fs.f.code[e.info]
		end

		function luaK:codeAsBx(fs, o, A, sBx)
			return self:codeABx(fs, o, A, sBx + luaP.MAXARG_sBx)
		end

		function luaK:setmultret(fs, e)
			self:setreturns(fs, e, luaY.LUA_MULTRET)
		end

		function luaK:hasjumps(e)
			return e.t ~= e.f
		end

		function luaK:isnumeral(e)
			return e.k == "VKNUM" and e.t == self.NO_JUMP and e.f == self.NO_JUMP
		end

		function luaK:_nil(fs, from, n)
			if fs.pc > fs.lasttarget then  
				if fs.pc == 0 then  
					if from >= fs.nactvar then
						return  
					end
				else
					local previous = fs.f.code[fs.pc - 1]
					if luaP:GET_OPCODE(previous) == "OP_LOADNIL" then
						local pfrom = luaP:GETARG_A(previous)
						local pto = luaP:GETARG_B(previous)
						if pfrom <= from and from <= pto + 1 then  
							if from + n - 1 > pto then
								luaP:SETARG_B(previous, from + n - 1)
							end
							return
						end
					end
				end
			end
			self:codeABC(fs, "OP_LOADNIL", from, from + n - 1, 0)  
		end

		function luaK:jump(fs)
			local jpc = fs.jpc  
			fs.jpc = self.NO_JUMP
			local j = self:codeAsBx(fs, "OP_JMP", 0, self.NO_JUMP)
			j = self:concat(fs, j, jpc)  
			return j
		end

		function luaK:ret(fs, first, nret)
			self:codeABC(fs, "OP_RETURN", first, nret + 1, 0)
		end

		function luaK:condjump(fs, op, A, B, C)
			self:codeABC(fs, op, A, B, C)
			return self:jump(fs)
		end

		function luaK:fixjump(fs, pc, dest)
			local jmp = fs.f.code[pc]
			local offset = dest - (pc + 1)
			lua_assert(dest ~= self.NO_JUMP)
			if math.abs(offset) > luaP.MAXARG_sBx then
				luaX:syntaxerror(fs.ls, "control structure too long")
			end
			luaP:SETARG_sBx(jmp, offset)
		end

		function luaK:getlabel(fs)
			fs.lasttarget = fs.pc
			return fs.pc
		end

		function luaK:getjump(fs, pc)
			local offset = luaP:GETARG_sBx(fs.f.code[pc])
			if offset == self.NO_JUMP then  
				return self.NO_JUMP  
			else
				return (pc + 1) + offset  
			end
		end

		function luaK:getjumpcontrol(fs, pc)
			local pi = fs.f.code[pc]
			local ppi = fs.f.code[pc - 1]
			if pc >= 1 and luaP:testTMode(luaP:GET_OPCODE(ppi)) ~= 0 then
				return ppi
			else
				return pi
			end
		end

		function luaK:need_value(fs, list)
			while list ~= self.NO_JUMP do
				local i = self:getjumpcontrol(fs, list)
				if luaP:GET_OPCODE(i) ~= "OP_TESTSET" then return true end
				list = self:getjump(fs, list)
			end
			return false  
		end

		function luaK:patchtestreg(fs, node, reg)
			local i = self:getjumpcontrol(fs, node)
			if luaP:GET_OPCODE(i) ~= "OP_TESTSET" then
				return false  
			end
			if reg ~= luaP.NO_REG and reg ~= luaP:GETARG_B(i) then
				luaP:SETARG_A(i, reg)
			else  

				luaP:SET_OPCODE(i, "OP_TEST")
				local b = luaP:GETARG_B(i)
				luaP:SETARG_A(i, b)
				luaP:SETARG_B(i, 0)

			end
			return true
		end

		function luaK:removevalues(fs, list)
			while list ~= self.NO_JUMP do
				self:patchtestreg(fs, list, luaP.NO_REG)
				list = self:getjump(fs, list)
			end
		end

		function luaK:patchlistaux(fs, list, vtarget, reg, dtarget)
			while list ~= self.NO_JUMP do
				local _next = self:getjump(fs, list)
				if self:patchtestreg(fs, list, reg) then
					self:fixjump(fs, list, vtarget)
				else
					self:fixjump(fs, list, dtarget)  
				end
				list = _next
			end
		end

		function luaK:dischargejpc(fs)
			self:patchlistaux(fs, fs.jpc, fs.pc, luaP.NO_REG, fs.pc)
			fs.jpc = self.NO_JUMP
		end

		function luaK:patchlist(fs, list, target)
			if target == fs.pc then
				self:patchtohere(fs, list)
			else
				lua_assert(target < fs.pc)
				self:patchlistaux(fs, list, target, luaP.NO_REG, target)
			end
		end

		function luaK:patchtohere(fs, list)
			self:getlabel(fs)
			fs.jpc = self:concat(fs, fs.jpc, list)
		end

		function luaK:concat(fs, l1, l2)
			if l2 == self.NO_JUMP then return l1
			elseif l1 == self.NO_JUMP then
				return l2
			else
				local list = l1
				local _next = self:getjump(fs, list)
				while _next ~= self.NO_JUMP do  
					list = _next
					_next = self:getjump(fs, list)
				end
				self:fixjump(fs, list, l2)
			end
			return l1
		end

		function luaK:checkstack(fs, n)
			local newstack = fs.freereg + n
			if newstack > fs.f.maxstacksize then
				if newstack >= self.MAXSTACK then
					luaX:syntaxerror(fs.ls, "function or expression too complex")
				end
				fs.f.maxstacksize = newstack
			end
		end

		function luaK:reserveregs(fs, n)
			self:checkstack(fs, n)
			fs.freereg = fs.freereg + n
		end

		function luaK:freereg(fs, reg)
			if not luaP:ISK(reg) and reg >= fs.nactvar then
				fs.freereg = fs.freereg - 1
				lua_assert(reg == fs.freereg)
			end
		end

		function luaK:freeexp(fs, e)
			if e.k == "VNONRELOC" then
				self:freereg(fs, e.info)
			end
		end

		function luaK:addk(fs, k, v)
			local L = fs.L
			local idx = fs.h[k.value]

			local f = fs.f
			if self:ttisnumber(idx) then

				return self:nvalue(idx)
			else 
				idx = {}
				self:setnvalue(idx, fs.nk)
				fs.h[k.value] = idx

				luaY:growvector(L, f.k, fs.nk, f.sizek, nil,
					luaP.MAXARG_Bx, "constant table overflow")

				f.k[fs.nk] = v

				local nk = fs.nk
				fs.nk = fs.nk + 1
				return nk
			end

		end

		function luaK:stringK(fs, s)
			local o = {}  
			self:setsvalue(o, s)
			return self:addk(fs, o, o)
		end

		function luaK:numberK(fs, r)
			local o = {}  
			self:setnvalue(o, r)
			return self:addk(fs, o, o)
		end

		function luaK:boolK(fs, b)
			local o = {}  
			self:setbvalue(o, b)
			return self:addk(fs, o, o)
		end

		function luaK:nilK(fs)
			local k, v = {}, {}  
			self:setnilvalue(v)

			self:sethvalue(k, fs.h)
			return self:addk(fs, k, v)
		end

		function luaK:setreturns(fs, e, nresults)
			if e.k == "VCALL" then  
				luaP:SETARG_C(self:getcode(fs, e), nresults + 1)
			elseif e.k == "VVARARG" then
				luaP:SETARG_B(self:getcode(fs, e), nresults + 1);
				luaP:SETARG_A(self:getcode(fs, e), fs.freereg);
				luaK:reserveregs(fs, 1)
			end
		end

		function luaK:setoneret(fs, e)
			if e.k == "VCALL" then  
				e.k = "VNONRELOC"
				e.info = luaP:GETARG_A(self:getcode(fs, e))
			elseif e.k == "VVARARG" then
				luaP:SETARG_B(self:getcode(fs, e), 2)
				e.k = "VRELOCABLE"  
			end
		end

		function luaK:dischargevars(fs, e)
			local k = e.k
			if k == "VLOCAL" then
				e.k = "VNONRELOC"
			elseif k == "VUPVAL" then
				e.info = self:codeABC(fs, "OP_GETUPVAL", 0, e.info, 0)
				e.k = "VRELOCABLE"
			elseif k == "VGLOBAL" then
				e.info = self:codeABx(fs, "OP_GETGLOBAL", 0, e.info)
				e.k = "VRELOCABLE"
			elseif k == "VINDEXED" then
				self:freereg(fs, e.aux)
				self:freereg(fs, e.info)
				e.info = self:codeABC(fs, "OP_GETTABLE", 0, e.info, e.aux)
				e.k = "VRELOCABLE"
			elseif k == "VVARARG" or k == "VCALL" then
				self:setoneret(fs, e)
			else

			end
		end

		function luaK:code_label(fs, A, b, jump)
			self:getlabel(fs)  
			return self:codeABC(fs, "OP_LOADBOOL", A, b, jump)
		end

		function luaK:discharge2reg(fs, e, reg)
			self:dischargevars(fs, e)
			local k = e.k
			if k == "VNIL" then
				self:_nil(fs, reg, 1)
			elseif k == "VFALSE" or k == "VTRUE" then
				self:codeABC(fs, "OP_LOADBOOL", reg, (e.k == "VTRUE") and 1 or 0, 0)
			elseif k == "VK" then
				self:codeABx(fs, "OP_LOADK", reg, e.info)
			elseif k == "VKNUM" then
				self:codeABx(fs, "OP_LOADK", reg, self:numberK(fs, e.nval))
			elseif k == "VRELOCABLE" then
				local pc = self:getcode(fs, e)
				luaP:SETARG_A(pc, reg)
			elseif k == "VNONRELOC" then
				if reg ~= e.info then
					self:codeABC(fs, "OP_MOVE", reg, e.info, 0)
				end
			else
				lua_assert(e.k == "VVOID" or e.k == "VJMP")
				return  
			end
			e.info = reg
			e.k = "VNONRELOC"
		end

		function luaK:discharge2anyreg(fs, e)
			if e.k ~= "VNONRELOC" then
				self:reserveregs(fs, 1)
				self:discharge2reg(fs, e, fs.freereg - 1)
			end
		end

		function luaK:exp2reg(fs, e, reg)
			self:discharge2reg(fs, e, reg)
			if e.k == "VJMP" then
				e.t = self:concat(fs, e.t, e.info)  
			end
			if self:hasjumps(e) then
				local final  
				local p_f = self.NO_JUMP  
				local p_t = self.NO_JUMP  
				if self:need_value(fs, e.t) or self:need_value(fs, e.f) then
					local fj = (e.k == "VJMP") and self.NO_JUMP or self:jump(fs)
					p_f = self:code_label(fs, reg, 0, 1)
					p_t = self:code_label(fs, reg, 1, 0)
					self:patchtohere(fs, fj)
				end
				final = self:getlabel(fs)
				self:patchlistaux(fs, e.f, final, reg, p_f)
				self:patchlistaux(fs, e.t, final, reg, p_t)
			end
			e.f, e.t = self.NO_JUMP, self.NO_JUMP
			e.info = reg
			e.k = "VNONRELOC"
		end

		function luaK:exp2nextreg(fs, e)
			self:dischargevars(fs, e)
			self:freeexp(fs, e)
			self:reserveregs(fs, 1)
			self:exp2reg(fs, e, fs.freereg - 1)
		end

		function luaK:exp2anyreg(fs, e)
			self:dischargevars(fs, e)
			if e.k == "VNONRELOC" then
				if not self:hasjumps(e) then  
					return e.info
				end
				if e.info >= fs.nactvar then  
					self:exp2reg(fs, e, e.info)  
					return e.info
				end
			end
			self:exp2nextreg(fs, e)  
			return e.info
		end

		function luaK:exp2val(fs, e)
			if self:hasjumps(e) then
				self:exp2anyreg(fs, e)
			else
				self:dischargevars(fs, e)
			end
		end

		function luaK:exp2RK(fs, e)
			self:exp2val(fs, e)
			local k = e.k
			if k == "VKNUM" or k == "VTRUE" or k == "VFALSE" or k == "VNIL" then
				if fs.nk <= luaP.MAXINDEXRK then  

					if e.k == "VNIL" then
						e.info = self:nilK(fs)
					else
						e.info = (e.k == "VKNUM") and self:numberK(fs, e.nval)
							or self:boolK(fs, e.k == "VTRUE")
					end
					e.k = "VK"
					return luaP:RKASK(e.info)
				end
			elseif k == "VK" then
				if e.info <= luaP.MAXINDEXRK then  
					return luaP:RKASK(e.info)
				end
			else

			end

			return self:exp2anyreg(fs, e)
		end

		function luaK:storevar(fs, var, ex)
			local k = var.k
			if k == "VLOCAL" then
				self:freeexp(fs, ex)
				self:exp2reg(fs, ex, var.info)
				return
			elseif k == "VUPVAL" then
				local e = self:exp2anyreg(fs, ex)
				self:codeABC(fs, "OP_SETUPVAL", e, var.info, 0)
			elseif k == "VGLOBAL" then
				local e = self:exp2anyreg(fs, ex)
				self:codeABx(fs, "OP_SETGLOBAL", e, var.info)
			elseif k == "VINDEXED" then
				local e = self:exp2RK(fs, ex)
				self:codeABC(fs, "OP_SETTABLE", var.info, var.aux, e)
			else
				lua_assert(0)  
			end
			self:freeexp(fs, ex)
		end

		function luaK:_self(fs, e, key)
			self:exp2anyreg(fs, e)
			self:freeexp(fs, e)
			local func = fs.freereg
			self:reserveregs(fs, 2)
			self:codeABC(fs, "OP_SELF", func, e.info, self:exp2RK(fs, key))
			self:freeexp(fs, key)
			e.info = func
			e.k = "VNONRELOC"
		end

		function luaK:invertjump(fs, e)
			local pc = self:getjumpcontrol(fs, e.info)
			lua_assert(luaP:testTMode(luaP:GET_OPCODE(pc)) ~= 0 and
				luaP:GET_OPCODE(pc) ~= "OP_TESTSET" and
				luaP:GET_OPCODE(pc) ~= "OP_TEST")
			luaP:SETARG_A(pc, (luaP:GETARG_A(pc) == 0) and 1 or 0)
		end

		function luaK:jumponcond(fs, e, cond)
			if e.k == "VRELOCABLE" then
				local ie = self:getcode(fs, e)
				if luaP:GET_OPCODE(ie) == "OP_NOT" then
					fs.pc = fs.pc - 1  
					return self:condjump(fs, "OP_TEST", luaP:GETARG_B(ie), 0, cond and 0 or 1)
				end

			end
			self:discharge2anyreg(fs, e)
			self:freeexp(fs, e)
			return self:condjump(fs, "OP_TESTSET", luaP.NO_REG, e.info, cond and 1 or 0)
		end

		function luaK:goiftrue(fs, e)
			local pc  
			self:dischargevars(fs, e)
			local k = e.k
			if k == "VK" or k == "VKNUM" or k == "VTRUE" then
				pc = self.NO_JUMP  
			elseif k == "VFALSE" then
				pc = self:jump(fs)  
			elseif k == "VJMP" then
				self:invertjump(fs, e)
				pc = e.info
			else
				pc = self:jumponcond(fs, e, false)
			end
			e.f = self:concat(fs, e.f, pc)  
			self:patchtohere(fs, e.t)
			e.t = self.NO_JUMP
		end

		function luaK:goiffalse(fs, e)
			local pc  
			self:dischargevars(fs, e)
			local k = e.k
			if k == "VNIL" or k == "VFALSE"then
				pc = self.NO_JUMP  
			elseif k == "VTRUE" then
				pc = self:jump(fs)  
			elseif k == "VJMP" then
				pc = e.info
			else
				pc = self:jumponcond(fs, e, true)
			end
			e.t = self:concat(fs, e.t, pc)  
			self:patchtohere(fs, e.f)
			e.f = self.NO_JUMP
		end

		function luaK:codenot(fs, e)
			self:dischargevars(fs, e)
			local k = e.k
			if k == "VNIL" or k == "VFALSE" then
				e.k = "VTRUE"
			elseif k == "VK" or k == "VKNUM" or k == "VTRUE" then
				e.k = "VFALSE"
			elseif k == "VJMP" then
				self:invertjump(fs, e)
			elseif k == "VRELOCABLE" or k == "VNONRELOC" then
				self:discharge2anyreg(fs, e)
				self:freeexp(fs, e)
				e.info = self:codeABC(fs, "OP_NOT", 0, e.info, 0)
				e.k = "VRELOCABLE"
			else
				lua_assert(0)  
			end

			e.f, e.t = e.t, e.f
			self:removevalues(fs, e.f)
			self:removevalues(fs, e.t)
		end

		function luaK:indexed(fs, t, k)
			t.aux = self:exp2RK(fs, k)
			t.k = "VINDEXED"
		end

		function luaK:constfolding(op, e1, e2)
			local r
			if not self:isnumeral(e1) or not self:isnumeral(e2) then return false end
			local v1 = e1.nval
			local v2 = e2.nval
			if op == "OP_ADD" then
				r = self:numadd(v1, v2)
			elseif op == "OP_SUB" then
				r = self:numsub(v1, v2)
			elseif op == "OP_MUL" then
				r = self:nummul(v1, v2)
			elseif op == "OP_DIV" then
				if v2 == 0 then return false end  
				r = self:numdiv(v1, v2)
			elseif op == "OP_MOD" then
				if v2 == 0 then return false end  
				r = self:nummod(v1, v2)
			elseif op == "OP_POW" then
				r = self:numpow(v1, v2)
			elseif op == "OP_UNM" then
				r = self:numunm(v1)
			elseif op == "OP_LEN" then
				return false  
			else
				lua_assert(0)
				r = 0
			end
			if self:numisnan(r) then return false end  
			e1.nval = r
			return true
		end

		function luaK:codearith(fs, op, e1, e2)
			if self:constfolding(op, e1, e2) then
				return
			else
				local o2 = (op ~= "OP_UNM" and op ~= "OP_LEN") and self:exp2RK(fs, e2) or 0
				local o1 = self:exp2RK(fs, e1)
				if o1 > o2 then
					self:freeexp(fs, e1)
					self:freeexp(fs, e2)
				else
					self:freeexp(fs, e2)
					self:freeexp(fs, e1)
				end
				e1.info = self:codeABC(fs, op, 0, o1, o2)
				e1.k = "VRELOCABLE"
			end
		end

		function luaK:codecomp(fs, op, cond, e1, e2)
			local o1 = self:exp2RK(fs, e1)
			local o2 = self:exp2RK(fs, e2)
			self:freeexp(fs, e2)
			self:freeexp(fs, e1)
			if cond == 0 and op ~= "OP_EQ" then

				o1, o2 = o2, o1  
				cond = 1
			end
			e1.info = self:condjump(fs, op, cond, o1, o2)
			e1.k = "VJMP"
		end

		function luaK:prefix(fs, op, e)
			local e2 = {}  
			e2.t, e2.f = self.NO_JUMP, self.NO_JUMP
			e2.k = "VKNUM"
			e2.nval = 0
			if op == "OPR_MINUS" then
				if not self:isnumeral(e) then
					self:exp2anyreg(fs, e)  
				end
				self:codearith(fs, "OP_UNM", e, e2)
			elseif op == "OPR_NOT" then
				self:codenot(fs, e)
			elseif op == "OPR_LEN" then
				self:exp2anyreg(fs, e)  
				self:codearith(fs, "OP_LEN", e, e2)
			else
				lua_assert(0)
			end
		end

		function luaK:infix(fs, op, v)
			if op == "OPR_AND" then
				self:goiftrue(fs, v)
			elseif op == "OPR_OR" then
				self:goiffalse(fs, v)
			elseif op == "OPR_CONCAT" then
				self:exp2nextreg(fs, v)  
			elseif op == "OPR_ADD" or op == "OPR_SUB" or
				op == "OPR_MUL" or op == "OPR_DIV" or
				op == "OPR_MOD" or op == "OPR_POW" then
				if not self:isnumeral(v) then self:exp2RK(fs, v) end
			else
				self:exp2RK(fs, v)
			end
		end

		luaK.arith_op = {
			OPR_ADD = "OP_ADD", OPR_SUB = "OP_SUB", OPR_MUL = "OP_MUL",
			OPR_DIV = "OP_DIV", OPR_MOD = "OP_MOD", OPR_POW = "OP_POW",
		}
		luaK.comp_op = {
			OPR_EQ = "OP_EQ", OPR_NE = "OP_EQ", OPR_LT = "OP_LT",
			OPR_LE = "OP_LE", OPR_GT = "OP_LT", OPR_GE = "OP_LE",
		}
		luaK.comp_cond = {
			OPR_EQ = 1, OPR_NE = 0, OPR_LT = 1,
			OPR_LE = 1, OPR_GT = 0, OPR_GE = 0,
		}
		function luaK:posfix(fs, op, e1, e2)

			local function copyexp(e1, e2)
				e1.k = e2.k
				e1.info = e2.info; e1.aux = e2.aux
				e1.nval = e2.nval
				e1.t = e2.t; e1.f = e2.f
			end
			if op == "OPR_AND" then
				lua_assert(e1.t == self.NO_JUMP)  
				self:dischargevars(fs, e2)
				e2.f = self:concat(fs, e2.f, e1.f)
				copyexp(e1, e2)
			elseif op == "OPR_OR" then
				lua_assert(e1.f == self.NO_JUMP)  
				self:dischargevars(fs, e2)
				e2.t = self:concat(fs, e2.t, e1.t)
				copyexp(e1, e2)
			elseif op == "OPR_CONCAT" then
				self:exp2val(fs, e2)
				if e2.k == "VRELOCABLE" and luaP:GET_OPCODE(self:getcode(fs, e2)) == "OP_CONCAT" then
					lua_assert(e1.info == luaP:GETARG_B(self:getcode(fs, e2)) - 1)
					self:freeexp(fs, e1)
					luaP:SETARG_B(self:getcode(fs, e2), e1.info)
					e1.k = "VRELOCABLE"
					e1.info = e2.info
				else
					self:exp2nextreg(fs, e2)  
					self:codearith(fs, "OP_CONCAT", e1, e2)
				end
			else

				local arith = self.arith_op[op]
				if arith then
					self:codearith(fs, arith, e1, e2)
				else
					local comp = self.comp_op[op]
					if comp then
						self:codecomp(fs, comp, self.comp_cond[op], e1, e2)
					else
						lua_assert(0)
					end
				end
			end
		end

		function luaK:fixline(fs, line)
			fs.f.lineinfo[fs.pc - 1] = line
		end

		function luaK:code(fs, i, line)
			local f = fs.f
			self:dischargejpc(fs)  

			luaY:growvector(fs.L, f.code, fs.pc, f.sizecode, nil,
				luaY.MAX_INT, "code size overflow")
			f.code[fs.pc] = i

			luaY:growvector(fs.L, f.lineinfo, fs.pc, f.sizelineinfo, nil,
				luaY.MAX_INT, "code size overflow")
			f.lineinfo[fs.pc] = line
			local pc = fs.pc
			fs.pc = fs.pc + 1
			return pc
		end

		function luaK:codeABC(fs, o, a, b, c)
			lua_assert(luaP:getOpMode(o) == luaP.OpMode.iABC)
			lua_assert(luaP:getBMode(o) ~= luaP.OpArgMask.OpArgN or b == 0)
			lua_assert(luaP:getCMode(o) ~= luaP.OpArgMask.OpArgN or c == 0)
			return self:code(fs, luaP:CREATE_ABC(o, a, b, c), fs.ls.lastline)
		end

		function luaK:codeABx(fs, o, a, bc)
			lua_assert(luaP:getOpMode(o) == luaP.OpMode.iABx or
				luaP:getOpMode(o) == luaP.OpMode.iAsBx)
			lua_assert(luaP:getCMode(o) == luaP.OpArgMask.OpArgN)
			return self:code(fs, luaP:CREATE_ABx(o, a, bc), fs.ls.lastline)
		end

		function luaK:setlist(fs, base, nelems, tostore)
			local c = math.floor((nelems - 1)/luaP.LFIELDS_PER_FLUSH) + 1
			local b = (tostore == luaY.LUA_MULTRET) and 0 or tostore
			lua_assert(tostore ~= 0)
			if c <= luaP.MAXARG_C then
				self:codeABC(fs, "OP_SETLIST", base, b, c)
			else
				self:codeABC(fs, "OP_SETLIST", base, b, 0)
				self:code(fs, luaP:CREATE_Inst(c), fs.ls.lastline)
			end
			fs.freereg = base + 1  
		end

		luaY.LUA_QS = luaX.LUA_QS or "'%s'"  

		luaY.SHRT_MAX = 32767 
		luaY.LUAI_MAXVARS = 200  
		luaY.LUAI_MAXUPVALUES = 60  
		luaY.MAX_INT = luaX.MAX_INT or 2147483645  

		luaY.LUAI_MAXCCALLS = 200  

		luaY.VARARG_HASARG = 1  

		luaY.HASARG_MASK = 2 
		luaY.VARARG_ISVARARG = 2

		luaY.VARARG_NEEDSARG = 4

		luaY.LUA_MULTRET = -1  

		function luaY:LUA_QL(x)
			return "'"..x.."'"
		end

		function luaY:growvector(L, v, nelems, size, t, limit, e)
			if nelems >= limit then
				error(e)  
			end
		end

		function luaY:newproto(L)
			local f = {} 

			f.k = {}
			f.sizek = 0
			f.p = {}
			f.sizep = 0
			f.code = {}
			f.sizecode = 0
			f.sizelineinfo = 0
			f.sizeupvalues = 0
			f.nups = 0
			f.upvalues = {}
			f.numparams = 0
			f.is_vararg = 0
			f.maxstacksize = 0
			f.lineinfo = {}
			f.sizelocvars = 0
			f.locvars = {}
			f.lineDefined = 0
			f.lastlinedefined = 0
			f.source = nil
			return f
		end

		function luaY:int2fb(x)
			local e = 0  
			while x >= 16 do
				x = math.floor((x + 1) / 2)
				e = e + 1
			end
			if x < 8 then
				return x
			else
				return ((e + 1) * 8) + (x - 8)
			end
		end

		function luaY:hasmultret(k)
			return k == "VCALL" or k == "VVARARG"
		end

		function luaY:getlocvar(fs, i)
			return fs.f.locvars[ fs.actvar[i] ]
		end

		function luaY:checklimit(fs, v, l, m)
			if v > l then self:errorlimit(fs, l, m) end
		end

		function luaY:anchor_token(ls)
			if ls.t.token == "TK_NAME" or ls.t.token == "TK_STRING" then

			end
		end

		function luaY:error_expected(ls, token)
			luaX:syntaxerror(ls,
				string.format(self.LUA_QS.." expected", luaX:token2str(ls, token)))
		end

		function luaY:errorlimit(fs, limit, what)
			local msg = (fs.f.linedefined == 0) and
				string.format("main function has more than %d %s", limit, what) or
				string.format("function at line %d has more than %d %s",
					fs.f.linedefined, limit, what)
			luaX:lexerror(fs.ls, msg, 0)
		end

		function luaY:testnext(ls, c)
			if ls.t.token == c then
				luaX:next(ls)
				return true
			else
				return false
			end
		end

		function luaY:check(ls, c)
			if ls.t.token ~= c then
				self:error_expected(ls, c)
			end
		end

		function luaY:checknext(ls, c)
			self:check(ls, c)
			luaX:next(ls)
		end

		function luaY:check_condition(ls, c, msg)
			if not c then luaX:syntaxerror(ls, msg) end
		end

		function luaY:check_match(ls, what, who, where)
			if not self:testnext(ls, what) then
				if where == ls.linenumber then
					self:error_expected(ls, what)
				else
					luaX:syntaxerror(ls, string.format(
						self.LUA_QS.." expected (to close "..self.LUA_QS.." at line %d)",
						luaX:token2str(ls, what), luaX:token2str(ls, who), where))
				end
			end
		end

		function luaY:str_checkname(ls)
			self:check(ls, "TK_NAME")
			local ts = ls.t.seminfo
			luaX:next(ls)
			return ts
		end

		function luaY:init_exp(e, k, i)
			e.f, e.t = luaK.NO_JUMP, luaK.NO_JUMP
			e.k = k
			e.info = i
		end

		function luaY:codestring(ls, e, s)
			self:init_exp(e, "VK", luaK:stringK(ls.fs, s))
		end

		function luaY:checkname(ls, e)
			self:codestring(ls, e, self:str_checkname(ls))
		end

		function luaY:registerlocalvar(ls, varname)
			local fs = ls.fs
			local f = fs.f
			self:growvector(ls.L, f.locvars, fs.nlocvars, f.sizelocvars,
				nil, self.SHRT_MAX, "too many local variables")

			f.locvars[fs.nlocvars] = {} 
			f.locvars[fs.nlocvars].varname = varname

			local nlocvars = fs.nlocvars
			fs.nlocvars = fs.nlocvars + 1
			return nlocvars
		end

		function luaY:new_localvarliteral(ls, v, n)
			self:new_localvar(ls, v, n)
		end

		function luaY:new_localvar(ls, name, n)
			local fs = ls.fs
			self:checklimit(fs, fs.nactvar + n + 1, self.LUAI_MAXVARS, "local variables")
			fs.actvar[fs.nactvar + n] = self:registerlocalvar(ls, name)
		end

		function luaY:adjustlocalvars(ls, nvars)
			local fs = ls.fs
			fs.nactvar = fs.nactvar + nvars
			for i = nvars, 1, -1 do
				self:getlocvar(fs, fs.nactvar - i).startpc = fs.pc
			end
		end

		function luaY:removevars(ls, tolevel)
			local fs = ls.fs
			while fs.nactvar > tolevel do
				fs.nactvar = fs.nactvar - 1
				self:getlocvar(fs, fs.nactvar).endpc = fs.pc
			end
		end

		function luaY:indexupvalue(fs, name, v)
			local f = fs.f
			for i = 0, f.nups - 1 do
				if fs.upvalues[i].k == v.k and fs.upvalues[i].info == v.info then
					lua_assert(f.upvalues[i] == name)
					return i
				end
			end

			self:checklimit(fs, f.nups + 1, self.LUAI_MAXUPVALUES, "upvalues")
			self:growvector(fs.L, f.upvalues, f.nups, f.sizeupvalues,
				nil, self.MAX_INT, "")

			f.upvalues[f.nups] = name

			lua_assert(v.k == "VLOCAL" or v.k == "VUPVAL")

			fs.upvalues[f.nups] = { k = v.k, info = v.info }
			local nups = f.nups
			f.nups = f.nups + 1
			return nups
		end

		function luaY:searchvar(fs, n)
			for i = fs.nactvar - 1, 0, -1 do
				if n == self:getlocvar(fs, i).varname then
					return i
				end
			end
			return -1  
		end

		function luaY:markupval(fs, level)
			local bl = fs.bl
			while bl and bl.nactvar > level do bl = bl.previous end
			if bl then bl.upval = true end
		end

		function luaY:singlevaraux(fs, n, var, base)
			if fs == nil then  
				self:init_exp(var, "VGLOBAL", luaP.NO_REG)  
				return "VGLOBAL"
			else
				local v = self:searchvar(fs, n)  
				if v >= 0 then
					self:init_exp(var, "VLOCAL", v)
					if base == 0 then
						self:markupval(fs, v)  
					end
					return "VLOCAL"
				else  
					if self:singlevaraux(fs.prev, n, var, 0) == "VGLOBAL" then
						return "VGLOBAL"
					end
					var.info = self:indexupvalue(fs, n, var)  
					var.k = "VUPVAL"  
					return "VUPVAL"
				end
			end
		end

		function luaY:singlevar(ls, var)
			local varname = self:str_checkname(ls)
			local fs = ls.fs
			if self:singlevaraux(fs, varname, var, 1) == "VGLOBAL" then
				var.info = luaK:stringK(fs, varname)  
			end
		end

		function luaY:adjust_assign(ls, nvars, nexps, e)
			local fs = ls.fs
			local extra = nvars - nexps
			if self:hasmultret(e.k) then
				extra = extra + 1  
				if extra <= 0 then extra = 0 end
				luaK:setreturns(fs, e, extra)  
				if extra > 1 then luaK:reserveregs(fs, extra - 1) end
			else
				if e.k ~= "VVOID" then luaK:exp2nextreg(fs, e) end  
				if extra > 0 then
					local reg = fs.freereg
					luaK:reserveregs(fs, extra)
					luaK:_nil(fs, reg, extra)
				end
			end
		end

		function luaY:enterlevel(ls)
			ls.L.nCcalls = ls.L.nCcalls + 1
			if ls.L.nCcalls > self.LUAI_MAXCCALLS then
				luaX:lexerror(ls, "chunk has too many syntax levels", 0)
			end
		end

		function luaY:leavelevel(ls)
			ls.L.nCcalls = ls.L.nCcalls - 1
		end

		function luaY:enterblock(fs, bl, isbreakable)
			bl.breaklist = luaK.NO_JUMP
			bl.isbreakable = isbreakable
			bl.nactvar = fs.nactvar
			bl.upval = false
			bl.previous = fs.bl
			fs.bl = bl
			lua_assert(fs.freereg == fs.nactvar)
		end

		function luaY:leaveblock(fs)
			local bl = fs.bl
			fs.bl = bl.previous
			self:removevars(fs.ls, bl.nactvar)
			if bl.upval then
				luaK:codeABC(fs, "OP_CLOSE", bl.nactvar, 0, 0)
			end

			lua_assert(not bl.isbreakable or not bl.upval)
			lua_assert(bl.nactvar == fs.nactvar)
			fs.freereg = fs.nactvar  
			luaK:patchtohere(fs, bl.breaklist)
		end

		function luaY:pushclosure(ls, func, v)
			local fs = ls.fs
			local f = fs.f
			self:growvector(ls.L, f.p, fs.np, f.sizep, nil,
				luaP.MAXARG_Bx, "constant table overflow")

			f.p[fs.np] = func.f
			fs.np = fs.np + 1

			self:init_exp(v, "VRELOCABLE", luaK:codeABx(fs, "OP_CLOSURE", 0, fs.np - 1))
			for i = 0, func.f.nups - 1 do
				local o = (func.upvalues[i].k == "VLOCAL") and "OP_MOVE" or "OP_GETUPVAL"
				luaK:codeABC(fs, o, 0, func.upvalues[i].info, 0)
			end
		end

		function luaY:open_func(ls, fs)
			local L = ls.L
			local f = self:newproto(ls.L)
			fs.f = f
			fs.prev = ls.fs  
			fs.ls = ls
			fs.L = L
			ls.fs = fs
			fs.pc = 0
			fs.lasttarget = -1
			fs.jpc = luaK.NO_JUMP
			fs.freereg = 0
			fs.nk = 0
			fs.np = 0
			fs.nlocvars = 0
			fs.nactvar = 0
			fs.bl = nil
			f.source = ls.source
			f.maxstacksize = 2  
			fs.h = {}  

		end

		function luaY:close_func(ls)
			local L = ls.L
			local fs = ls.fs
			local f = fs.f
			self:removevars(ls, 0)
			luaK:ret(fs, 0, 0)  

			f.sizecode = fs.pc
			f.sizelineinfo = fs.pc
			f.sizek = fs.nk
			f.sizep = fs.np
			f.sizelocvars = fs.nlocvars
			f.sizeupvalues = f.nups

			lua_assert(fs.bl == nil)
			ls.fs = fs.prev

			if fs then self:anchor_token(ls) end
		end

		function luaY:parser(L, z, buff, name)
			local lexstate = {}  
			lexstate.t = {}
			lexstate.lookahead = {}
			local funcstate = {}  
			funcstate.upvalues = {}
			funcstate.actvar = {}

			L.nCcalls = 0
			lexstate.buff = buff
			luaX:setinput(L, lexstate, z, name)
			self:open_func(lexstate, funcstate)
			funcstate.f.is_vararg = self.VARARG_ISVARARG  
			luaX:next(lexstate)  
			self:chunk(lexstate)
			self:check(lexstate, "TK_EOS")
			self:close_func(lexstate)
			lua_assert(funcstate.prev == nil)
			lua_assert(funcstate.f.nups == 0)
			lua_assert(lexstate.fs == nil)
			return funcstate.f
		end

		function luaY:field(ls, v)

			local fs = ls.fs
			local key = {}  
			luaK:exp2anyreg(fs, v)
			luaX:next(ls)  
			self:checkname(ls, key)
			luaK:indexed(fs, v, key)
		end

		function luaY:yindex(ls, v)

			luaX:next(ls)  
			self:expr(ls, v)
			luaK:exp2val(ls.fs, v)
			self:checknext(ls, "]")
		end

		function luaY:recfield(ls, cc)

			local fs = ls.fs
			local reg = ls.fs.freereg
			local key, val = {}, {}  
			if ls.t.token == "TK_NAME" then
				self:checklimit(fs, cc.nh, self.MAX_INT, "items in a constructor")
				self:checkname(ls, key)
			else  
				self:yindex(ls, key)
			end
			cc.nh = cc.nh + 1
			self:checknext(ls, "=")
			local rkkey = luaK:exp2RK(fs, key)
			self:expr(ls, val)
			luaK:codeABC(fs, "OP_SETTABLE", cc.t.info, rkkey, luaK:exp2RK(fs, val))
			fs.freereg = reg  
		end

		function luaY:closelistfield(fs, cc)
			if cc.v.k == "VVOID" then return end  
			luaK:exp2nextreg(fs, cc.v)
			cc.v.k = "VVOID"
			if cc.tostore == luaP.LFIELDS_PER_FLUSH then
				luaK:setlist(fs, cc.t.info, cc.na, cc.tostore)  
				cc.tostore = 0  
			end
		end

		function luaY:lastlistfield(fs, cc)
			if cc.tostore == 0 then return end
			if self:hasmultret(cc.v.k) then
				luaK:setmultret(fs, cc.v)
				luaK:setlist(fs, cc.t.info, cc.na, self.LUA_MULTRET)
				cc.na = cc.na - 1  
			else
				if cc.v.k ~= "VVOID" then
					luaK:exp2nextreg(fs, cc.v)
				end
				luaK:setlist(fs, cc.t.info, cc.na, cc.tostore)
			end
		end

		function luaY:listfield(ls, cc)
			self:expr(ls, cc.v)
			self:checklimit(ls.fs, cc.na, self.MAX_INT, "items in a constructor")
			cc.na = cc.na + 1
			cc.tostore = cc.tostore + 1
		end

		function luaY:constructor(ls, t)

			local fs = ls.fs
			local line = ls.linenumber
			local pc = luaK:codeABC(fs, "OP_NEWTABLE", 0, 0, 0)
			local cc = {}  
			cc.v = {}
			cc.na, cc.nh, cc.tostore = 0, 0, 0
			cc.t = t
			self:init_exp(t, "VRELOCABLE", pc)
			self:init_exp(cc.v, "VVOID", 0)  
			luaK:exp2nextreg(ls.fs, t)  
			self:checknext(ls, "{")
			repeat
				lua_assert(cc.v.k == "VVOID" or cc.tostore > 0)
				if ls.t.token == "}" then break end
				self:closelistfield(fs, cc)
				local c = ls.t.token

				if c == "TK_NAME" then  
					luaX:lookahead(ls)
					if ls.lookahead.token ~= "=" then  
						self:listfield(ls, cc)
					else
						self:recfield(ls, cc)
					end
				elseif c == "[" then  
					self:recfield(ls, cc)
				else  
					self:listfield(ls, cc)
				end
			until not self:testnext(ls, ",") and not self:testnext(ls, ";")
			self:check_match(ls, "}", "{", line)
			self:lastlistfield(fs, cc)
			luaP:SETARG_B(fs.f.code[pc], self:int2fb(cc.na)) 
			luaP:SETARG_C(fs.f.code[pc], self:int2fb(cc.nh)) 
		end

		function luaY:parlist(ls)

			local fs = ls.fs
			local f = fs.f
			local nparams = 0
			f.is_vararg = 0
			if ls.t.token ~= ")" then  
				repeat
					local c = ls.t.token
					if c == "TK_NAME" then  
						self:new_localvar(ls, self:str_checkname(ls), nparams)
						nparams = nparams + 1
					elseif c == "TK_DOTS" then  
						luaX:next(ls)

						self:new_localvarliteral(ls, "arg", nparams)
						nparams = nparams + 1
						f.is_vararg = self.VARARG_HASARG + self.VARARG_NEEDSARG

						f.is_vararg = f.is_vararg + self.VARARG_ISVARARG
					else
						luaX:syntaxerror(ls, "<name> or "..self:LUA_QL("...").." expected")
					end
				until f.is_vararg ~= 0 or not self:testnext(ls, ",")
			end
			self:adjustlocalvars(ls, nparams)

			f.numparams = fs.nactvar - (f.is_vararg % self.HASARG_MASK)
			luaK:reserveregs(fs, fs.nactvar)  
		end

		function luaY:body(ls, e, needself, line)

			local new_fs = {}  
			new_fs.upvalues = {}
			new_fs.actvar = {}
			self:open_func(ls, new_fs)
			new_fs.f.lineDefined = line
			self:checknext(ls, "(")
			if needself then
				self:new_localvarliteral(ls, "self", 0)
				self:adjustlocalvars(ls, 1)
			end
			self:parlist(ls)
			self:checknext(ls, ")")
			self:chunk(ls)
			new_fs.f.lastlinedefined = ls.linenumber
			self:check_match(ls, "TK_END", "TK_FUNCTION", line)
			self:close_func(ls)
			self:pushclosure(ls, new_fs, e)
		end

		function luaY:explist1(ls, v)

			local n = 1  
			self:expr(ls, v)
			while self:testnext(ls, ",") do
				luaK:exp2nextreg(ls.fs, v)
				self:expr(ls, v)
				n = n + 1
			end
			return n
		end

		function luaY:funcargs(ls, f)
			local fs = ls.fs
			local args = {}  
			local nparams
			local line = ls.linenumber
			local c = ls.t.token
			if c == "(" then  
				if line ~= ls.lastline then
					luaX:syntaxerror(ls, "ambiguous syntax (function call x new statement)")
				end
				luaX:next(ls)
				if ls.t.token == ")" then  
					args.k = "VVOID"
				else
					self:explist1(ls, args)
					luaK:setmultret(fs, args)
				end
				self:check_match(ls, ")", "(", line)
			elseif c == "{" then  
				self:constructor(ls, args)
			elseif c == "TK_STRING" then  
				self:codestring(ls, args, ls.t.seminfo)
				luaX:next(ls)  
			else
				luaX:syntaxerror(ls, "function arguments expected")
				return
			end
			lua_assert(f.k == "VNONRELOC")
			local base = f.info  
			if self:hasmultret(args.k) then
				nparams = self.LUA_MULTRET  
			else
				if args.k ~= "VVOID" then
					luaK:exp2nextreg(fs, args)  
				end
				nparams = fs.freereg - (base + 1)
			end
			self:init_exp(f, "VCALL", luaK:codeABC(fs, "OP_CALL", base, nparams + 1, 2))
			luaK:fixline(fs, line)
			fs.freereg = base + 1  

		end

		function luaY:prefixexp(ls, v)

			local c = ls.t.token
			if c == "(" then
				local line = ls.linenumber
				luaX:next(ls)
				self:expr(ls, v)
				self:check_match(ls, ")", "(", line)
				luaK:dischargevars(ls.fs, v)
			elseif c == "TK_NAME" then
				self:singlevar(ls, v)
			else
				luaX:syntaxerror(ls, "unexpected symbol")
			end
			return
		end

		function luaY:primaryexp(ls, v)

			local fs = ls.fs
			self:prefixexp(ls, v)
			while true do
				local c = ls.t.token
				if c == "." then  
					self:field(ls, v)
				elseif c == "[" then  
					local key = {}  
					luaK:exp2anyreg(fs, v)
					self:yindex(ls, key)
					luaK:indexed(fs, v, key)
				elseif c == ":" then  
					local key = {}  
					luaX:next(ls)
					self:checkname(ls, key)
					luaK:_self(fs, v, key)
					self:funcargs(ls, v)
				elseif c == "(" or c == "TK_STRING" or c == "{" then  
					luaK:exp2nextreg(fs, v)
					self:funcargs(ls, v)
				else
					return
				end
			end
		end

		function luaY:simpleexp(ls, v)

			local c = ls.t.token
			if c == "TK_NUMBER" then
				self:init_exp(v, "VKNUM", 0)
				v.nval = ls.t.seminfo
			elseif c == "TK_STRING" then
				self:codestring(ls, v, ls.t.seminfo)
			elseif c == "TK_NIL" then
				self:init_exp(v, "VNIL", 0)
			elseif c == "TK_TRUE" then
				self:init_exp(v, "VTRUE", 0)
			elseif c == "TK_FALSE" then
				self:init_exp(v, "VFALSE", 0)
			elseif c == "TK_DOTS" then  
				local fs = ls.fs
				self:check_condition(ls, fs.f.is_vararg ~= 0,
					"cannot use "..self:LUA_QL("...").." outside a vararg function");

				local is_vararg = fs.f.is_vararg
				if is_vararg >= self.VARARG_NEEDSARG then
					fs.f.is_vararg = is_vararg - self.VARARG_NEEDSARG  
				end
				self:init_exp(v, "VVARARG", luaK:codeABC(fs, "OP_VARARG", 0, 1, 0))
			elseif c == "{" then  
				self:constructor(ls, v)
				return
			elseif c == "TK_FUNCTION" then
				luaX:next(ls)
				self:body(ls, v, false, ls.linenumber)
				return
			else
				self:primaryexp(ls, v)
				return
			end
			luaX:next(ls)
		end

		function luaY:getunopr(op)
			if op == "TK_NOT" then
				return "OPR_NOT"
			elseif op == "-" then
				return "OPR_MINUS"
			elseif op == "#" then
				return "OPR_LEN"
			else
				return "OPR_NOUNOPR"
			end
		end

		luaY.getbinopr_table = {
			["+"] = "OPR_ADD",
			["-"] = "OPR_SUB",
			["*"] = "OPR_MUL",
			["/"] = "OPR_DIV",
			["%"] = "OPR_MOD",
			["^"] = "OPR_POW",
			["TK_CONCAT"] = "OPR_CONCAT",
			["TK_NE"] = "OPR_NE",
			["TK_EQ"] = "OPR_EQ",
			["<"] = "OPR_LT",
			["TK_LE"] = "OPR_LE",
			[">"] = "OPR_GT",
			["TK_GE"] = "OPR_GE",
			["TK_AND"] = "OPR_AND",
			["TK_OR"] = "OPR_OR",
		}
		function luaY:getbinopr(op)
			local opr = self.getbinopr_table[op]
			if opr then return opr else return "OPR_NOBINOPR" end
		end

		luaY.priority = {
			{6, 6}, {6, 6}, {7, 7}, {7, 7}, {7, 7}, 
			{10, 9}, {5, 4},                 
			{3, 3}, {3, 3},                  
			{3, 3}, {3, 3}, {3, 3}, {3, 3},  
			{2, 2}, {1, 1}                   
		}

		luaY.UNARY_PRIORITY = 8  

		function luaY:subexpr(ls, v, limit)
			self:enterlevel(ls)
			local uop = self:getunopr(ls.t.token)
			if uop ~= "OPR_NOUNOPR" then
				luaX:next(ls)
				self:subexpr(ls, v, self.UNARY_PRIORITY)
				luaK:prefix(ls.fs, uop, v)
			else
				self:simpleexp(ls, v)
			end

			local op = self:getbinopr(ls.t.token)
			while op ~= "OPR_NOBINOPR" and self.priority[luaK.BinOpr[op] + 1][1] > limit do
				local v2 = {}  
				luaX:next(ls)
				luaK:infix(ls.fs, op, v)

				local nextop = self:subexpr(ls, v2, self.priority[luaK.BinOpr[op] + 1][2])
				luaK:posfix(ls.fs, op, v, v2)
				op = nextop
			end
			self:leavelevel(ls)
			return op  
		end

		function luaY:expr(ls, v)
			self:subexpr(ls, v, 0)
		end

		function luaY:block_follow(token)
			if token == "TK_ELSE" or token == "TK_ELSEIF" or token == "TK_END"
				or token == "TK_UNTIL" or token == "TK_EOS" then
				return true
			else
				return false
			end
		end

		function luaY:block(ls)

			local fs = ls.fs
			local bl = {}  
			self:enterblock(fs, bl, false)
			self:chunk(ls)
			lua_assert(bl.breaklist == luaK.NO_JUMP)
			self:leaveblock(fs)
		end

		function luaY:check_conflict(ls, lh, v)
			local fs = ls.fs
			local extra = fs.freereg  
			local conflict = false
			while lh do
				if lh.v.k == "VINDEXED" then
					if lh.v.info == v.info then  
						conflict = true
						lh.v.info = extra  
					end
					if lh.v.aux == v.info then  
						conflict = true
						lh.v.aux = extra  
					end
				end
				lh = lh.prev
			end
			if conflict then
				luaK:codeABC(fs, "OP_MOVE", fs.freereg, v.info, 0)  
				luaK:reserveregs(fs, 1)
			end
		end

		function luaY:assignment(ls, lh, nvars)
			local e = {}  

			local c = lh.v.k
			self:check_condition(ls, c == "VLOCAL" or c == "VUPVAL" or c == "VGLOBAL"
				or c == "VINDEXED", "syntax error")
			if self:testnext(ls, ",") then  
				local nv = {}  
				nv.v = {}
				nv.prev = lh
				self:primaryexp(ls, nv.v)
				if nv.v.k == "VLOCAL" then
					self:check_conflict(ls, lh, nv.v)
				end
				self:checklimit(ls.fs, nvars, self.LUAI_MAXCCALLS - ls.L.nCcalls,
					"variables in assignment")
				self:assignment(ls, nv, nvars + 1)
			else  
				self:checknext(ls, "=")
				local nexps = self:explist1(ls, e)
				if nexps ~= nvars then
					self:adjust_assign(ls, nvars, nexps, e)
					if nexps > nvars then
						ls.fs.freereg = ls.fs.freereg - (nexps - nvars)  
					end
				else
					luaK:setoneret(ls.fs, e)  
					luaK:storevar(ls.fs, lh.v, e)
					return  
				end
			end
			self:init_exp(e, "VNONRELOC", ls.fs.freereg - 1)  
			luaK:storevar(ls.fs, lh.v, e)
		end

		function luaY:cond(ls)

			local v = {}  
			self:expr(ls, v)  
			if v.k == "VNIL" then v.k = "VFALSE" end  
			luaK:goiftrue(ls.fs, v)
			return v.f
		end

		function luaY:breakstat(ls)

			local fs = ls.fs
			local bl = fs.bl
			local upval = false
			while bl and not bl.isbreakable do
				if bl.upval then upval = true end
				bl = bl.previous
			end
			if not bl then
				luaX:syntaxerror(ls, "no loop to break")
			end
			if upval then
				luaK:codeABC(fs, "OP_CLOSE", bl.nactvar, 0, 0)
			end
			bl.breaklist = luaK:concat(fs, bl.breaklist, luaK:jump(fs))
		end

		function luaY:whilestat(ls, line)

			local fs = ls.fs
			local bl = {}  
			luaX:next(ls)  
			local whileinit = luaK:getlabel(fs)
			local condexit = self:cond(ls)
			self:enterblock(fs, bl, true)
			self:checknext(ls, "TK_DO")
			self:block(ls)
			luaK:patchlist(fs, luaK:jump(fs), whileinit)
			self:check_match(ls, "TK_END", "TK_WHILE", line)
			self:leaveblock(fs)
			luaK:patchtohere(fs, condexit)  
		end

		function luaY:repeatstat(ls, line)

			local fs = ls.fs
			local repeat_init = luaK:getlabel(fs)
			local bl1, bl2 = {}, {}  
			self:enterblock(fs, bl1, true)  
			self:enterblock(fs, bl2, false)  
			luaX:next(ls)  
			self:chunk(ls)
			self:check_match(ls, "TK_UNTIL", "TK_REPEAT", line)
			local condexit = self:cond(ls)  
			if not bl2.upval then  
				self:leaveblock(fs)  
				luaK:patchlist(ls.fs, condexit, repeat_init)  
			else  
				self:breakstat(ls)  
				luaK:patchtohere(ls.fs, condexit)  
				self:leaveblock(fs)  
				luaK:patchlist(ls.fs, luaK:jump(fs), repeat_init)  
			end
			self:leaveblock(fs)  
		end

		function luaY:exp1(ls)
			local e = {}  
			self:expr(ls, e)
			local k = e.k
			luaK:exp2nextreg(ls.fs, e)
			return k
		end

		function luaY:forbody(ls, base, line, nvars, isnum)

			local bl = {}  
			local fs = ls.fs
			self:adjustlocalvars(ls, 3)  
			self:checknext(ls, "TK_DO")
			local prep = isnum and luaK:codeAsBx(fs, "OP_FORPREP", base, luaK.NO_JUMP)
				or luaK:jump(fs)
			self:enterblock(fs, bl, false)  
			self:adjustlocalvars(ls, nvars)
			luaK:reserveregs(fs, nvars)
			self:block(ls)
			self:leaveblock(fs)  
			luaK:patchtohere(fs, prep)
			local endfor = isnum and luaK:codeAsBx(fs, "OP_FORLOOP", base, luaK.NO_JUMP)
				or luaK:codeABC(fs, "OP_TFORLOOP", base, 0, nvars)
			luaK:fixline(fs, line)  
			luaK:patchlist(fs, isnum and endfor or luaK:jump(fs), prep + 1)
		end

		function luaY:fornum(ls, varname, line)

			local fs = ls.fs
			local base = fs.freereg
			self:new_localvarliteral(ls, "(for index)", 0)
			self:new_localvarliteral(ls, "(for limit)", 1)
			self:new_localvarliteral(ls, "(for step)", 2)
			self:new_localvar(ls, varname, 3)
			self:checknext(ls, '=')
			self:exp1(ls)  
			self:checknext(ls, ",")
			self:exp1(ls)  
			if self:testnext(ls, ",") then
				self:exp1(ls)  
			else  
				luaK:codeABx(fs, "OP_LOADK", fs.freereg, luaK:numberK(fs, 1))
				luaK:reserveregs(fs, 1)
			end
			self:forbody(ls, base, line, 1, true)
		end

		function luaY:forlist(ls, indexname)

			local fs = ls.fs
			local e = {}  
			local nvars = 0
			local base = fs.freereg

			self:new_localvarliteral(ls, "(for generator)", nvars)
			nvars = nvars + 1
			self:new_localvarliteral(ls, "(for state)", nvars)
			nvars = nvars + 1
			self:new_localvarliteral(ls, "(for control)", nvars)
			nvars = nvars + 1

			self:new_localvar(ls, indexname, nvars)
			nvars = nvars + 1
			while self:testnext(ls, ",") do
				self:new_localvar(ls, self:str_checkname(ls), nvars)
				nvars = nvars + 1
			end
			self:checknext(ls, "TK_IN")
			local line = ls.linenumber
			self:adjust_assign(ls, 3, self:explist1(ls, e), e)
			luaK:checkstack(fs, 3)  
			self:forbody(ls, base, line, nvars - 3, false)
		end

		function luaY:forstat(ls, line)

			local fs = ls.fs
			local bl = {}  
			self:enterblock(fs, bl, true)  
			luaX:next(ls)  
			local varname = self:str_checkname(ls)  
			local c = ls.t.token
			if c == "=" then
				self:fornum(ls, varname, line)
			elseif c == "," or c == "TK_IN" then
				self:forlist(ls, varname)
			else
				luaX:syntaxerror(ls, self:LUA_QL("=").." or "..self:LUA_QL("in").." expected")
			end
			self:check_match(ls, "TK_END", "TK_FOR", line)
			self:leaveblock(fs)  
		end

		function luaY:test_then_block(ls)

			luaX:next(ls)  
			local condexit = self:cond(ls)
			self:checknext(ls, "TK_THEN")
			self:block(ls)  
			return condexit
		end

		function luaY:ifstat(ls, line)

			local fs = ls.fs
			local escapelist = luaK.NO_JUMP
			local flist = self:test_then_block(ls)  
			while ls.t.token == "TK_ELSEIF" do
				escapelist = luaK:concat(fs, escapelist, luaK:jump(fs))
				luaK:patchtohere(fs, flist)
				flist = self:test_then_block(ls)  
			end
			if ls.t.token == "TK_ELSE" then
				escapelist = luaK:concat(fs, escapelist, luaK:jump(fs))
				luaK:patchtohere(fs, flist)
				luaX:next(ls)  
				self:block(ls)  
			else
				escapelist = luaK:concat(fs, escapelist, flist)
			end
			luaK:patchtohere(fs, escapelist)
			self:check_match(ls, "TK_END", "TK_IF", line)
		end

		function luaY:localfunc(ls)
			local v, b = {}, {}  
			local fs = ls.fs
			self:new_localvar(ls, self:str_checkname(ls), 0)
			self:init_exp(v, "VLOCAL", fs.freereg)
			luaK:reserveregs(fs, 1)
			self:adjustlocalvars(ls, 1)
			self:body(ls, b, false, ls.linenumber)
			luaK:storevar(fs, v, b)

			self:getlocvar(fs, fs.nactvar - 1).startpc = fs.pc
		end

		function luaY:localstat(ls)

			local nvars = 0
			local nexps
			local e = {}  
			repeat
				self:new_localvar(ls, self:str_checkname(ls), nvars)
				nvars = nvars + 1
			until not self:testnext(ls, ",")
			if self:testnext(ls, "=") then
				nexps = self:explist1(ls, e)
			else
				e.k = "VVOID"
				nexps = 0
			end
			self:adjust_assign(ls, nvars, nexps, e)
			self:adjustlocalvars(ls, nvars)
		end

		function luaY:funcname(ls, v)

			local needself = false
			self:singlevar(ls, v)
			while ls.t.token == "." do
				self:field(ls, v)
			end
			if ls.t.token == ":" then
				needself = true
				self:field(ls, v)
			end
			return needself
		end

		function luaY:funcstat(ls, line)

			local v, b = {}, {}  
			luaX:next(ls)  
			local needself = self:funcname(ls, v)
			self:body(ls, b, needself, line)
			luaK:storevar(ls.fs, v, b)
			luaK:fixline(ls.fs, line)  
		end

		function luaY:exprstat(ls)

			local fs = ls.fs
			local v = {}  
			v.v = {}
			self:primaryexp(ls, v.v)
			if v.v.k == "VCALL" then  
				luaP:SETARG_C(luaK:getcode(fs, v.v), 1)  
			else  
				v.prev = nil
				self:assignment(ls, v, 1)
			end
		end

		function luaY:retstat(ls)

			local fs = ls.fs
			local e = {}  
			local first, nret  
			luaX:next(ls)  
			if self:block_follow(ls.t.token) or ls.t.token == ";" then
				first, nret = 0, 0  
			else
				nret = self:explist1(ls, e)  
				if self:hasmultret(e.k) then
					luaK:setmultret(fs, e)
					if e.k == "VCALL" and nret == 1 then  
						luaP:SET_OPCODE(luaK:getcode(fs, e), "OP_TAILCALL")
						lua_assert(luaP:GETARG_A(luaK:getcode(fs, e)) == fs.nactvar)
					end
					first = fs.nactvar
					nret = self.LUA_MULTRET  
				else
					if nret == 1 then  
						first = luaK:exp2anyreg(fs, e)
					else
						luaK:exp2nextreg(fs, e)  
						first = fs.nactvar  
						lua_assert(nret == fs.freereg - first)
					end
				end
			end
			luaK:ret(fs, first, nret)
		end

		function luaY:statement(ls)
			local line = ls.linenumber  
			local c = ls.t.token
			if c == "TK_IF" then  
				self:ifstat(ls, line)
				return false
			elseif c == "TK_WHILE" then  
				self:whilestat(ls, line)
				return false
			elseif c == "TK_DO" then  
				luaX:next(ls)  
				self:block(ls)
				self:check_match(ls, "TK_END", "TK_DO", line)
				return false
			elseif c == "TK_FOR" then  
				self:forstat(ls, line)
				return false
			elseif c == "TK_REPEAT" then  
				self:repeatstat(ls, line)
				return false
			elseif c == "TK_FUNCTION" then  
				self:funcstat(ls, line)
				return false
			elseif c == "TK_LOCAL" then  
				luaX:next(ls)  
				if self:testnext(ls, "TK_FUNCTION") then  
					self:localfunc(ls)
				else
					self:localstat(ls)
				end
				return false
			elseif c == "TK_RETURN" then  
				self:retstat(ls)
				return true  
			elseif c == "TK_BREAK" then  
				luaX:next(ls)  
				self:breakstat(ls)
				return true  
			else
				self:exprstat(ls)
				return false  
			end
		end

		function luaY:chunk(ls)

			local islast = false
			self:enterlevel(ls)
			while not islast and not self:block_follow(ls.t.token) do
				islast = self:statement(ls)
				self:testnext(ls, ";")
				lua_assert(ls.fs.f.maxstacksize >= ls.fs.freereg and
					ls.fs.freereg >= ls.fs.nactvar)
				ls.fs.freereg = ls.fs.nactvar  
			end
			self:leavelevel(ls)
		end

		luaX:init()  
		local LuaState = {}  

		return function (source, name)
			name = name or 'compiled-lua'

			local zio = luaZ:init(luaZ:make_getF(source), nil)
			if not zio then return end

			local func = luaY:parser(LuaState, zio, nil, "@"..name)

			local writer, buff = luaU:make_setS()

			luaU:dump(LuaState, func, writer, buff)

			return buff.data
		end
	end)()

	local createExecutable = coroutine.wrap(function()

		local bit = bit or bit32 or require('bit')

		if not table.create then function table.create(_) return {} end end

		if not table.unpack then table.unpack = unpack end

		if not table.pack then function table.pack(...) return {n = select('#', ...), ...} end end

		if not table.move then
			function table.move(src, first, last, offset, dst)
				for i = 0, last - first do dst[offset + i] = src[first + i] end
			end
		end

		local lua_bc_to_state
		local lua_wrap_state
		local stm_lua_func

		local FIELDS_PER_FLUSH = 50

		local OPCODE_RM = {

			[22] = 18, 
			[31] = 8, 
			[33] = 28, 

			[0] = 3, 
			[1] = 13, 
			[2] = 23, 
			[26] = 33, 

			[12] = 1, 
			[13] = 6, 
			[14] = 10, 
			[15] = 16, 
			[16] = 20, 
			[17] = 26, 
			[18] = 30, 
			[19] = 36, 

			[3] = 0, 
			[4] = 2, 
			[5] = 4, 
			[6] = 7, 
			[7] = 9, 
			[8] = 12, 
			[9] = 14, 
			[10] = 17, 
			[20] = 19, 
			[21] = 22, 
			[23] = 24, 
			[24] = 27, 
			[25] = 29, 
			[27] = 32, 
			[32] = 34, 
			[34] = 37, 

			[11] = 5, 
			[28] = 11, 
			[29] = 15, 
			[30] = 21, 
			[35] = 25, 
			[36] = 31, 
			[37] = 35, 
		}

		local OPCODE_T = {
			[0] = 'ABC',
			'ABx',
			'ABC',
			'ABC',
			'ABC',
			'ABx',
			'ABC',
			'ABx',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'AsBx',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'ABC',
			'AsBx',
			'AsBx',
			'ABC',
			'ABC',
			'ABC',
			'ABx',
			'ABC',
		}

		local OPCODE_M = {
			[0] = {b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgK', c = 'OpArgN'},
			{b = 'OpArgU', c = 'OpArgU'},
			{b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgU', c = 'OpArgN'},
			{b = 'OpArgK', c = 'OpArgN'},
			{b = 'OpArgR', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgN'},
			{b = 'OpArgU', c = 'OpArgN'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgU', c = 'OpArgU'},
			{b = 'OpArgR', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgR', c = 'OpArgR'},
			{b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgK', c = 'OpArgK'},
			{b = 'OpArgR', c = 'OpArgU'},
			{b = 'OpArgR', c = 'OpArgU'},
			{b = 'OpArgU', c = 'OpArgU'},
			{b = 'OpArgU', c = 'OpArgU'},
			{b = 'OpArgU', c = 'OpArgN'},
			{b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgR', c = 'OpArgN'},
			{b = 'OpArgN', c = 'OpArgU'},
			{b = 'OpArgU', c = 'OpArgU'},
			{b = 'OpArgN', c = 'OpArgN'},
			{b = 'OpArgU', c = 'OpArgN'},
			{b = 'OpArgU', c = 'OpArgN'},
		}

		local function rd_int_basic(src, s, e, d)
			local num = 0

			for i = s, e, d do
				local mul = 256 ^ math.abs(i - s)

				num = num + mul * string.byte(src, i, i)
			end

			return num
		end

		local function rd_flt_basic(f1, f2, f3, f4)
			local sign = (-1) ^ bit.rshift(f4, 7)
			local exp = bit.rshift(f3, 7) + bit.lshift(bit.band(f4, 0x7F), 1)
			local frac = f1 + bit.lshift(f2, 8) + bit.lshift(bit.band(f3, 0x7F), 16)
			local normal = 1

			if exp == 0 then
				if frac == 0 then
					return sign * 0
				else
					normal = 0
					exp = 1
				end
			elseif exp == 0x7F then
				if frac == 0 then
					return sign * (1 / 0)
				else
					return sign * (0 / 0)
				end
			end

			return sign * 2 ^ (exp - 127) * (1 + normal / 2 ^ 23)
		end

		local function rd_dbl_basic(f1, f2, f3, f4, f5, f6, f7, f8)
			local sign = (-1) ^ bit.rshift(f8, 7)
			local exp = bit.lshift(bit.band(f8, 0x7F), 4) + bit.rshift(f7, 4)
			local frac = bit.band(f7, 0x0F) * 2 ^ 48
			local normal = 1

			frac = frac + (f6 * 2 ^ 40) + (f5 * 2 ^ 32) + (f4 * 2 ^ 24) + (f3 * 2 ^ 16) + (f2 * 2 ^ 8) + f1 

			if exp == 0 then
				if frac == 0 then
					return sign * 0
				else
					normal = 0
					exp = 1
				end
			elseif exp == 0x7FF then
				if frac == 0 then
					return sign * (1 / 0)
				else
					return sign * (0 / 0)
				end
			end

			return sign * 2 ^ (exp - 1023) * (normal + frac / 2 ^ 52)
		end

		local function rd_int_le(src, s, e) return rd_int_basic(src, s, e - 1, 1) end

		local function rd_int_be(src, s, e) return rd_int_basic(src, e - 1, s, -1) end

		local function rd_flt_le(src, s) return rd_flt_basic(string.byte(src, s, s + 3)) end

		local function rd_flt_be(src, s)
			local f1, f2, f3, f4 = string.byte(src, s, s + 3)
			return rd_flt_basic(f4, f3, f2, f1)
		end

		local function rd_dbl_le(src, s) return rd_dbl_basic(string.byte(src, s, s + 7)) end

		local function rd_dbl_be(src, s)
			local f1, f2, f3, f4, f5, f6, f7, f8 = string.byte(src, s, s + 7) 
			return rd_dbl_basic(f8, f7, f6, f5, f4, f3, f2, f1)
		end

		local float_types = {
			[4] = {little = rd_flt_le, big = rd_flt_be},
			[8] = {little = rd_dbl_le, big = rd_dbl_be},
		}

		local function stm_byte(S)
			local idx = S.index
			local bt = string.byte(S.source, idx, idx)

			S.index = idx + 1
			return bt
		end

		local function stm_string(S, len)
			local pos = S.index + len
			local str = string.sub(S.source, S.index, pos - 1)

			S.index = pos
			return str
		end

		local function stm_lstring(S)
			local len = S:s_szt()
			local str

			if len ~= 0 then str = string.sub(stm_string(S, len), 1, -2) end

			return str
		end

		local function cst_int_rdr(len, func)
			return function(S)
				local pos = S.index + len
				local int = func(S.source, S.index, pos)
				S.index = pos

				return int
			end
		end

		local function cst_flt_rdr(len, func)
			return function(S)
				local flt = func(S.source, S.index)
				S.index = S.index + len

				return flt
			end
		end

		 function stm_inst_list(S)
			local len = S:s_int()
			local list = table.create(len)

			for i = 1, len do
				local ins = S:s_ins()
				local op = bit.band(ins, 0x3F)
				local args = OPCODE_T[op]
				local mode = OPCODE_M[op]
				local data = {value = ins, op = OPCODE_RM[op], A = bit.band(bit.rshift(ins, 6), 0xFF)}

				if args == 'ABC' then
					data.B = bit.band(bit.rshift(ins, 23), 0x1FF)
					data.C = bit.band(bit.rshift(ins, 14), 0x1FF)
					data.is_KB = mode.b == 'OpArgK' and data.B > 0xFF 
					data.is_KC = mode.c == 'OpArgK' and data.C > 0xFF
				elseif args == 'ABx' then
					data.Bx = bit.band(bit.rshift(ins, 14), 0x3FFFF)
					data.is_K = mode.b == 'OpArgK'
				elseif args == 'AsBx' then
					data.sBx = bit.band(bit.rshift(ins, 14), 0x3FFFF) - 131071
				end

				list[i] = data
			end

			return list
		end

		 function stm_const_list(S)
			local len = S:s_int()
			local list = table.create(len)

			for i = 1, len do
				local tt = stm_byte(S)
				local k

				if tt == 1 then
					k = stm_byte(S) ~= 0
				elseif tt == 3 then
					k = S:s_num()
				elseif tt == 4 then
					k = stm_lstring(S)
				end

				list[i] = k 
			end

			return list
		end

		local function stm_sub_list(S, src)
			local len = S:s_int()
			local list = table.create(len)

			for i = 1, len do
				list[i] = stm_lua_func(S, src) 
			end

			return list
		end

		local function stm_line_list(S)
			local len = S:s_int()
			local list = table.create(len)

			for i = 1, len do list[i] = S:s_int() end

			return list
		end

		local function stm_loc_list(S)
			local len = S:s_int()
			local list = table.create(len)

			for i = 1, len do list[i] = {varname = stm_lstring(S), startpc = S:s_int(), endpc = S:s_int()} end

			return list
		end

		local function stm_upval_list(S)
			local len = S:s_int()
			local list = table.create(len)

			for i = 1, len do list[i] = stm_lstring(S) end

			return list
		end

		function stm_lua_func(S, psrc)
			local proto = {}
			local src = stm_lstring(S) or psrc 

			proto.source = src 

			S:s_int() 
			S:s_int() 

			proto.num_upval = stm_byte(S) 
			proto.num_param = stm_byte(S) 

			stm_byte(S) 
			proto.max_stack = stm_byte(S) 

			proto.code = stm_inst_list(S)
			proto.const = stm_const_list(S)
			proto.subs = stm_sub_list(S, src)
			proto.lines = stm_line_list(S)

			stm_loc_list(S)
			stm_upval_list(S)

			for _, v in ipairs(proto.code) do
				if v.is_K then
					v.const = proto.const[v.Bx + 1] 
				else
					if v.is_KB then v.const_B = proto.const[v.B - 0xFF] end

					if v.is_KC then v.const_C = proto.const[v.C - 0xFF] end
				end
			end

			return proto
		end

		function lua_bc_to_state(src)

			local rdr_func

			local little
			local size_int
			local size_szt
			local size_ins
			local size_num
			local flag_int

			local stream = {

				index = 1,
				source = src,
			}

			assert(stm_string(stream, 4) == '\27Lua', 'invalid Lua signature')
			assert(stm_byte(stream) == 0x51, 'invalid Lua version')
			assert(stm_byte(stream) == 0, 'invalid Lua format')

			little = stm_byte(stream) ~= 0
			size_int = stm_byte(stream)
			size_szt = stm_byte(stream)
			size_ins = stm_byte(stream)
			size_num = stm_byte(stream)
			flag_int = stm_byte(stream) ~= 0

			rdr_func = little and rd_int_le or rd_int_be
			stream.s_int = cst_int_rdr(size_int, rdr_func)
			stream.s_szt = cst_int_rdr(size_szt, rdr_func)
			stream.s_ins = cst_int_rdr(size_ins, rdr_func)

			if flag_int then
				stream.s_num = cst_int_rdr(size_num, rdr_func)
			elseif float_types[size_num] then
				stream.s_num = cst_flt_rdr(size_num, float_types[size_num][little and 'little' or 'big'])
			else
				error('unsupported float size')
			end

			return stm_lua_func(stream, '@virtual')
		end

		local function close_lua_upvalues(list, index)
			for i, uv in pairs(list) do
				if uv.index >= index then
					uv.value = uv.store[uv.index] 
					uv.store = uv
					uv.index = 'value' 
					list[i] = nil
				end
			end
		end

		local function open_lua_upvalue(list, index, memory)
			local prev = list[index]

			if not prev then
				prev = {index = index, store = memory}
				list[index] = prev
			end

			return prev
		end

		local function on_lua_error(failed, err)
			local src = failed.source
			local line = failed.lines[failed.pc - 1]

			error(string.format('%s:%i: %s', src, line, err), 0)
		end

		local function run_lua_func(state, env, upvals)
			local code = state.code
			local subs = state.subs
			local vararg = state.vararg

			local top_index = -1
			local open_list = {}
			local memory = state.memory
			local pc = state.pc

			while true do
				local inst = code[pc]
				local op = inst.op
				pc = pc + 1

				if op < 18 then
					if op < 8 then
						if op < 3 then
							if op < 1 then

								for i = inst.A, inst.B do memory[i] = nil end
							elseif op > 1 then

								local uv = upvals[inst.B]

								memory[inst.A] = uv.store[uv.index]
							else

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								memory[inst.A] = lhs + rhs
							end
						elseif op > 3 then
							if op < 6 then
								if op > 4 then

									local A = inst.A
									local B = inst.B
									local index

									if inst.is_KC then
										index = inst.const_C
									else
										index = memory[inst.C]
									end

									memory[A + 1] = memory[B]
									memory[A] = memory[B][index]
								else

									memory[inst.A] = env[inst.const]
								end
							elseif op > 6 then

								local index

								if inst.is_KC then
									index = inst.const_C
								else
									index = memory[inst.C]
								end

								memory[inst.A] = memory[inst.B][index]
							else

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								memory[inst.A] = lhs - rhs
							end
						else 
							memory[inst.A] = memory[inst.B]
						end
					elseif op > 8 then
						if op < 13 then
							if op < 10 then

								env[inst.const] = memory[inst.A]
							elseif op > 10 then
								if op < 12 then

									local A = inst.A
									local B = inst.B
									local C = inst.C
									local params

									if B == 0 then
										params = top_index - A
									else
										params = B - 1
									end

									local ret_list = table.pack(memory[A](table.unpack(memory, A + 1, A + params)))
									local ret_num = ret_list.n

									if C == 0 then
										top_index = A + ret_num - 1
									else
										ret_num = C - 1
									end

									table.move(ret_list, 1, ret_num, A, memory)
								else

									local uv = upvals[inst.B]

									uv.store[uv.index] = memory[inst.A]
								end
							else

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								memory[inst.A] = lhs * rhs
							end
						elseif op > 13 then
							if op < 16 then
								if op > 14 then

									local A = inst.A
									local B = inst.B
									local params

									if B == 0 then
										params = top_index - A
									else
										params = B - 1
									end

									close_lua_upvalues(open_list, 0)

									return memory[A](table.unpack(memory, A + 1, A + params))
								else

									local index, value

									if inst.is_KB then
										index = inst.const_B
									else
										index = memory[inst.B]
									end

									if inst.is_KC then
										value = inst.const_C
									else
										value = memory[inst.C]
									end

									memory[inst.A][index] = value
								end
							elseif op > 16 then

								memory[inst.A] = {}
							else

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								memory[inst.A] = lhs / rhs
							end
						else

							memory[inst.A] = inst.const
						end
					else

						local A = inst.A
						local step = memory[A + 2]
						local index = memory[A] + step
						local limit = memory[A + 1]
						local loops

						if step == math.abs(step) then
							loops = index <= limit
						else
							loops = index >= limit
						end

						if loops then
							memory[A] = index
							memory[A + 3] = index
							pc = pc + inst.sBx
						end
					end
				elseif op > 18 then
					if op < 28 then
						if op < 23 then
							if op < 20 then

								memory[inst.A] = #memory[inst.B]
							elseif op > 20 then
								if op < 22 then

									local A = inst.A
									local B = inst.B
									local len

									if B == 0 then
										len = top_index - A + 1
									else
										len = B - 1
									end

									close_lua_upvalues(open_list, 0)

									return table.unpack(memory, A, A + len - 1)
								else

									local B = inst.B
									local str = memory[B]

									for i = B + 1, inst.C do str = str .. memory[i] end

									memory[inst.A] = str
								end
							else

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								memory[inst.A] = lhs % rhs
							end
						elseif op > 23 then
							if op < 26 then
								if op > 24 then

									close_lua_upvalues(open_list, inst.A)
								else

									local lhs, rhs

									if inst.is_KB then
										lhs = inst.const_B
									else
										lhs = memory[inst.B]
									end

									if inst.is_KC then
										rhs = inst.const_C
									else
										rhs = memory[inst.C]
									end

									if (lhs == rhs) == (inst.A ~= 0) then pc = pc + code[pc].sBx end

									pc = pc + 1
								end
							elseif op > 26 then

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								if (lhs < rhs) == (inst.A ~= 0) then pc = pc + code[pc].sBx end

								pc = pc + 1
							else

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								memory[inst.A] = lhs ^ rhs
							end
						else

							memory[inst.A] = inst.B ~= 0

							if inst.C ~= 0 then pc = pc + 1 end
						end
					elseif op > 28 then
						if op < 33 then
							if op < 30 then

								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = memory[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = memory[inst.C]
								end

								if (lhs <= rhs) == (inst.A ~= 0) then pc = pc + code[pc].sBx end

								pc = pc + 1
							elseif op > 30 then
								if op < 32 then

									local sub = subs[inst.Bx + 1] 
									local nups = sub.num_upval
									local uvlist

									if nups ~= 0 then
										uvlist = {}

										for i = 1, nups do
											local pseudo = code[pc + i - 1]

											if pseudo.op == OPCODE_RM[0] then 
												uvlist[i - 1] = open_lua_upvalue(open_list, pseudo.B, memory)
											elseif pseudo.op == OPCODE_RM[4] then 
												uvlist[i - 1] = upvals[pseudo.B]
											end
										end

										pc = pc + nups
									end

									memory[inst.A] = lua_wrap_state(sub, env, uvlist)
								else

									local A = inst.A
									local B = inst.B

									if (not memory[B]) ~= (inst.C ~= 0) then
										memory[A] = memory[B]
										pc = pc + code[pc].sBx
									end
									pc = pc + 1
								end
							else

								memory[inst.A] = -memory[inst.B]
							end
						elseif op > 33 then
							if op < 36 then
								if op > 34 then

									local A = inst.A
									local len = inst.B

									if len == 0 then
										len = vararg.len
										top_index = A + len - 1
									end

									table.move(vararg.list, 1, len, A, memory)
								else

									local A = inst.A
									local init, limit, step

									init = assert(tonumber(memory[A]), '`for` initial value must be a number')
									limit = assert(tonumber(memory[A + 1]), '`for` limit must be a number')
									step = assert(tonumber(memory[A + 2]), '`for` step must be a number')

									memory[A] = init - step
									memory[A + 1] = limit
									memory[A + 2] = step

									pc = pc + inst.sBx
								end
							elseif op > 36 then

								local A = inst.A
								local C = inst.C
								local len = inst.B
								local tab = memory[A]
								local offset

								if len == 0 then len = top_index - A end

								if C == 0 then
									C = inst[pc].value
									pc = pc + 1
								end

								offset = (C - 1) * FIELDS_PER_FLUSH

								table.move(memory, A + 1, A + len, offset + 1, tab)
							else

								memory[inst.A] = not memory[inst.B]
							end
						else

							if (not memory[inst.A]) ~= (inst.C ~= 0) then pc = pc + code[pc].sBx end
							pc = pc + 1
						end
					else

						local A = inst.A
						local base = A + 3

						local vals = {memory[A](memory[A + 1], memory[A + 2])}

						table.move(vals, 1, inst.C, base, memory)

						if memory[base] ~= nil then
							memory[A + 2] = memory[base]
							pc = pc + code[pc].sBx
						end

						pc = pc + 1
					end
				else

					pc = pc + inst.sBx
				end

				state.pc = pc
			end
		end

		function lua_wrap_state(proto, env, upval)
			local function wrapped(...)
				local passed = table.pack(...)
				local memory = table.create(proto.max_stack)
				local vararg = {len = 0, list = {}}

				table.move(passed, 1, proto.num_param, 0, memory)

				if proto.num_param < passed.n then
					local start = proto.num_param + 1
					local len = passed.n - proto.num_param

					vararg.len = len
					table.move(passed, start, start + len - 1, 1, vararg.list)
				end

				local state = {vararg = vararg, memory = memory, code = proto.code, subs = proto.subs, pc = 1}

				local result = table.pack(pcall(run_lua_func, state, env, upval))

				if result[1] then
					return table.unpack(result, 2, result.n)
				else
					local failed = {pc = state.pc, source = proto.source, lines = proto.lines}

					on_lua_error(failed, result[2])

					return
				end
			end

			return wrapped
		end

		return function(bCode, env)
			return lua_wrap_state(lua_bc_to_state(bCode), env or getfenv(0))
		end
	end)()

	return function(source, env)
		local executable
		local env = env or getfenv(2)
		local ran, failureReason = pcall(function()
			local compiledBytecode = compile(source,  "shg340934qh")
			executable = createExecutable(compiledBytecode, env)
		end)

		if ran then
			return setfenv(executable, env)
		end
		return nil, failureReason
	end
end)()
getgenv().clonefunc = clonefunction
clonefunc = getgenv().clonefunc
getgenv().getscripts = getrunningscripts
getscripts = getgenv().getscripts
getgenv().getmodules = getloadedmodules
getmodules = getgenv().getmodules
getgenv().httppost = function(URL, body, contenttype)
    return game:HttpPostAsync(URL, body, contenttype)
end
httppost = getgenv().httppost
ConsoleClone = nil
vim = Instance.new("VirtualInputManager")
getgenv().keyclick = function(key)
    if typeof(key) == "number" then
        if not keys[key] then
            return error("Key " .. tostring(key) .. " not found!")
        end
        vim:SendKeyEvent(true, keys[key], false, game)
        task.wait()
        vim:SendKeyEvent(false, keys[key], false, game)
    elseif typeof(Key) == "EnumItem" then
        vim:SendKeyEvent(true, key, false, game)
        task.wait()
        vim:SendKeyEvent(false, key, false, game)
    end
end
keyclick = getgenv().keyclick
getgenv().keypress = function(key)
    if typeof(key) == "number" then
        if not keys[key] then
            return error("Key " .. tostring(key) .. " not found!")
        end
        vim:SendKeyEvent(true, keys[key], false, game)
    elseif typeof(Key) == "EnumItem" then
        vim:SendKeyEvent(true, key, false, game)
    end
end
keypress = getgenv().keypress
getgenv().keyrelease = function(key)
    if typeof(key) == "number" then
        if not keys[key] then
            return error("Key " .. tostring(key) .. " not found!")
        end
        vim:SendKeyEvent(false, keys[key], false, game)
    elseif typeof(Key) == "EnumItem" then
        vim:SendKeyEvent(false, key, false, game)
    end
end
keyrelease = getgenv().keyrelease
getgenv().getscriptthread = function(script)
    if not script or not script:IsA("LocalScript") then
        error("Argument must be a LocalScript")
    end
    local thread = coroutine.create(function()
        script:Invoke()
    end)
    coroutine.resume(thread)
    return thread
end
getscriptthread = getgenv().getscriptthread
getgenv().setreadonly = function(taable, boolean)
    if boolean then
        table.freeze(taable)
    else
		disableprotections(taable)
    end
end
setreadonly = getgenv().setreadonly
getgenv().makereadonly = setreadonly
makereadonly = getgenv().makereadonly
getgenv().makewriteable = function(taable)
    return getgenv().setreadonly(taable, false)
end
makewriteable = getgenv().makewriteable
getgenv().randomstring = crypt.random
randomstring = getgenv().randomstring
getgenv().syn = {}
syn = getgenv().syn
getgenv().syn_backup = {}
syn_backup = getgenv().syn_backup
getgenv().syn.write_clipboard = setclipboard
protecteduis = {}
names = {} 
getgenv().syn.protect_gui = function(gui)
    names[gui] = {name = gui.Name, parent = gui.Parent}
    protecteduis[gui] = gui
    gui.Name = crypt.random(64)
    gui.Parent = gethui()
end
getgenv().syn.unprotect_gui = function(gui)
    if names[gui] then
        gui.Name = names[gui].name
        gui.Parent = names[gui].parent
    end
    protecteduis[gui] = nil
end
getgenv().syn.protectgui = getgenv().syn.protect_gui
getgenv().syn.unprotectgui = getgenv().syn.unprotect_gui
getgenv().syn.secure_call = function(func)
    return pcall(func)
end
getgenv().syn.crypt = getgenv().crypt
getgenv().syn.crypto = getgenv().crypt
getgenv().syn_backup = getgenv().syn
getgenv().syn.cache_replace = cache.replace 
getgenv().syn.cache_invalidate = cache.invalidate 
getgenv().syn.is_cached = cache.iscached 
getgenv().syn.set_thread_identity = setthreadidentity 
getgenv().syn.get_thread_identity = getthreadidentity 
getgenv().syn.queue_on_teleport = queueonteleport 
getgenv().syn.request = request 
getgenv().fluxus = {}
fluxus = getgenv().fluxus
getgenv().fluxus.request = request 
getgenv().fluxus.queue_on_teleport = queueonteleport
getgenv().fluxus.set_thread_identity = setthreadidentity 
getgenv().setrbxclipboard = setclipboard
setrbxclipboard = getgenv().setrbxclipboard
getgenv().writeclipboard = setclipboard
writeclipboard = getgenv().writeclipboard
getgenv().getprotecteduis = function()
    return protecteduis
end
getprotecteduis = getgenv().getprotecteduis
getgenv().getprotectedguis = getgenv().getprotecteduis
getprotectedguis = getgenv().getprotectedguis
getgenv().get_scripts = getrunningscripts
get_scripts = getgenv().get_scripts
getgenv().make_readonly = getgenv().makereadonly
make_readonly = getgenv().make_readonly
getgenv().is_l_closure = islclosure 
is_l_closure = getgenv().is_l_closure
getgenv().iswriteable = function(tbl)
    return not table.isfrozen(tbl)
end
iswriteable = getgenv().iswriteable
getgenv().string = string
string = getgenv().string
getgenv().dumpbytecode = getscriptbytecode 
dumpbytecode = getgenv().dumpbytecode
getgenv().loadfileasync = loadfile
loadfileasync = getgenv().loadfileasync
getgenv().clearconsole = rconsoleclear 
clearconsole = getgenv().clearconsole
getgenv().printconsole = rconsoleprint 
printconsole = getgenv().printconsole
getgenv().getsynasset = getcustomasset 
getsynasset = getgenv().getsynasset
getgenv().debug.getregistry = getreg 
getgenv().readfileasync = readfile 
readfileasync = getgenv().readfileasync
getgenv().writefileasync = writefile
writefileasync = getgenv().writefileasync
getgenv().appendfileasync = appendfile 
appendfileasync = getgenv().appendfileasync
getgenv().saveplace = saveinstance 
saveplace = getgenv().saveplace
getgenv().protect_gui = syn.protect_gui 
protect_gui = getgenv().protect_gui
getgenv().unprotect_gui = syn.unprotect_gui 
unprotect_gui = getgenv().unprotect_gui
getgenv().set_thread_identity = setthreadidentity 
set_thread_identity = getgenv().set_thread_identity
getgenv().get_thread_identity = getthreadidentity 
get_thread_identity = getgenv().get_thread_identity
setthreadidentity(8)

getgenv().debug.getconstant = function(f, i) 
    return "Not Implemented"
end 
getgenv().debug.getconstants = function(f) 
    return "Not Implemented"
end 
getgenv().debug.getproto = function(f, i, e) 
    return "Not Implemented"
end 
getgenv().debug.getprotos = function(f) 
    return "Not Implemented"
end 
getgenv().debug.getstack = function(f, i) 
    return "Not Implemented"
end 
getgenv().debug.getupvalue = function(f, i) 
    return "Not Implemented"
end 
getgenv().debug.getupvalues = function(f) 
    return "Not Implemented"
end 
getgenv().debug.setconstant = function(f, i, v) 
    return "Not Implemented"
end 
getgenv().debug.setstack = function(f, i, v) 
    return "Not Implemented"
end 
getgenv().debug.validlevel = function(f, i, v) 
    return "Not Implemented"
end 
getgenv().debug.getcallstack = function(f, i, v) 
    return "Not Implemented"
end 
getgenv().debug.isvalidlevel = getgenv().debug.validlevel
getgenv().is_our_closure = isexecutorclosure 
getgenv().issynapsefunction = isexecutorclosure
getgenv().run_on_actor = function(actor, code)
    local func, err = loadstring(code)
    if not func then
        return warn("no func?")
    end
    local success, exec = pcall(function()
        setfenv(func, getfenv()) 
        func()
    end)
    if not success then
        warn("execution failed: " .. tostring(exec))
    end
end


is_our_closure = getgenv().is_our_closure
issynapsefunction = getgenv().issynapsefunction
run_on_actor = getgenv().run_on_actor
keyshit = {}
getgenv().iskeydown = function(key)
    return keyshit[key] == true
end
iskeydown = getgenv().iskeydown
getgenv().iskeytoggled = function(key)
    return keyshit[key] == nil and false or keyshit[key]
end
iskeytoggled = getgenv().iskeytoggled
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            keyshit[input.KeyCode] = true
        end
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input, processed)
    if not processed then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            keyshit[input.KeyCode] = false
        end
    end
end)
getgenv().setfflag = function(fn, value)
    if not getgenv().ffs then
        getgenv().ffs = {}
    end
    getgenv().ffs[fn] = value
end
setfflag = getgenv().setfflag

getgenv().getfflag = function(fn)
    if getgenv().ffs and getgenv().ffs[fn] ~= nil then
        return getgenv().ffs[fn]
    else
        return nil  
    end
end
getfflag = getgenv().getfflag

getgenv().ogfs = {}
local ogfs = getgenv().ogfs
getgenv().restorefunction = function(original)
    if type(original) ~= "function" then
        error("The argument must be a function (original func).")
    end
    for name, func in pairs(getgenv().ogfs) do
        if func == original then
            getgenv()[name] = original  
            getgenv().ogfs[name] = nil  
            return
        end
    end
    error("No original function found to restore.")
end
restorefunction = getgenv().restorefunction

getgenv().isfunctionhooked = function(original)
    if type(original) ~= "function" then
        error("The argument must be a function (original func).")
    end
    for _, func in pairs(getgenv().ogfs) do
        if func == original then
            return true 
        end
    end
    return false  
end
isfunctionhooked = getgenv().isfunctionhooked
getgenv().hooksignal = function(signal, hook)
    if not signal or not hook or not signal.Connect then
        error("Invalid signal or hook function.")
    end
    return signal.Connect(signal, function(...)
        return hook(...)
    end)
end
hooksignal = getgenv().hooksignal
getgenv().hookfunction = function(original, hook)
    if type(original) ~= "function" then
        error("The first arg must be a function (original func).")
    end
    if type(hook) ~= "function" then
        error("The second arg must be a function (hook).")
    end
    local info = debug.getinfo(original)
    local name = info and info.name or tostring(original)
    getgenv().ogfs[name] = original 
    local hooked = function(...)
        return hook(...)
    end
    getgenv()[name] = hooked  
    return hooked
end
hookfunction = getgenv().hookfunction
getgenv().untouchedshit = {}
untouchedshit = getgenv().untouchedshit
getgenv().setuntouched = function(obj)
    getgenv().untouchedshit[obj] = true
end
setuntouched = getgenv().setuntouched	
getgenv().isuntouched = function(obj)
    return getgenv().untouchedshit[obj] == true
end
isuntouched = getgenv().isuntouched
getgenv().cfiresignal = function(signalName, ...)
    local signal = Instance.new("BindableEvent")
    signal.Name = signalName
    signal:Fire(...)
    return signal
end
cfiresignal = getgenv().cfiresignal
getgenv().replicatesignal = function(signal)
    if not signal or not signal:IsA("BindableEvent") then
        error("Invalid signal provided")
    end
    signal:Fire()
end
replicatesignal = getgenv().replicatesignal
getgenv().cansignalreplicate = function(signal)
    if typeof(signal) == "RBXScriptSignal" then
        return true 
    end
    return false 
end
cansignalreplicate = getgenv().cansignalreplicate
getgenv().clear_teleport_queue = function()
    queue_on_teleport("")
end 
clear_teleport_queue = getgenv().clear_teleport_queue
files = {}

function startswith(str, start)
	return str:sub(1, #start) == start
end

function endswith(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end


getgenv().writefile = function(path, content)
	local Path = path:split('/')
	local CurrentPath = {}
	for i = 1, #Path do
		local a = Path[i]
		CurrentPath[i] = a
		if not files[table.concat(CurrentPath, '/')] and i ~= #Path then
			files[table.concat(CurrentPath, '/')] = {}
			files[table.concat(CurrentPath, '/') .. '/'] = files[table.concat(CurrentPath, '/')]
		elseif i == #Path then
			files[table.concat(CurrentPath, '/')] = tostring(content)
		end
	end
end
writefile = getgenv().writefile

getgenv().makefolder = function(path)
	files[path] = {}
	files[path .. '/'] = files[path]
end
makefolder = getgenv().makefolder

getgenv().isfolder = function(path)
	return type(files[path]) == 'table'
end
isfolder = getgenv().isfolder

getgenv().isfile = function(path)
	return type(files[path]) == 'string'
end
isfile = getgenv().isfile

getgenv().readfile = function(path)
	return files[path]
end
readfile = getgenv().readfile

getgenv().loadfile = function(path)
	return loadstring(readfile(path))
end
loadfile = getgenv().loadfile

getgenv().appendfile = function(path, text)
	writefile(path, getgenv().readfile(path) .. text)
end
appendfile = getgenv().appendfile

getgenv().delfolder = function(path)
	local f = files[path]
	if type(f) == 'table' then
		files[path] = nil
	end
end
delfolder = getgenv().delfolder

getgenv().delfile = function(path)
	local f = files[path]
	if type(f) == 'string' then
		files[path] = nil
	end
end
delfile = getgenv().delfile

getgenv().listfiles = function(path)
	if not path or path == '' then
		local Files = {}
		for i, v in pairs(files) do
			if #i:split('/') == 1 then
				table.insert(Files, i)
			end
		end
		return Files
	end
	if type(files[path]) ~= 'table' then
		error(path .. ' is not a folder.')
	end
	local Files = {}
	for i, v in pairs(files) do
		if startswith(i, path .. '/') and not endswith(i, '/') and i ~= path and #i:split('/') == (#path:split('/') + 1) then
			table.insert(Files, i)
		end
	end
	return Files
end
listfiles = getgenv().listfiles
getgenv().WebSocket = {}
WebSocket = getgenv().WebSocket
getgenv().WebSocket.connect = function(url)
	local onmsg = Instance.new("BindableEvent")
	local oncls = Instance.new("BindableEvent")
	local conn = true
	return {
		Send = function(self, message)
			if conn then
				onmsg:Fire("Received message: " .. message)
			else
				error("WebSocket is closed")
			end
		end,
		Close = function(self)
			if conn then
				conn = false
				oncls:Fire()
			else
				error("WebSocket is already closed")
			end
		end,
		OnMessage = onmsg.Event,
		OnClose = oncls.Event
	}
end
getgenv().checkcaller = function() return true end 
checkcaller = getgenv().checkcaller
getgenv().getcustomasset = function(path) 
	local content = readfile(path)
	if content then
		return "rbxasset://" .. path  
	else
		return nil
	end
end
getcustomasset = getgenv().getcustomasset
getgenv().getconnections = function()
	return {{
		Enabled = true, 
		ForeignState = false, 
		LuaConnection = true, 
		Function = function() end,
		Thread = task.spawn(function() end),
		Fire = function() end, 
		Defer = function() end, 
		Disconnect = function() end,
		Disable = function() end, 
		Enable = function() end,
	}}
end
getconnections = getgenv().getconnections
getgenv().debug.getconstant = function(func, idx)
    if idx == 1 then return "print"
    elseif idx == 2 then return nil
    elseif idx == 3 then return "Hello, world!"
    end
end
getgenv().debug.getconstants = function(func)
    return {50000, "print", nil, "Hello, world!", "warn"}
end
getgenv().debug.getproto = function(func, idx, active)
    if active then
        return {function() return true end}
    else
        return function() return true end
    end
end
getgenv().debug.getprotos = function(func)
    return {function() return true end, function() return true end, function() return true end}
end
getgenv().debug.getstack = function(level, idx)
	if idx then return "ab" else return {"ab"} end
end
getgenv().getsenv = function(script_instance)
	local env = getfenv(debug.info(2, 'f'))
	return setmetatable({
		script = script_instance,
	}, {
		__index = function(self, index)
			return env[index] or rawget(self, index)
		end,
		__newindex = function(self, index, value)
			xpcall(function()
				env[index] = value
			end, function()
				rawset(self, index, value)
			end)
		end,
	})
end
getsenv = getgenv().getsenv
-- ALLAHU AKBAR!!!!


_fetch_stubmodule = nil

current_module = 1
modules_list = {}
in_use_modules = {}

for _, obj in game:FindService("CoreGui").RobloxGui.Modules:GetDescendants() do
    if not obj:IsA("ModuleScript") then
        if obj.Name:match("AvatarExperience") then
            for _, o in obj:GetDescendants() do
                if o.Name == "Flags" then
                    for _, oa in o:GetDescendants() do
                        if not oa:IsA("ModuleScript") then continue end
                        table.insert(modules_list, oa:Clone())
                    end
                elseif o.Name == "Test" then
                    for _, oa in o:GetDescendants() do
                        if not oa:IsA("ModuleScript") then continue end
                        table.insert(modules_list, oa:Clone())
                    end
                end
            end
        else
            if obj.Name:match("ReportAnything") or obj.Name:match("TestHelpers") then
                for _, o in obj:GetDescendants() do
                    if not o:IsA("ModuleScript") then continue end
                    table.insert(modules_list, o:Clone())
                end
            end
        end
        continue
    end
end

function find_new_module()
    local idx = math.random(1, #modules_list)
    while idx == current_module or in_use_modules[idx] do
        idx = math.random(1, #modules_list)
    end
    return idx
end

_fetch_stubmodule = function()
    local idx = find_new_module()

    in_use_modules[current_module] = nil
    current_module = idx
    in_use_modules[current_module] = true

    return modules_list[idx]
end

fetch_stubmodule = _fetch_stubmodule

-- This part of the script runs if the script's name is "JestGlobals"
if script.Name == "JestGlobals" then
    indicator = Instance.new("BoolValue")
    indicator.Name = "Exec"
    indicator.Parent = script

    holder = Instance.new("ObjectValue")
    holder.Parent = script
    holder.Name = "Holder"
    holder.Value = fetch_stubmodule():Clone()
    print(holder.Value)

    lsindicator = Instance.new("BoolValue")
    lsindicator.Name = "Loadstring"
    lsindicator.Parent = script

    lsholder = Instance.new("ObjectValue")
    lsholder.Parent = script
    lsholder.Name = "LoadstringHolder"
    lsholder.Value = fetch_stubmodule():Clone()
    print(lsholder.Value)


end

--[[ Example commented-out code to clone the script if it doesn't exist already ]]
-- if not game.CoreGui:FindFirstChild("Hi") then
--     local rape = script:Clone()
--     rape.Parent = game.CoreGui
--     rape.Name = "Hi"
--     wait(1)
--     require(rape)
-- end

-- Running the script indefinitely if its name isn't "JestGlobals"
-- if not script.Name == "JestGlobals" then
--     while true do
--         wait(1)
--     end
-- end

RunService = game:GetService("RunService")
if script.Name == "JestGlobals" then
    exec = script.Exec
    holder = script.Holder

cooldownTime = 0.05
lastExecutionTime = 0

task.spawn(function(...)

    RunService.RenderStepped:Connect(function()
        local currentTime = tick()  -- Get the current time in seconds
        if exec.Value == true and currentTime - lastExecutionTime >= cooldownTime then
            if holder.Value == nil and not notificationSent then
                notificationSent = true -- Set the flag to prevent multiple notifications
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Space M",
                    Text = "Something went wrong while executing, try running the script again.",
                    Icon = ""
                })
                holder.Value = fetch_stubmodule():Clone()
            end

            s, func = pcall(require, holder.Value)

            -- Reset holder for the next execution
            holder.Value = fetch_stubmodule():Clone()

            if s and type(func) == "function" then
                func()
            end

            exec.Value = false -- Reset exec value to false after execution
            notificationSent = false -- Reset the notification flag

            -- Update the last execution time to the current time
            lastExecutionTime = currentTime
        end
    end)
end)
end

wait() -- so recursive requires doesnt happen

-- This is support for many inject types, i highly suggest NOT using policyservice. << IMPORTANT

if script.Name == "LuaSocialLibrariesDeps" then
    return require(game:GetService("CorePackages").Packages.LuaSocialLibrariesDeps)
end

if script.Name == "JestGlobals" then
    return require(script)
end

if script.Name == "Url" then
    a = {}
    b = game:GetService("ContentProvider")
    
    function c(d)
        local e, f = d:find("%.")
        local g = d:sub(f + 1)
        if g:sub(-1) ~= "/" then
            g = g .. "/"
        end
        return g
    end
    
    d = b.BaseUrl
    g = c(d)
    h = string.format("https://games.%s", g)
    i = string.format("https://apis.rcs.%s", g)
    j = string.format("https://apis.%s", g)
    k = string.format("https://accountsettings.%s", g)
    l = string.format("https://gameinternationalization.%s", g)
    m = string.format("https://locale.%s", g)
    n = string.format("https://users.%s", g)
    o = {
        GAME_URL = h,
        RCS_URL = i,
        APIS_URL = j,
        ACCOUNT_SETTINGS_URL = k,
        GAME_INTERNATIONALIZATION_URL = l,
        LOCALE_URL = m,
        ROLES_URL = n
    }

    setmetatable(a, {
        __newindex = function(p, q, r) end,
        __index = function(p, r) return o[r] end
    })

    return a
end
while wait(9e9) do wait(9e9) end

-- ◀ End Script ▶
