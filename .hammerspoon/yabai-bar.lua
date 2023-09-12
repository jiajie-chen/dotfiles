-- https://github.com/kcmyang/yabai-bar
require("hs.ipc")

local YabaiBar = {}

-- Constructor.
-- Params:
--   exec - the absolute path of the yabai executable to use
--   showEmptySpaces - whether to display indicators for empty, non-visible spaces (default: true)
function YabaiBar:new(exec, showEmptySpaces, showInactiveSpaces)
    local yabaiBar = {
        bar = hs.menubar.new(true, "YabaiBar"),
        exec = exec,
        spaces = {},
        -- https://www.reddit.com/r/lua/comments/b2fekt/function_with_optional_boolean_parameter/eisq0y3/
        showEmptySpaces = showEmptySpaces ~= false,
        showInactiveSpaces = showInactiveSpaces ~= false,
        focusedStyle = {
            font = hs.styledtext.defaultFonts.menuBar,
            underlineStyle = hs.styledtext.lineStyles.thick
        },
        visibleStyle = {
            font = hs.styledtext.defaultFonts.menuBar,
            underlineStyle = hs.styledtext.lineStyles.single
        },
        hasWindowsStyle = {
            font = hs.styledtext.defaultFonts.menuBar,
            underlineStyle = (
                hs.styledtext.lineStyles.single
                | hs.styledtext.linePatterns.dot
            )
        },
        noWindowsStyle = {
            font = hs.styledtext.defaultFonts.menuBar
        },
        separator = hs.styledtext.new(" / ", {
            font = hs.styledtext.defaultFonts.menuBar
        })
    }

    self.__index = self

    return setmetatable(yabaiBar, self)
end

-- Updates the bar by querying yabai.
function YabaiBar:update()
    hs.task.new(self.exec, function(exitCode, stdOut, _)
        if exitCode ~= 0 then return end

        local spaces = hs.json.decode(stdOut)

        if #spaces == 0 then return end

        -- List of space numbers as hs.styledtext items
        local styledNums = {}

        for i = 1, #spaces do
            if spaces[i]["has-focus"] then
                -- Focused
                table.insert(styledNums, hs.styledtext.new(i, self.focusedStyle))
            elseif spaces[i]["is-visible"] then
                -- Not focused, but visible
                table.insert(styledNums, hs.styledtext.new(i, self.visibleStyle))
            elseif spaces[i]["first-window"] ~= 0 and self.showInactiveSpaces then
                -- Not visible, but with windows showing
                table.insert(styledNums, hs.styledtext.new(i, self.hasWindowsStyle))
            elseif self.showEmptySpaces then
                -- No windows showing
                table.insert(styledNums, hs.styledtext.new(i, self.noWindowsStyle))
            end
        end

        -- Text to display, as a hs.styledtext item
        local disp = styledNums[1]

        for i = 2, #styledNums do
            disp = disp .. self.separator .. styledNums[i]
        end

        self.bar:setTitle(disp)
    end, {"-m", "query", "--spaces"}):start()
end

return YabaiBar
