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


-- StarterGui.Space X.Scalset.KeyUI.Board.Main.KeyButton.LocalScript
G2L["9"] = Instance.new("LocalScript", G2L["8"]);



-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui
G2L["a"] = Instance.new("Frame", G2L["4"]);
G2L["a"]["Visible"] = false;
G2L["a"]["BorderSizePixel"] = 0;
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a"]["Size"] = UDim2.new(0.49499, 0, 0.42826, 0);
G2L["a"]["Position"] = UDim2.new(0.25246, 0, 0.21997, 0);
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a"]["Name"] = [[KeyGui]];


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UICorner
G2L["b"] = Instance.new("UICorner", G2L["a"]);
G2L["b"]["CornerRadius"] = UDim.new(0.07507, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UIGradient
G2L["c"] = Instance.new("UIGradient", G2L["a"]);
G2L["c"]["Rotation"] = -95;
G2L["c"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(130, 130, 130)),ColorSequenceKeypoint.new(0.481, Color3.fromRGB(144, 144, 144)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(159, 159, 159))};


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UserName
G2L["d"] = Instance.new("TextBox", G2L["a"]);
G2L["d"]["CursorPosition"] = -1;
G2L["d"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d"]["BorderSizePixel"] = 0;
G2L["d"]["TextWrapped"] = true;
G2L["d"]["TextSize"] = 14;
G2L["d"]["Name"] = [[UserName]];
G2L["d"]["TextScaled"] = true;
G2L["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["d"]["RichText"] = true;
G2L["d"]["ClearTextOnFocus"] = false;
G2L["d"]["Size"] = UDim2.new(0.78427, 0, 0.1, 0);
G2L["d"]["Position"] = UDim2.new(0.10716, 0, 0.28052, 0);
G2L["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d"]["Text"] = [[Player Name]];


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.UserName.UICorner
G2L["e"] = Instance.new("UICorner", G2L["d"]);
G2L["e"]["CornerRadius"] = UDim.new(0, 19);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.PIN
G2L["f"] = Instance.new("TextBox", G2L["a"]);
G2L["f"]["CursorPosition"] = -1;
G2L["f"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f"]["BorderSizePixel"] = 0;
G2L["f"]["TextWrapped"] = true;
G2L["f"]["TextSize"] = 14;
G2L["f"]["Name"] = [[PIN]];
G2L["f"]["TextScaled"] = true;
G2L["f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["f"]["RichText"] = true;
G2L["f"]["ClearTextOnFocus"] = false;
G2L["f"]["Size"] = UDim2.new(0.78427, 0, 0.1, 0);
G2L["f"]["Position"] = UDim2.new(0.10518, 0, 0.51363, 0);
G2L["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f"]["Text"] = [[PIN]];


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.PIN.UICorner
G2L["10"] = Instance.new("UICorner", G2L["f"]);
G2L["10"]["CornerRadius"] = UDim.new(0, 19);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.Login
G2L["11"] = Instance.new("TextButton", G2L["a"]);
G2L["11"]["TextWrapped"] = true;
G2L["11"]["BorderSizePixel"] = 0;
G2L["11"]["TextSize"] = 14;
G2L["11"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11"]["TextScaled"] = true;
G2L["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["11"]["RichText"] = true;
G2L["11"]["Size"] = UDim2.new(0.3969, 0, 0.19755, 0);
G2L["11"]["Name"] = [[Login]];
G2L["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11"]["Text"] = [[Login]];
G2L["11"]["Position"] = UDim2.new(0.30165, 0, 0.69538, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.Login.UICorner
G2L["12"] = Instance.new("UICorner", G2L["11"]);
G2L["12"]["CornerRadius"] = UDim.new(0.46, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.TextLabel
G2L["13"] = Instance.new("TextLabel", G2L["a"]);
G2L["13"]["TextWrapped"] = true;
G2L["13"]["BorderSizePixel"] = 0;
G2L["13"]["TextScaled"] = true;
G2L["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["TextSize"] = 14;
G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["13"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["BackgroundTransparency"] = 1;
G2L["13"]["Size"] = UDim2.new(0, 394, 0, 57);
G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13"]["Text"] = [[Enter The User Name and Pin]];
G2L["13"]["Position"] = UDim2.new(0.10716, 0, 0.03161, 0);


-- StarterGui.Space X.Scalset.KeyUI.Board.KeyGui.TextLabel.UIGradient
G2L["14"] = Instance.new("UIGradient", G2L["13"]);
G2L["14"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.481, Color3.fromRGB(236, 236, 236)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(223, 223, 223))};


-- StarterGui.Space X.Scalset.MainUI
G2L["15"] = Instance.new("Folder", G2L["2"]);
G2L["15"]["Name"] = [[MainUI]];


-- StarterGui.Space X.Scalset.BanUI
G2L["16"] = Instance.new("Folder", G2L["2"]);
G2L["16"]["Name"] = [[BanUI]];


-- StarterGui.Space X.Scalset.KeyUI.Board.Main.KeyButton.LocalScript
local function C_9()
local script = G2L["9"];
	script.Parent.MouseButton1Down:Connect(function()
		if script.Parent.Parent.Parent.KeyGui.Visible == true then
			script.Parent.Parent.Parent.KeyGui.Visible = false
		else
			script.Parent.Parent.Parent.KeyGui.Visible = true
		end
	end)
end;
task.spawn(C_9);

return G2L["1"], require;

-- ◀ End Script ▶
