-- lua/shortcut-api/init.lua
local M = {}
local curl = require("plenary.curl")
-- local telescope = require("telescope.builtin")

local api_token = vim.env.SHORTCUT_API_TOKEN
local api_url = "https://api.app.shortcut.com/api/v3"

local function utc_str(dt)
	return string.format("%04d-%02d-%02dT%02d:%02d:%02dZ", dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec)
end

function M.fetch_stories()
	local whoami_resp = curl.get(api_url .. "/member", {
		headers = {
			["Shortcut-Token"] = api_token,
			["Content-Type"] = "application/json",
		},
	})
	if whoami_resp.status ~= 200 then
		print("Error determining your Shortcut user.")
		print(vim.inspect(whoami_resp.body))
		return {}
	end
	local whoami = vim.fn.json_decode(whoami_resp.body)
	local whoami_id = whoami.id
	local whoami_name = whoami.mention_name
	local current_time = os.time()
	local last_n_days = 30
	local recently = current_time - (last_n_days * 24 * 60 * 60)
	-- Shortcut API appears to only accept Z as the zone identifier
	local current_time_utc = os.date("!*t", current_time)
	local recently_utc = os.date("!*t", recently)
	local current_time_utc_str = utc_str(current_time_utc)
	local recently_utc_str = utc_str(recently_utc)
	local stories_resp = curl.post(api_url .. "/stories/search", {
		headers = {
			["Shortcut-Token"] = api_token,
			["Content-Type"] = "application/json",
		},
		body = vim.fn.json_encode({
			owner_id = whoami_id,
			workflow_state_types = { "unstarted" },
			updated_at_start = recently_utc_str,
			updated_at_end = current_time_utc_str,
		}),
	})

	if stories_resp.status ~= 201 then
		print("Error fetching stories.")
		print(vim.inspect(stories_resp.body))
		return {}
	end

	return whoami_name, vim.fn.json_decode(stories_resp.body)
end

function M.create_branch()
	local whoami_name, stories = M.fetch_stories()

	local story_items = {}
	if stories then
		for _, story in ipairs(stories) do
			table.insert(story_items, {
				id = story.id,
				name = story.name,
			})
		end
	end

	vim.ui.select(story_items, {
		prompt = "Select a Shortcut story",
		format_item = function(item)
			return "sc-" .. item.id .. " " .. item.name
		end,
	}, function(selection)
		if selection then
			local branch_name = whoami_name
				.. "/sc-"
				.. selection.id
				.. "/"
				.. string.lower(selection.name:gsub("[^%w]", "-"))
			vim.fn.system("git checkout -b " .. branch_name)
			vim.notify("Created & checked out branch: " .. branch_name)
		end
	end)
end

return M
