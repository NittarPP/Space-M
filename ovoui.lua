-- Services
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")

-- Library Definition
local Space = {}
Space.Tree = {}
--[[
kavName = kavName or "Library"
table.insert(Space, kavName)
for i,v in pairs(game.CoreGui:GetChildren()) do
	if v:IsA("ScreenGui") and v.Name == kavName then
		v:Destroy()
	end
end
]]
-- Utility Functions
function Space:validate(defaults, options)
	options = options or {}
	for i, v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

-- Initialize GUI Library
function Space:Init(options)
	options = Space:validate({
		name = "Space X | Version 1.0.0"
	}, options or {})

	local G2L = Space.Tree
	local GUI = {}
	
	--gui
	
	do
		-- StarterGui.Script Hub
		G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
		G2L["1"]["Enabled"] = true;
		G2L["1"]["Name"] = [[Script Hub]];
		G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


		-- StarterGui.Script Hub.HitGui
		G2L["2"] = Instance.new("Frame", G2L["1"]);
		G2L["2"]["BorderSizePixel"] = 0;
		G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["2"]["Size"] = UDim2.new(0.56277, 0, 0.50079, 0);
		G2L["2"]["Position"] = UDim2.new(0.21807, 0, 0.25332, 0);
		G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["2"]["Name"] = [[HitGui]];
		G2L["2"]["BackgroundTransparency"] = 1;


		-- StarterGui.Script Hub.HitGui.Dragify
		G2L["3"] = Instance.new("LocalScript", G2L["2"]);
		G2L["3"]["Name"] = [[Dragify]];


		-- StarterGui.Script Hub.HitGui.Backgroud
		G2L["4"] = Instance.new("Frame", G2L["2"]);
		G2L["4"]["BorderSizePixel"] = 5;
		G2L["4"]["BackgroundColor3"] = Color3.fromRGB(89, 89, 89);
		G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0);
		G2L["4"]["Position"] = UDim2.new(-0.00011, 0, 0.00004, 0);
		G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["4"]["Name"] = [[Backgroud]];
		G2L["4"]["BackgroundTransparency"] = 0.05;


		-- StarterGui.Script Hub.HitGui.Backgroud.UICorner
		G2L["5"] = Instance.new("UICorner", G2L["4"]);
		G2L["5"]["CornerRadius"] = UDim.new(0.063, 0);


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud
		G2L["6"] = Instance.new("Frame", G2L["4"]);
		G2L["6"]["BorderSizePixel"] = 5;
		G2L["6"]["BackgroundColor3"] = Color3.fromRGB(45, 45, 45);
		G2L["6"]["Size"] = UDim2.new(0.983, 0, 0.96676, 0);
		G2L["6"]["Position"] = UDim2.new(0.00851, 0, 0.01658, 0);
		G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["6"]["Name"] = [[Backgroud]];
		G2L["6"]["BackgroundTransparency"] = 0.15;


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.UICorner
		G2L["7"] = Instance.new("UICorner", G2L["6"]);
		G2L["7"]["CornerRadius"] = UDim.new(0.063, 0);


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Titlebar
		G2L["8"] = Instance.new("Frame", G2L["6"]);
		G2L["8"]["BorderSizePixel"] = 0;
		G2L["8"]["BackgroundColor3"] = Color3.fromRGB(127, 127, 127);
		G2L["8"]["Size"] = UDim2.new(0.99918, 0, 0.10094, 0);
		G2L["8"]["Position"] = UDim2.new(0, 0, -0, 0);
		G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["8"]["Name"] = [[Titlebar]];
		G2L["8"]["BackgroundTransparency"] = 1;


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Titlebar.Title
		G2L["9"] = Instance.new("TextLabel", G2L["8"]);
		G2L["9"]["TextWrapped"] = true;
		G2L["9"]["BorderSizePixel"] = 0;
		G2L["9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		G2L["9"]["TextScaled"] = true;
		G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["9"]["TextSize"] = 14;
		G2L["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
		G2L["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["9"]["BackgroundTransparency"] = 1;
		G2L["9"]["Size"] = UDim2.new(0.3654, 0, 0.72129, 0);
		G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["9"]["Text"] = [[Space M | Version 1.0.0]];
		G2L["9"]["Name"] = [[Title]];
		G2L["9"]["Position"] = UDim2.new(0.022, 0, 0.1, 0);


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Titlebar.Titletap
		G2L["a"] = Instance.new("Frame", G2L["8"]);
		G2L["a"]["BorderSizePixel"] = 0;
		G2L["a"]["BackgroundColor3"] = Color3.fromRGB(89, 89, 89);
		G2L["a"]["Size"] = UDim2.new(1.001, 0, 0.1, 0);
		G2L["a"]["Position"] = UDim2.new(0, 0, 0.96287, 0);
		G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["a"]["Name"] = [[Titletap]];


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar
		G2L["b"] = Instance.new("Frame", G2L["6"]);
		G2L["b"]["BorderSizePixel"] = 0;
		G2L["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["b"]["Size"] = UDim2.new(0.23167, 0, 0.89441, 0);
		G2L["b"]["Position"] = UDim2.new(0, 0, 0.10559, 0);
		G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["b"]["Name"] = [[Tapbar]];
		G2L["b"]["BackgroundTransparency"] = 1;


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame
		G2L["c"] = Instance.new("ScrollingFrame", G2L["b"]);
		G2L["c"]["Active"] = true;
		G2L["c"]["BorderSizePixel"] = 0;
		G2L["c"]["CanvasSize"] = UDim2.new(0, 0, 3, 0);
		G2L["c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["c"]["Size"] = UDim2.new(0.99764, 0, 0.94694, 0);
		G2L["c"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["c"]["Position"] = UDim2.new(0, 0, 0.02945, 0);
		G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["c"]["ScrollBarThickness"] = 3;
		G2L["c"]["BackgroundTransparency"] = 1;


		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame.UIListLayout
		G2L["d"] = Instance.new("UIListLayout", G2L["c"]);
		G2L["d"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
		G2L["d"]["Padding"] = UDim.new(0, 5);
		G2L["d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		G2L["d"]["ItemLineAlignment"] = Enum.ItemLineAlignment.Center;
		
		local function C_3()
			local script = G2L["3"];
			local UserInputService = game:GetService("UserInputService")

			local gui = script.Parent

			local dragging
			local dragInput
			local dragStart
			local startPos

			local function update(input)
				local delta = input.Position - dragStart
				gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end

			gui.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = gui.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			gui.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)
		end;
		task.spawn(C_3);
		
		-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page
		G2L["15"] = Instance.new("Frame", G2L["6"]);
		G2L["15"]["BorderSizePixel"] = 0;
		G2L["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["15"]["Size"] = UDim2.new(0, 429, 0, 256);
		G2L["15"]["Position"] = UDim2.new(0.23511, 0, 0.10485, 0);
		G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["15"]["Name"] = [[Page]];
		G2L["15"]["BackgroundTransparency"] = 1;
		
		function Space:addTap(options)
			options = Space:validate({
				name = "nil",
				icon = "911"
			}, options or {})
			
			
			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame.ButtonName
			G2L["e"] = Instance.new("Frame", G2L["c"]);
			G2L["e"]["BorderSizePixel"] = 0;
			G2L["e"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
			G2L["e"]["Size"] = UDim2.new(0, 118, 0, 28);
			G2L["e"]["Position"] = UDim2.new(-0, 0, 0, 0);
			G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["e"]["Name"] = options["name"];


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame.ButtonName.UICorner
			G2L["f"] = Instance.new("UICorner", G2L["e"]);



			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame.ButtonName.TextLabel
			G2L["10"] = Instance.new("TextLabel", G2L["e"]);
			G2L["10"]["TextWrapped"] = true;
			G2L["10"]["BorderSizePixel"] = 0;
			G2L["10"]["TextXAlignment"] = Enum.TextXAlignment.Right;
			G2L["10"]["TextScaled"] = true;
			G2L["10"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["10"]["TextSize"] = 14;
			G2L["10"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["10"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["10"]["BackgroundTransparency"] = 1;
			G2L["10"]["Size"] = UDim2.new(0, 75, 0, 15);
			G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["10"]["Text"] = options["name"];
			G2L["10"]["Position"] = UDim2.new(0.25688, 0, 0.21429, 0);


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame.ButtonName.Icon
			G2L["11"] = Instance.new("ImageLabel", G2L["e"]);
			G2L["11"]["BorderSizePixel"] = 0;
			G2L["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["11"]["Image"] = options["icon"];
			G2L["11"]["ImageColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["11"]["Size"] = UDim2.new(0, 20, 0, 20);
			G2L["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["11"]["Name"] = [[Icon]];
			G2L["11"]["Position"] = UDim2.new(0.07339, 0, 0.14286, 0);
			G2L["11"]["BackgroundTransparency"] = 1


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame.ButtonName.Icon.UICorner
			G2L["12"] = Instance.new("UICorner", G2L["11"]);
			G2L["12"]["CornerRadius"] = UDim.new(0, 4);


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Tapbar.ScrollingFrame.ButtonName.Click
			G2L["13"] = Instance.new("TextButton", G2L["e"]);
			G2L["13"]["BorderSizePixel"] = 0;
			G2L["13"]["TextSize"] = 14;
			G2L["13"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["13"]["Size"] = UDim2.new(0, 117, 0, 28);
			G2L["13"]["BackgroundTransparency"] = 1;
			G2L["13"]["Name"] = [[Click]];
			G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["13"]["Text"] = [[]];
			
			G2L["ClickScript"] = Instance.new("LocalScript", G2L["13"]);
			G2L["ClickScript"]["Name"] = [[ClickScript]];
			
			--page
			
			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page.Home
			G2L["16"] = Instance.new("Frame", G2L["15"]);
			G2L["16"]["BorderSizePixel"] = 0;
			G2L["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["16"]["Size"] = UDim2.new(1, 0, 0.87, 0);
			G2L["16"]["Position"] = UDim2.new(0, 0, 0.03026, 0);
			G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["16"]["Name"] = options["name"];
			G2L["16"]["BackgroundTransparency"] = 1;
			G2L["16"].Visible = false
			
			local thispage = G2L["16"] 


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page.Home.ScrollingFrame
			G2L["17"] = Instance.new("ScrollingFrame", G2L["16"]);
			G2L["17"]["Active"] = true;
			G2L["17"]["BorderSizePixel"] = 0;
			G2L["17"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["17"]["Size"] = UDim2.new(0.99534, 0, 1, 0);
			G2L["17"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["17"]["ScrollBarThickness"] = 1;
			G2L["17"]["BackgroundTransparency"] = 1;


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page.Home.ScrollingFrame.UIListLayout
			G2L["18"] = Instance.new("UIListLayout", G2L["17"]);
			G2L["18"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
			G2L["18"]["Padding"] = UDim.new(0.01008, 0);
			G2L["18"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
			G2L["18"]["ItemLineAlignment"] = Enum.ItemLineAlignment.Center;

			
			local function gotit()
				local script = G2L["ClickScript"];
				script.Parent.MouseButton1Down:Connect(function()
					local otherPages = G2L["15"]:GetChildren()
					for _, page in pairs(otherPages) do
						page.Visible = false
					end
					thispage.Visible = true
				end)

			end;
			task.spawn(gotit);
			
		end
		
		function Space:addbutton(options)
			options = Space:validate({
				name = "Click me",
				icon = "rbxassetid://17293879614",
				code = function() end
			}, options or {})
			
			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page.Home.ScrollingFrame.ButtonName
			G2L["19"] = Instance.new("Frame", G2L["17"]);
			G2L["19"]["BorderSizePixel"] = 0;
			G2L["19"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
			G2L["19"]["Size"] = UDim2.new(0.95316, 0, 0.05645, 0);
			G2L["19"]["Position"] = UDim2.new(0.02342, 0, 0, 0);
			G2L["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["19"]["Name"] = options["name"];


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page.Home.ScrollingFrame.ButtonName.UICorner
			G2L["1a"] = Instance.new("UICorner", G2L["19"]);



			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page.Home.ScrollingFrame.ButtonName.TextLabel
			G2L["1b"] = Instance.new("TextLabel", G2L["19"]);
			G2L["1b"]["TextWrapped"] = true;
			G2L["1b"]["BorderSizePixel"] = 0;
			G2L["1b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["1b"]["TextScaled"] = true;
			G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1b"]["TextSize"] = 14;
			G2L["1b"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1b"]["BackgroundTransparency"] = 1;
			G2L["1b"]["Size"] = UDim2.new(0, 346, 0, 22);
			G2L["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1b"]["Text"] = options["name"];
			G2L["1b"]["Position"] = UDim2.new(0.01966, 0, 0.10714, 0);


			-- StarterGui.Script Hub.HitGui.Backgroud.Backgroud.Page.Home.ScrollingFrame.ButtonName.ImageButton
			G2L["1c"] = Instance.new("ImageButton", G2L["19"]);
			G2L["1c"]["BorderSizePixel"] = 0;
			G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1c"]["Image"] = options["icon"];
			G2L["1c"]["Size"] = UDim2.new(0, 25, 0, 25);
			G2L["1c"]["BackgroundTransparency"] = 1;
			G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1c"]["Position"] = UDim2.new(0.92383, 0, 0.03571, 0);
			
			G2L["c1"] = Instance.new("LocalScript", G2L["1c"]);
			G2L["c1"]["Name"] = [[Clicktrue]];
			
			local function clickmea()
				local script = G2L["c1"];
				script.Parent.MouseButton1Down:Connect(function()
					options.code()
				end)

			end;
			task.spawn(clickmea);
		end
		
	end
	
end

return Space
