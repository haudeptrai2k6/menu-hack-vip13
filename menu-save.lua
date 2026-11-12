local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ nếu chạy lại script
local guiParent = (gethui and gethui()) or CoreGui
pcall(function()
    if guiParent:FindFirstChild("SavePosMenuPro") then
        guiParent.SavePosMenuPro:Destroy()
    end
    if LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("SavePosMenuPro") then
        LocalPlayer.PlayerGui.SavePosMenuPro:Destroy()
    end
end)

-- ==========================================
-- KHỞI TẠO GIAO DIỆN CHÍNH
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Menu Save Vip"
ScreenGui.ResetOnSpawn = false

local ok = pcall(function()
    ScreenGui.Parent = guiParent
end)
if not ok or not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 230, 0, 250)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(70, 70, 70)
UIStroke.Thickness = 1.5

-- Thanh tiêu đề
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -65, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = " 🇻🇳LƯU VỊ TRÍ🇻🇳"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 12
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Nút Thu gọn / Mở rộng [-]
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 22)
MinBtn.Position = UDim2.new(1, -56, 0, 4)
MinBtn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

-- Nút Xoá Menu [X]
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 22)
CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 45, 45)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- Khung chứa nội dung (để ẩn/hiện khi thu gọn)
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Ô nhập tên vị trí mới
local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(1, -85, 0, 28)
NameInput.Position = UDim2.new(0, 8, 0, 8)
NameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
NameInput.PlaceholderText = "Nhập tên vị trí..."
NameInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
NameInput.Text = ""
NameInput.Font = Enum.Font.GothamSemibold
NameInput.TextSize = 12
NameInput.TextColor3 = Color3.new(1, 1, 1)
NameInput.ClearTextOnFocus = false
NameInput.Parent = ContentFrame
Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 5)

-- Nút Lưu vị trí
local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(0, 65, 0, 28)
SaveBtn.Position = UDim2.new(1, -73, 0, 8)
SaveBtn.BackgroundColor3 = Color3.fromRGB(40, 170, 60)
SaveBtn.Text = "+ LƯU"
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 12
SaveBtn.TextColor3 = Color3.new(1, 1, 1)
SaveBtn.Parent = ContentFrame
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 5)

-- Danh sách cuộn các vị trí đã lưu
local ListScroll = Instance.new("ScrollingFrame")
ListScroll.Size = UDim2.new(1, -16, 1, -48)
ListScroll.Position = UDim2.new(0, 8, 0, 42)
ListScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ListScroll.BorderSizePixel = 0
ListScroll.ScrollBarThickness = 5
ListScroll.ScrollBarImageColor3 = Color3.fromRGB(50, 220, 80)
ListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ListScroll.Parent = ContentFrame
Instance.new("UICorner", ListScroll).CornerRadius = UDim.new(0, 6)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ListScroll

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 5)
UIPadding.PaddingBottom = UDim.new(0, 5)
UIPadding.PaddingLeft = UDim.new(0, 5)
UIPadding.PaddingRight = UDim.new(0, 8)
UIPadding.Parent = ListScroll

-- ==========================================
-- LOGIC LƯU, ĐỔI TÊN, TP & XOÁ VỊ TRÍ
-- ==========================================
local savedCount = 0

local function addSavedPosition(customName, savedCFrame)
    savedCount = savedCount + 1
    local defaultName = (customName and customName ~= "") and customName or ("Vị trí #" .. tostring(savedCount))

    local ItemFrame = Instance.new("Frame")
    ItemFrame.Size = UDim2.new(1, 0, 0, 30)
    ItemFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    ItemFrame.BorderSizePixel = 0
    ItemFrame.Parent = ListScroll
    Instance.new("UICorner", ItemFrame).CornerRadius = UDim.new(0, 5)

    -- Ô hiển thị & cho phép sửa tên trực tiếp
    local ItemNameBox = Instance.new("TextBox")
    ItemNameBox.Size = UDim2.new(1, -86, 1, -6)
    ItemNameBox.Position = UDim2.new(0, 6, 0, 3)
    ItemNameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ItemNameBox.Text = defaultName
    ItemNameBox.Font = Enum.Font.GothamSemibold
    ItemNameBox.TextSize = 11
    ItemNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    ItemNameBox.TextXAlignment = Enum.TextXAlignment.Left
    ItemNameBox.ClearTextOnFocus = false
    ItemNameBox.TextTruncate = Enum.TextTruncate.AtEnd
    ItemNameBox.Parent = ItemFrame
    Instance.new("UICorner", ItemNameBox).CornerRadius = UDim.new(0, 4)

    local BoxPad = Instance.new("UIPadding", ItemNameBox)
    BoxPad.PaddingLeft = UDim.new(0, 5)
    BoxPad.PaddingRight = UDim.new(0, 5)

    -- Giữ tên cũ nếu người dùng xóa trắng khi đổi tên
    local currentValidName = defaultName
    ItemNameBox.FocusLost:Connect(function()
        if ItemNameBox.Text == "" then
            ItemNameBox.Text = currentValidName
        else
            currentValidName = ItemNameBox.Text
        end
    end)

    -- Nút TP đến vị trí
    local TpBtn = Instance.new("TextButton")
    TpBtn.Size = UDim2.new(0, 36, 0, 22)
    TpBtn.Position = UDim2.new(1, -74, 0.5, -11)
    TpBtn.BackgroundColor3 = Color3.fromRGB(35, 150, 220)
    TpBtn.Text = "TP"
    TpBtn.Font = Enum.Font.GothamBold
    TpBtn.TextSize = 11
    TpBtn.TextColor3 = Color3.new(1, 1, 1)
    TpBtn.Parent = ItemFrame
    Instance.new("UICorner", TpBtn).CornerRadius = UDim.new(0, 4)

    TpBtn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = savedCFrame
        end
    end)

    -- Nút Xóa vị trí
    local DelBtn = Instance.new("TextButton")
    DelBtn.Size = UDim2.new(0, 32, 0, 22)
    DelBtn.Position = UDim2.new(1, -35, 0.5, -11)
    DelBtn.BackgroundColor3 = Color3.fromRGB(210, 45, 45)
    DelBtn.Text = "XÓA"
    DelBtn.Font = Enum.Font.GothamBold
    DelBtn.TextSize = 10
    DelBtn.TextColor3 = Color3.new(1, 1, 1)
    DelBtn.Parent = ItemFrame
    Instance.new("UICorner", DelBtn).CornerRadius = UDim.new(0, 4)

    DelBtn.MouseButton1Click:Connect(function()
        ItemFrame:Destroy()
    end)
end

-- Sự kiện bấm nút "+ LƯU"
SaveBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        addSavedPosition(NameInput.Text, root.CFrame)
        NameInput.Text = ""
    end
end)

-- Sự kiện Thu gọn / Mở rộng Menu [-]
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        ContentFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 230, 0, 30)
        MinBtn.Text = "+"
    else
        ContentFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 230, 0, 250)
        MinBtn.Text = "-"
    end
end)

-- Sự kiện Xoá hẳn Menu [X]
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
