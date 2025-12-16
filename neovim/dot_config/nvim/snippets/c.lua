local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
    ---------------------------------------
    -- 1. Snippets (General)
    ---------------------------------------

    s({ trig = 'main', dscr = 'C main entry point' },
        fmt([[
        int main(int argc, char **args){{
            {}
            return 0;
        }}]],
            {
                i(1,'// code')
            }
        )
    ),
}
