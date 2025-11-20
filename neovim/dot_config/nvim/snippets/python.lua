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

    s({ trig = 'main', dscr = 'Python main entry point' },
        fmt([[
        if __name__ == "__main__":
            {}
        ]],
            {
                i(1, 'main()'),
            }
        )
    ),

    s({ trig = 'defmain', dscr = 'Python main entry with function' },
        fmt([[
        def {}({}):
            {}

        if __name__ == "__main__":
            {}({})
        ]],
            {
                i(1, 'main'),
                i(2, 'args'),
                i(3, 'pass'),
                f(function(nodes) return nodes[1] end, { 1 }),
                f(function(nodes) return nodes[1] end, { 2 }),
            }
        )
    ),

    s({ trig = 'def', dscr = 'Function definition' },
        fmt([[
        def {}({}):
            {}
            {}
        ]],
            {
                i(1, 'func_name'),
                i(2, 'arg1, arg2'),
                i(3, '"""Docstring"""'),
                i(0),
            }
        )
    ),

    s({ trig = 'cls', dscr = 'Class definition' },
        fmt([[
        class {}({}):
            def __init__(self, {}):
                {}

            {}
        ]],
            {
                i(1, 'ClassName'),
                i(2, 'object'),
                i(3, 'self, arg'),
                i(4, 'self.arg = arg'),
                i(0),
            }
        )
    ),

    s({ trig = 'for', dscr = 'Iterate over a collection' },
        fmt([[
        for {} in {}:
            {}
        ]],
            {
                i(1, 'item'),
                i(2, 'collection'),
                i(0),
            }
        )
    ),

    s({ trig = 'pdb', dscr = 'Pdb breakpoint' },
        t('import pdb; pdb.set_trace()')
    ),

    s({ trig = 'openrb', dscr = 'open a file with rb flag' },
        fmt([[
        with open({},{}) as f:
           {}
        ]],
            {
                i(1, '"file"'),
                i(2, '"rb"'),
                i(3, 'pass'),
            }
        )
    ),

    s({ trig = 'openwb', dscr = 'open a file with wb flag' },
        fmt([[
        with open({},{}) as f:
           {}
        ]],
            {
                i(1, '"file"'),
                i(2, '"wb"'),
                i(3, 'pass'),
            }
        )
    ),

    s({ trig = 'openr', dscr = 'open a file with r flag' },
        fmt([[
        with open({},{}) as f:
           {}
        ]],
            {
                i(1, '"file"'),
                i(2, '"r"'),
                i(3, 'pass'),
            }
        )
    ),

    s({ trig = 'openw', dscr = 'open a file with w flag' },
        fmt([[
        with open({},{}) as f:
           {}
        ]],
            {
                i(1, '"file"'),
                i(2, '"w"'),
                i(3, 'pass'),
            }
        )
    ),

    ---------------------------------------
    -- 2. Snippets (Web Scraping)
    ---------------------------------------

    s({ trig = 'ireqbs', dscr = 'Import requests and BeautifulSoup' },
        t({
            'import requests',
            'from bs4 import BeautifulSoup',
            '# ----------------------------',
        })
    ),

    s({ trig = 'rget', dscr = 'requests.get template' },
        fmt([[
        url = '{}'
        headers = {{
            'User-Agent': '{}'
        }}
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        {}
        ]],
            {
                i(1, 'https://example.com'),
                i(2, 'Mozilla/5.0...'),
                i(0, 'print(response.text)'),
            }
        )
    ),

    s({ trig = 'bsoup', dscr = 'BeautifulSoup initialization' },
        fmt([[
        soup = BeautifulSoup({}, 'html.parser')
        {} = soup.select_one('{}')
        {}
        ]],
            {
                i(1, 'response.text'),
                i(2, 'element'),
                i(3, 'div#main'),
                i(0, 'print(element.text)'),
            }
        )
    ),

    s({ trig = 'wcsv', dscr = 'Write data to CSV file' },
        fmt([[
        import csv

        with open('{}', 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow([{}])
            for row in {}:
                writer.writerow(row)
        ]],
            {
                i(1, 'data.csv'),
                i(2, '"Col1", "Col2"'),
                i(3, 'scraped_data'),
            }
        )
    ),

    ---------------------------------------
    -- 3. Pwn Snippets (Pwntools)
    ---------------------------------------

    s({ trig = 'pwninit', dscr = 'Pwntools basic template' },
        fmt([[
        from pwn import *

        context.update(arch='{}', os='linux')
        context.log_level = '{}'

        HOST = '{}'
        PORT = {}

        def start(argv=[], *a, **kw):
            if args.REMOTE:
                return remote(HOST, PORT)
            else:
                return process([{}], *a, **kw)

        io = start()
        {}

        # io.interactive()
        {}
        ]],
            {
                c(1, { t('amd64'), t('i386') }),
                c(2, { t('info'), t('debug') }),
                i(3, '127.0.0.1'),
                i(4, '1337'),
                i(5, './target'),
                i(6, 'info("Payload construction...")'),
                i(0, 'io.interactive()'),
            }
        )
    ),

    -- Leak/Pack/Unpack
    s({ trig = 'pu', dscr = 'Pack/Unpack functions' },
        fmt([[
        def p(addr):
            return p{} (addr)zR

        def u(data):
            return u{} (data)
        ]],
            {
                c(1, { t('32'), t('64') }),
                rep(1)
            }
        )
    ),

    s({ trig = 'gdbatt', dscr = 'GDB attach' },
        fmt([[
        if args.LOCAL:
            gdb.attach(io, gdbscript='''
                b *{}
                c
            ''')
            pause()
        ]],
            {
                i(1, '0xdeadbeef'),
            }
        )
    ),

    -- Sendline (Pwntools)
    s({ trig = 'sl', dscr = 'io.sendline()' },
        fmt([[
        io.sendline({})
        ]],
            {
                i(1, 'payload'),
            }
        )
    ),

    -- SendlineAfter (Pwntools)
    s({ trig = 'sla', dscr = 'io.sendline()' },
        fmt([[
        io.sendlineafter({}, {})
        ]],
            {
                i(1, 'after'),
                i(2, 'payload'),
            }
        )
    ),

    -- Send (Pwntools)
    s({ trig = 's', dscr = 'io.sendline()' },
        fmt([[
        io.send({})
        ]],
            {
                i(1, 'payload'),
            }
        )
    ),

    -- SendAfter (Pwntools)
    s({ trig = 'sa', dscr = 'io.sendline()' },
        fmt([[
        io.sendafter({}, {})
        ]],
            {
                i(1, 'after'),
                i(2, 'payload'),
            }
        )
    ),
}
