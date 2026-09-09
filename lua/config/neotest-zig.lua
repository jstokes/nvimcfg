local lib = require("neotest.lib")

local M = {
  name = "neotest-zig",
}

--- Find root directory for the test
function M.root(dir)
  return lib.files.match_root_pattern("build.zig", ".git", ".exercism")(dir) or dir
end

--- Determine if a file is a Zig test file
function M.is_test_file(file_path)
  return vim.endswith(file_path, ".zig")
end

--- Discover test positions using Treesitter
function M.discover_positions(path)
  local query = [[
    (test_declaration
      [(identifier) (string)] @test.name
    ) @test.definition
  ]]
  return lib.treesitter.parse_positions(path, query, { nested_namespaces = false })
end

--- Build execution spec for neotest
function M.build_spec(args)
  local pos = args.tree:data()
  local root = M.root(pos.path)
  local has_build = vim.uv.fs_stat(root .. "/build.zig") ~= nil

  local command
  if has_build then
    command = { "zig", "build", "test" }
    if pos.type == "test" then
      local filter = pos.name:gsub('^"', ""):gsub('"$', "")
      vim.list_extend(command, { "--", "--test-filter", filter })
    end
  else
    command = { "zig", "test", pos.path }
    if pos.type == "test" then
      local filter = pos.name:gsub('^"', ""):gsub('"$', "")
      vim.list_extend(command, { "--test-filter", filter })
    end
  end

  return {
    command = command,
    cwd = root,
    context = {
      file = pos.path,
    },
  }
end

--- Parse test results from command output
function M.results(spec, result, tree)
  local results = {}
  local output_data = lib.files.read(result.output) or ""

  for _, node in tree:iter_nodes() do
    local data = node:data()
    if data.type == "test" then
      local test_name = data.name:gsub('^"', ""):gsub('"$', "")
      local escaped = vim.pesc(test_name)

      if output_data:find("test%." .. escaped .. "%.%.%.OK") then
        results[data.id] = {
          status = "passed",
          output = result.output,
        }
      elseif output_data:find("test%." .. escaped .. "%.%.%.SKIP") then
        results[data.id] = {
          status = "skipped",
          output = result.output,
        }
      elseif output_data:find("test%." .. escaped .. "%.%.%.FAIL") then
        local errors = {}
        for file, line, msg in output_data:gmatch("([^:\n]+):(%d+):%d+:%s*([^\n]+ in test%." .. escaped .. ")") do
          table.insert(errors, {
            line = tonumber(line) - 1,
            message = msg,
          })
        end
        results[data.id] = {
          status = "failed",
          output = result.output,
          errors = #errors > 0 and errors or nil,
        }
      else
        results[data.id] = {
          status = result.code == 0 and "passed" or "failed",
          output = result.output,
        }
      end
    elseif data.type == "file" then
      results[data.id] = {
        status = result.code == 0 and "passed" or "failed",
        output = result.output,
      }
    end
  end

  return results
end

return function(opts)
  return M
end
