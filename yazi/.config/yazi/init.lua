-- ~/.config/yazi/init.lua
-- require("full-border"):setup()
-- require("omp"):setup({ config = "~/dotfile/oh-my-posh.json" })
-- require("git"):setup()
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
return {
	entry = function()
		local h = cx.active.current.hovered
		if h and h.cha.is_dir then
			ya.manager_emit("enter", {})
			ya.manager_emit("paste", {})
			ya.manager_emit("leave", {})
		else
			ya.manager_emit("paste", {})
		end
	end,
}
