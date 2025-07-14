return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
	},
	event = "VeryLazy",
	config = function()
		local dap = require("dap")
		local map = vim.keymap
		map.set("n", "<Leader>dc", dap.continue, { desc = " Dap: Continue" })
		map.set("n", "<Leader>do", dap.step_over, { desc = " Dap: Step Over" })
		map.set("n", "<Leader>di", dap.step_into, { desc = " Dap: Step Into" })
		map.set("n", "<leader>du", dap.step_out, { desc = " Dap: Setp Out" })
		map.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = " Dap: Toggle Breakpoint" })
		map.set("n", "<Leader>df", "<cmd>FzfLua dap_breakpoints<cr>", { desc = " Dap: Breakpoint List" })
		map.set("n", "<Leader>dp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point massage: "))
		end, { desc = "Dap: Set Breakpoint" })
		map.set("n", "<Leader>dr", dap.repl.open, { desc = "Dap: Repl Open" })
		map.set("n", "<leader>dl", dap.run_last, { desc = "Dap: run last" })
		map.set("n", "<leader>dt", dap.terminate, { desc = "Dap: Dap Terminate" })

		dap.adapters["rust-gdb"] = {
			type = "executable",
			command = "rust-gdb",
			args = { "--interpreter=dap" },
		}
		dap.adapters["gdb"] = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}
		dap.configurations.rust = {
			{
				-- 这个名字可以自定义，方便你区分
				name = "Launch (rust-gdb)",
				type = "rust-gdb",
				request = "launch",
				program = function()
					-- 0. 运行'cargo build'生成二进制目标文件
					vim.fn.system("cargo build")
					-- 1. 运行 'cargo metadata' 并获取 JSON 输出
					local cargo_metadata_json = vim.fn.system("cargo metadata --no-deps --format-version 1")
					if vim.v.shell_error ~= 0 then
						vim.notify("Error running 'cargo metadata': " .. cargo_metadata_json, vim.log.levels.ERROR)
						return nil
					end
					-- 2. 解析 JSON
					local cargo_metadata = vim.fn.json_decode(cargo_metadata_json)
					-- 3. 直接从元数据中获取项目根目录
					local project_root = cargo_metadata.workspace_root
					-- 4. 寻找二进制目标文件的名字
					local executable_name = nil
					-- 我们只关心工作区的成员包
					for _, member_id in ipairs(cargo_metadata.workspace_members) do
						for _, package in ipairs(cargo_metadata.packages) do
							if package.id == member_id then
								for _, target in ipairs(package.targets) do
									-- 找到第一个 kind 为 "bin" 的目标
									if target.kind[1] == "bin" then
										executable_name = target.name
										break
									end
								end
							end
							if executable_name then
								break
							end
						end
						if executable_name then
							break
						end
					end
					if not executable_name then
						vim.notify("没有找到可执行文件，请手动输入路径", vim.log.levels.ERROR)
						return vim.fn.input("Path to executable: ", "../target/debug/", "file")
					end
					-- 5. 构建并返回最终路径
					local exec_path = vim.fs.joinpath(project_root, "target", "debug", executable_name)
					vim.notify("DAP launching: " .. exec_path, vim.log.levels.INFO)
					return exec_path
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				-- 如果需要传递命令行参数，可以取消注释
				-- args = function()
				--   local new_args = vim.split(vim.fn.input("Arguments: "), " ")
				--   return new_args
				-- end,
			},
		}
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.c = dap.configurations.cpp
		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "󰃤", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "󰌑", texthl = "DapLogPoint", linehl = "", numhl = "" })
		sign("DapRejectedBreakpoint", { text = "󰚦", texthl = "DapRejectedBreakpoint", linehl = "", numhl = "" })
		sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

		require("nvim-dap-virtual-text").setup({
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = false, -- prefix virtual text with comment string
			only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
			all_references = false, -- show virtual text on all all references of the variable (not only definitions)
			clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
			--- A callback that determines how a variable is displayed or whether it should be omitted
			--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
			--- @param buf number
			--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
			--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
			--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
			--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
			display_callback = function(variable, buf, stackframe, node, options)
				-- by default, strip out new line characters
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value:gsub("%s+", " ")
				else
					return variable.name .. " = " .. variable.value:gsub("%s+", " ")
				end
			end,
			-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
			virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

			-- experimental features:
			all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
		})

		require("dapui").setup()
		local dapui = require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
