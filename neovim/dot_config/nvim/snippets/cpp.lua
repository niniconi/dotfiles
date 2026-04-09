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

    s({ trig = 'main', dscr = 'CPP main entry point' },
        fmt([[
        int main(int argc, char **args){{
            {}
            return 0;
        }}]],
            {
                i(1, '// code')
            }
        )
    ),

    ---------------------------------------
    -- 2. Snippets (OI)
    ---------------------------------------
    s({ trig = 'oi-cf', dscr = 'codeforeces template' },
        fmt([[
#include<bits/stdc++.h>
using namespace std;
typedef unsigned long long ull;
typedef long long ll;

void solve(){{
    {}
}}

int main(int argc, char **args){{
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  int t;
  cin >> t;
  for (int i = 0;i < t;i++)
    solve();
  return 0;
}}
]],
            {
                i(1, '// code')
            }
        )
    ),
}
