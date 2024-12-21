--[[ 
◀ DO NOT'T USE IT ▶
If you use this and don't credit me, i can DMCA you.

◀ This Gui Make For Space M ▶
]]
-- ◀ Script ▶


local G2L = {};

-- StarterGui.Space X
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["SafeAreaCompatibility"] = Enum.SafeAreaCompatibility.None;
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["DisplayOrder"] = 2000000000;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.None;
G2L["1"]["Name"] = [[Space X]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.Space X.Scalset
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[Scalset]];
G2L["2"]["BackgroundTransparency"] = 1;


-- StarterGui.Space X.Scalset.KeyUI
G2L["3"] = Instance.new("Folder", G2L["2"]);
G2L["3"]["Name"] = [[KeyUI]];


-- StarterGui.Space X.Scalset.KeyUI.Board
G2L["4"] = Instance.new("Frame", G2L["3"]);
G2L["4"]["BorderSizePixel"] = 0;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4"]["Name"] = [[Board]];
G2L["4"]["BackgroundTransparency"] = 1;


-- StarterGui.Space X.Scalset.KeyUI.Board.Main
G2L["5"] = Instance.new("Frame", G2L["4"]);
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["Size"] = UDim2.new(0.14332, 0, 0.0679, 0);
G2L["5"]["Position"] = UDim2.new(0.42829, 0, 0.04222, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Name"] = [[Main]];


-- StarterGui.Space X.Scalset.KeyUI.Board.Main.UIGradient
G2L["6"] = Instance.new("UIGradient", G2L["5"]);
G2L["6"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(130, 130, 130)),ColorSequenceKeypoint.new(0.481, Color3.fromRGB(144, 144, 144)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(159, 159, 159))};


-- StarterGui.Space X.Scalset.KeyUI.Board.Main.UICorner
G2L["7"] = Instance.new("UICorner", G2L["5"]);
G2L["7"]["CornerRadius"] = UDim.new(0.4735, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.Main.KeyButton
G2L["8"] = Instance.new("ImageButton", G2L["5"]);
G2L["8"]["BorderSizePixel"] = 0;
G2L["8"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8"]["Image"] = [[rbxassetid://221748793]];
G2L["8"]["Size"] = UDim2.new(0.2464, 0, 0.76153, 0);
G2L["8"]["BackgroundTransparency"] = 1;
G2L["8"]["Name"] = [[KeyButton]];
G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8"]["Position"] = UDim2.new(0.37012, 0, 0.1084, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui
G2L["9"] = Instance.new("Frame", G2L["4"]);
G2L["9"]["Visible"] = false;
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["Size"] = UDim2.new(0.49499, 0, 0.42826, 0);
G2L["9"]["Position"] = UDim2.new(0.25246, 0, 0.21997, 0);
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9"]["Name"] = [[KeyGui]];


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UICorner
G2L["a"] = Instance.new("UICorner", G2L["9"]);
G2L["a"]["CornerRadius"] = UDim.new(0.07507, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UIGradient
G2L["b"] = Instance.new("UIGradient", G2L["9"]);
G2L["b"]["Rotation"] = -95;
G2L["b"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(130, 130, 130)),ColorSequenceKeypoint.new(0.481, Color3.fromRGB(144, 144, 144)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(159, 159, 159))};


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UserName
G2L["c"] = Instance.new("TextBox", G2L["9"]);
G2L["c"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["TextWrapped"] = true;
G2L["c"]["TextSize"] = 14;
G2L["c"]["Name"] = [[UserName]];
G2L["c"]["TextScaled"] = true;
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["c"]["RichText"] = true;
G2L["c"]["ClearTextOnFocus"] = false;
G2L["c"]["Size"] = UDim2.new(0.78427, 0, 0.1, 0);
G2L["c"]["Position"] = UDim2.new(0.10716, 0, 0.28052, 0);
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["Text"] = [[Player Name]];


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UserName.UICorner
G2L["d"] = Instance.new("UICorner", G2L["c"]);
G2L["d"]["CornerRadius"] = UDim.new(0.75069, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.PIN
G2L["e"] = Instance.new("TextBox", G2L["9"]);
G2L["e"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["BorderSizePixel"] = 0;
G2L["e"]["TextWrapped"] = true;
G2L["e"]["TextSize"] = 14;
G2L["e"]["Name"] = [[PIN]];
G2L["e"]["TextScaled"] = true;
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["e"]["RichText"] = true;
G2L["e"]["ClearTextOnFocus"] = false;
G2L["e"]["Size"] = UDim2.new(0.78427, 0, 0.1, 0);
G2L["e"]["Position"] = UDim2.new(0.10518, 0, 0.51363, 0);
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["Text"] = [[PIN]];


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.PIN.UICorner
G2L["f"] = Instance.new("UICorner", G2L["e"]);
G2L["f"]["CornerRadius"] = UDim.new(0, 19);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.Login
G2L["10"] = Instance.new("TextButton", G2L["9"]);
G2L["10"]["TextWrapped"] = true;
G2L["10"]["BorderSizePixel"] = 0;
G2L["10"]["TextSize"] = 14;
G2L["10"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10"]["TextScaled"] = true;
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["10"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["10"]["RichText"] = true;
G2L["10"]["Size"] = UDim2.new(0.3969, 0, 0.19755, 0);
G2L["10"]["Name"] = [[Login]];
G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10"]["Text"] = [[Login]];
G2L["10"]["Position"] = UDim2.new(0.30165, 0, 0.69538, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.Login.UICorner
G2L["11"] = Instance.new("UICorner", G2L["10"]);
G2L["11"]["CornerRadius"] = UDim.new(0.46, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.TextLabel
G2L["12"] = Instance.new("TextLabel", G2L["9"]);
G2L["12"]["TextWrapped"] = true;
G2L["12"]["BorderSizePixel"] = 0;
G2L["12"]["TextScaled"] = true;
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12"]["TextSize"] = 14;
G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["12"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12"]["BackgroundTransparency"] = 1;
G2L["12"]["Size"] = UDim2.new(0.7819, 0, 0.22521, 0);
G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12"]["Text"] = [[Enter The User Name and Pin]];
G2L["12"]["Position"] = UDim2.new(0.10716, 0, 0.03161, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.TextLabel.UIGradient
G2L["13"] = Instance.new("UIGradient", G2L["12"]);
G2L["13"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.481, Color3.fromRGB(236, 236, 236)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(223, 223, 223))};


-- StarterGui.Space X.Scalset.MainUI
G2L["14"] = Instance.new("Folder", G2L["2"]);
G2L["14"]["Name"] = [[MainUI]];


-- StarterGui.Space X.Scalset.BanUI
G2L["15"] = Instance.new("Folder", G2L["2"]);
G2L["15"]["Name"] = [[BanUI]];


-- StarterGui.Space X.ServerScript
G2L["16"] = Instance.new("LocalScript", G2L["1"]);
G2L["16"]["Name"] = [[ServerScript]];


-- StarterGui.Space X.ServerScript
local function C_16()
local script = G2L["16"];
	local St = script.Parent.Parent["Space X"].Scalset
	local KeyUI =St.KeyUI
	local MainUI =St.MainUI
	
	function payload()
		KeyUI.Board.KeyGui.UserName.Text = ""..game.Players.LocalPlayer.Name
	end
	
	payload()
	
	
	
	KeyUI.Board.Main.KeyButton.MouseButton1Down:Connect(function()
		if KeyUI.Board.KeyGui.Visible == true then
			KeyUI.Board.KeyGui.Visible = false
		else
			KeyUI.Board.KeyGui.Visible = true
		end
	end)
	
	
	KeyUI.Board.KeyGui.Login.MouseButton1Down:Connect(function()
		local username = KeyUI.Board.KeyGui.UserName.Text
		local pin = KeyUI.Board.KeyGui.PIN.Text
		
		print(username,pin)
		
		KeyUI.Board.Visible = false
	end)
end;
task.spawn(C_16);

return G2L["1"], require;

-- ◀ End Script ▶
