for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and v.Name:lower():find("egg") then
        print("Found:", v:GetFullName())
    end
end
