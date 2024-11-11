local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = screenGui

-- ชื่อที่มุมซ้ายบน
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "NEWSOYES"
titleLabel.Size = UDim2.new(0, 100, 0, 40)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.Parent = frame

-- สร้างปุ่มปิด
local closeButton = Instance.new("TextButton")
closeButton.Text = "ปิด"
closeButton.Size = UDim2.new(0, 80, 0, 40)
closeButton.Position = UDim2.new(1, -80, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- พิกัด X
local xTextBox = Instance.new("TextBox")
xTextBox.PlaceholderText = "ใส่ X"
xTextBox.Size = UDim2.new(0, 260, 0, 30)
xTextBox.Position = UDim2.new(0, 20, 0, 50)
xTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
xTextBox.Parent = frame

-- พิกัด Y
local yTextBox = Instance.new("TextBox")
yTextBox.PlaceholderText = "ใส่ Y"
yTextBox.Size = UDim2.new(0, 260, 0, 30)
yTextBox.Position = UDim2.new(0, 20, 0, 90)
yTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
yTextBox.Parent = frame

-- พิกัด Z
local zTextBox = Instance.new("TextBox")
zTextBox.PlaceholderText = "ใส่ Z"
zTextBox.Size = UDim2.new(0, 260, 0, 30)
zTextBox.Position = UDim2.new(0, 20, 0, 130)
zTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
zTextBox.Parent = frame

-- ปุ่มวาร์ป
local teleportButton = Instance.new("TextButton")
teleportButton.Text = "วาร์ป"
teleportButton.Size = UDim2.new(0, 260, 0, 40)
teleportButton.Position = UDim2.new(0, 20, 0, 170)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
teleportButton.Parent = frame

-- ฟังก์ชันวาร์ปเมื่อกดปุ่ม
teleportButton.MouseButton1Click:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        -- อ่านค่าจากกล่องข้อความและแปลงเป็นตัวเลข
        local x = tonumber(xTextBox.Text) or 0
        local y = tonumber(yTextBox.Text) or 0
        local z = tonumber(zTextBox.Text) or 0

        -- ตั้งตำแหน่งตัวละครตามค่าที่กรอกในกล่อง
        character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    else
        print("ไม่พบตัวละคร!")
    end
end)

-- ฟังก์ชันสำหรับลากหน้าต่าง
local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- เริ่มต้นการลากเมื่อคลิกที่หน้าต่าง
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        -- คำนวณตำแหน่งใหม่ของหน้าต่าง
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- ยกเลิกการลากเมื่อปล่อยเมาส์
        dragging = false
    end
end)

-- เพิ่มปุ่มพับ
local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "_"
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -120, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
minimizeButton.Parent = frame

-- สร้างไอคอนเมื่อพับ
local minimizedIcon = Instance.new("Frame")
minimizedIcon.Size = UDim2.new(0, 40, 0, 40)
minimizedIcon.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- สีแดง
minimizedIcon.Visible = false
minimizedIcon.Parent = screenGui

-- ฟังก์ชันสำหรับพับ/ขยาย
minimizeButton.MouseButton1Click:Connect(function()
    if frame.Visible then
        -- คำนวณตำแหน่งของไอคอนสีแดงให้ตรงกลางของหน้าต่างเมนู
        local iconX = frame.Position.X.Offset + (frame.Size.X.Offset / 0.24) - (minimizedIcon.Size.X.Offset / 0.24)
        local iconY = frame.Position.Y.Offset + (frame.Size.Y.Offset / 0.28) - (minimizedIcon.Size.Y.Offset / 0.28)
        minimizedIcon.Position = UDim2.new(0, iconX, 0, iconY)
        
        -- หดหน้าต่างและแสดงไอคอนสีแดง
        frame.Visible = false
        minimizedIcon.Visible = true
    end
end)

-- ฟังก์ชันสำหรับคลิกไอคอนสีแดงเพื่อขยาย
minimizedIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- ขยายหน้าต่างเมื่อคลิกที่ไอคอน
        frame.Visible = true
        minimizedIcon.Visible = false
    end
end)
