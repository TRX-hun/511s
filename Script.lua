local DataStoreService = game:GetService("DataStoreService")
local TimeDataStore = DataStoreService:GetDataStore("PlayerTimeTracker")
local Players = game:GetService("Players")

-- جدول لتخزين وقت دخول اللاعب
local loginTimes = {}

Players.PlayerAdded:Connect(function(player)
    -- تسجيل وقت الدخول عند انضمام اللاعب
    loginTimes[player.UserId] = os.time()
    print(player.Name .. " دخل السيرفر في: " .. os.date("%H:%M:%S", loginTimes[player.UserId]))
end)

Players.PlayerRemoving:Connect(function(player)
    local loginTime = loginTimes[player.UserId]
    if loginTime then
        local logoutTime = os.time()
        local duration = logoutTime - loginTime -- حساب الفرق بالثواني
        
        -- تحويل الثواني إلى ساعات ودقائق وثواني
        local hours = math.floor(duration / 3600)
        local minutes = math.floor((duration % 3600) / 60)
        local seconds = duration % 60
        
        local timeSpent = string.format("%02d:%02d:%02d", hours, minutes, seconds)
        print(player.Name .. " خرج بعد قضاء: " .. timeSpent)
        
        -- هنا يمكنك إضافة كود لحفظ البيانات في DataStore
        -- pcall(function() TimeDataStore:SetAsync(player.UserId, timeSpent) end)
    end
    loginTimes[player.UserId] = nil
end)
--انميشن قوس قزح 
